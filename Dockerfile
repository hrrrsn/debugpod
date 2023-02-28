FROM registry.redhat.io/rhel9/support-tools

RUN yum --disableplugin=subscription-manager install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm \ 
    && yum --disableplugin=subscription-manager -y upgrade \
    && yum --disableplugin=subscription-manager -y install nginx openssh-server openssh-clients openssh rsync supervisor \
  && yum --disableplugin=subscription-manager clean all \
  && ssh-keygen -A && echo "UsePrivilegeSeparation no" >> /etc/ssh/sshd_config
  
EXPOSE 80

# USER 1001

# RUN chmod 0777 /run/php-fpm /var/lib/nginx /var/lib/nginx/tmp /run

COPY supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
