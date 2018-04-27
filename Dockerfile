FROM jenkins/jenkins:lts
MAINTAINER Tomasz Trznadel @trandel

USER root

RUN set -ex; \
apt-get update; \
apt-get install -y lsb-release software-properties-common apt-transport-https; \
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - ; \
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian \
$(lsb_release -cs) stable"; \
apt-get update; \
apt-get install -y ansible git python-pip php7.0-cli php7.0-bcmath php7.0-mysql \
php7.0-mbstring php7.0-dom php7.0-curl php7.0-zip docker-ce; \
pip install awscli docker docker-compose boto3; \
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer; \
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER jenkins
