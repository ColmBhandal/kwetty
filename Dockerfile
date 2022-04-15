FROM runtimeverificationinc/kframework-k:ubuntu-focal-release

#Install SSH but remove the default config - we'll load in our own one later with password logon enabled
#Install Nano (why not)
#Create a user called "kdoctor" with password "k"
RUN apt-get install -y ssh && rm /etc/ssh/sshd_config && apt-get install -y nano && useradd -m -s /bin/bash kdoctor && echo "kdoctor:k"|chpasswd && usermod -aG sudo kdoctor

#Inject the ssh settings from this repo (earlier we deleted the default ones)
ADD sshd_config /etc/ssh

#Start ssh before bash, so that the other service can ssh into this one
ENTRYPOINT service ssh restart && bash