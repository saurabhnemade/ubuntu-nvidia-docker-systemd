FROM jrei/systemd-ubuntu:18.04

RUN apt-get update

RUN apt-get install -y apache2
RUN systemctl enable systemd-user-sessions.service

RUN apt-get install -y sudo
RUN apt-get install -y openssh-server passwd
RUN mkdir /var/run/sshd
RUN useradd -d /home/user user
RUN mkdir -p /home/user
RUN chmod 777 /home/user
RUN echo 'user:newpass' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN echo "user ALL=NOPASSWD:ALL" > /etc/sudoers.d/user

EXPOSE 22
