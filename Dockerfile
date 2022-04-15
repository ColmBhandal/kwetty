FROM runtimeverificationinc/kframework-k:ubuntu-focal-release

RUN apt-get install -y ssh && rm /etc/ssh/sshd_config && apt-get install -y nano && useradd -m -s /bin/bash kdoctor && echo "kdoctor:k"|chpasswd && usermod -aG sudo kdoctor
ADD sshd_config /etc/ssh

ENTRYPOINT service ssh restart && bash