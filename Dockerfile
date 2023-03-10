FROM registry.access.redhat.com/ubi9/ubi

RUN yum --disableplugin=subscription-manager install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm \ 
    && yum --disableplugin=subscription-manager -y upgrade \
    && yum --disableplugin=subscription-manager -y install nginx openssh-server openssh-clients openssh rsync supervisor procps-ng \
  && yum --disableplugin=subscription-manager clean all \
  && ssh-keygen -A && echo "UsePrivilegeSeparation no" >> /etc/ssh/sshd_config \
  && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
 
COPY supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
