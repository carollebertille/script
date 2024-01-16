#!/bin/bash
# https://www.jenkins.io/doc/book/installing/linux/#debianubuntu
# Please install the Long Term Support release
function jenkins_installation {
    sudo apt update
    ## Set vim as default text editor
    sudo update-alternatives --set editor /usr/bin/vim.basic
    sudo update-alternatives --set vi /usr/bin/vim.basic
    sudo apt install fontconfig openjdk-17-jre -y
    java -version
    curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee   /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]   https://pkg.jenkins.io/debian-stable binary/ | sudo tee   /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update
    sudo apt-get install jenkins -y
    sudo systemctl start jenkins
    sudo systemctl enable jenkins
    INSTANCE_PUBLIC_IP=$(curl -s ifconfig.me)
    ADMIN_KEY=$(cat /var/lib/jenkins/secrets/initialAdminPassword)
    JENKINS_URL="http://$INSTANCE_PUBLIC_IP:8080"
    echo "Jenkins is installed and running. You can access it at $JENKINS_URL"
    echo "This is the initialAdminPassword: $ADMIN_KEY"
}
function docker_installation {

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker
sudo systemctl enable docker
}
jenkins_installation
docker_installation
