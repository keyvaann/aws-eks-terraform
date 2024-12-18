data "sops_file" "flast_app_secrets" {
  source_file = "../flask_app_secrets.enc.json"
}

resource "helm_release" "ingress_nginx" {
  name = "ingress-nginx"

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "default"
  version    = "4.11.3"

  values = [
    <<-EOF
    controller:
      replicaCount: 1
      service:
        annotations:
          service.beta.kubernetes.io/aws-load-balancer-type: nlb
          service.beta.kubernetes.io/aws-load-balancer-scheme: internet-facing
          service.beta.kubernetes.io/aws-load-balancer-backend-protocol: http
          service.beta.kubernetes.io/aws-load-balancer-eip-allocations: ${aws_eip.cluster_loadbalancer_eip.allocation_id}
          service.beta.kubernetes.io/aws-load-balancer-subnets: ${module.vpc.public_subnets[0]}
      config:
        enable-access-log-for-default-backend: "true"
        enable-real-ip: "true"
        use-forwarded-headers: "true"
        server-tokens: "false"
      addHeaders:
        X-Frame-Options: Deny
        X-Xss-Protection: 1; mode=block
        X-Content-Type-Options: nosniff        
    EOF
  ]
}

resource "helm_release" "flask_app" {
  name = "flask-app"

  chart     = "../charts/flask-app"
  namespace = "default"

  values = [
    <<-EOF
    image:
      repository: ${aws_ecr_repository.repo.repository_url}
      tag: latest
    ingress:
      hosts:
      - host: ${aws_eip.cluster_loadbalancer_eip.public_dns}
        paths:
        - path: /
          pathType: ImplementationSpecific

    api_base_url: ${var.flast_app_api_base_url}
    log_level: ${var.flast_app_log_level}
    max_connections: ${var.flast_app_max_connections}
    secret_key: ${data.sops_file.flast_app_secrets.data["secret_key"]}
    db_password: ${data.sops_file.flast_app_secrets.data["db_password"]}
    EOF
  ]
}