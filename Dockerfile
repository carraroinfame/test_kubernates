FROM centos:7
MAINTAINER shikhardevops@gmail.com

# Aggiorna i repository per puntare a CentOS Vault
RUN sed -i 's|^mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/CentOS-Base.repo && \
    sed -i 's|^#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Base.repo

# Pulisci la cache e installa httpd, zip, unzip, wget
RUN yum clean all && yum makecache && yum install -y httpd zip unzip wget

# Scarica il file ZIP e lavora nella directory corretta
RUN wget -O /var/www/html/photogenic.zip https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip
WORKDIR /var/www/html/

# Decomprimi il file e sposta i contenuti nella directory corretta
RUN unzip photogenic.zip
RUN cp -rvf photogenic/* .
RUN rm -rf photogenic photogenic.zip

# Esegui Apache in primo piano per mantenere il container attivo
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

# Espone le porte 80 e 443 per HTTP e HTTPS
EXPOSE 80 443