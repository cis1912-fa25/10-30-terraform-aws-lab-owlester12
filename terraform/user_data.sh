# Exit immediately on error
set -e

# Install Docker if not already installed
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user

# Login to ECR
aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${ecr_repo_url}

# Pull the Docker image
docker pull ${ecr_repo_url}:latest

# Run the container (adjust ports as needed)
docker run -d -p 80:80 ${ecr_repo_url}:latest
