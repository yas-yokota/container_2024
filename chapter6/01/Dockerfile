FROM ubuntu

RUN  apt-get update && \
     apt-get install -y systemd \
     openssh-server \
  && sed -i 's/^#Pass/Pass/g' /etc/ssh/sshd_config \
  && useradd -m dummy \
  && echo "dummy:dummy123" | chpasswd

EXPOSE 22

CMD  ["/sbin/init"]
