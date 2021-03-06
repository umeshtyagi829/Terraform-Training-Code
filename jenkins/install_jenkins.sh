 echo "Installing Jenkins"
yum upgrade -y
sudo wget -O /etc/yum.repos.d/jenkins.repo       https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade
sudo yum install -y jenkins java-1.8.0-openjdk
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo systemctl status jenkins