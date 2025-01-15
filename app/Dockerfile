#checkov:skip=CKV_DOCKER_2:Health check is defined in the Helm chart.

# Use an official Python runtime as a parent image
FROM python:3.11-slim

RUN useradd -m appuser
USER appuser

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip3 install -r requirements.txt

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Run app.py when the container launches
CMD ["python", "app.py"]
