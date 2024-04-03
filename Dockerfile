FROM ubuntu:20.04

# Evitez les dialogues interactifs avec apt
ENV DEBIAN_FRONTEND=noninteractive

# Installation des dépendances
RUN apt-get update && apt-get install -y \
    software-properties-common \
    gnupg2 \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-gd \
    nginx \
    unzip \
    wget \
    rsync && \
    add-apt-repository ppa:ondrej/php -y && \
    apt-get update

# Téléchargement et installation de Sentrifugo
RUN wget http://www.sentrifugo.com/home/downloadfile?file_name=Sentrifugo.zip -O Sentrifugo.zip && \
    unzip -o Sentrifugo.zip -d /var/www/html && \
    rm Sentrifugo.zip && \
    mv /var/www/html/Sentrifugo_3.2 /var/www/html/sentrifugo && \
    chown -R www-data:www-data /var/www/html/sentrifugo

# Configuration de Nginx et PHP
RUN echo 'daemon off;' >> /etc/nginx/nginx.conf
COPY votre-fichier-de-configuration-nginx /etc/nginx/sites-available/default
RUN service php7.4-fpm start

EXPOSE 80

CMD ["nginx"]
