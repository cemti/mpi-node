FROM ubuntu

RUN echo 'root:root' | chpasswd
RUN apt-get update && apt-get install -y mpich iputils-ping curl nano openssh-server

RUN sed -ri 's/^#PermitRootLogin.+/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo StrictHostKeyChecking no >> /etc/ssh/ssh_config

RUN ssh-keygen -b 2048 -t rsa -f /root/.ssh/id_rsa -q -N ""
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

EXPOSE 22

RUN mkdir /var/run/sshd
CMD /usr/sbin/sshd -D