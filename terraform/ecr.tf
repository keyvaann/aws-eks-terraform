data "aws_caller_identity" "current" {}

locals {
  prefix              = "git"
  account_id          = data.aws_caller_identity.current.account_id
  ecr_repository_name = "app"
  ecr_image_tag       = "latest"
}

resource "aws_ecr_repository" "repo" {
  name                 = local.ecr_repository_name
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "terraform_data" "ecr_image" {
  triggers_replace = [
    timestamp(), # this will always run, in case of bad internet
    md5(file("../${path.module}/app/app.py")),
    md5(file("../${path.module}/app/Dockerfile")),
    md5(file("../${path.module}/app/requirements.txt")),
  ]

  provisioner "local-exec" {
    working_dir = "../app/"
    command     = <<EOF
            aws ecr get-login-password --region ${var.AWS_REGION} | sudo docker login --username AWS --password-stdin ${local.account_id}.dkr.ecr.${var.AWS_REGION}.amazonaws.com && sudo docker build -t ${aws_ecr_repository.repo.repository_url}:${local.ecr_image_tag} . && sudo docker push ${aws_ecr_repository.repo.repository_url}:${local.ecr_image_tag}
        EOF
  }
}

data "aws_ecr_image" "app_image" {
  depends_on = [
    terraform_data.ecr_image
  ]

  repository_name = local.ecr_repository_name
  image_tag       = local.ecr_image_tag
}
