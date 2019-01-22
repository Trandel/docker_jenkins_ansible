FROM jenkins/jenkins:lts
MAINTAINER Tomasz Trznadel @trandel

USER root

RUN set -ex; \
apt-get update; \
apt-get install -y lsb-release software-properties-common apt-transport-https; \
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - ; \
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian \
$(lsb_release -cs) stable"; \
add-apt-repository "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main"; \
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367; \
apt-get update; \
apt-get install -y ansible git python-pip php7.0-cli php7.0-bcmath php7.0-mysql \
php7.0-mbstring php7.0-dom php7.0-curl php7.0-zip docker-ce rsync ssh-askpass \
mysql-client jq; \
groupmod -g 497 docker; \
usermod -G docker jenkins; \
pip install awscli docker docker-compose boto3; \
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer; \
mv /etc/localtime /etc/localtime.default; \
cp /usr/share/zoneinfo/Europe/London /etc/localtime; \
mkdir -p /var/jenkins_workspace && chown jenkins: /var/jenkins_workspace; \
echo "jenkins ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/jenkins"; \
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -; \
apt-get install -y nodejs; \
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/var/jenkins_workspace"]

USER jenkins
