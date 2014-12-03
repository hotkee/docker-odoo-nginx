FROM ubuntu:14.04
MAINTAINER Renzo Meister <rm@jamotion.ch>

RUN apt-get update
RUN apt-get install -y --no-install-recommends nginx

RUN chown -R www-data:www-data /var/lib/nginx
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

# Define mountable directories.
VOLUME ["/etc/nginx/sites-available","/etc/nginx/sites-available", "/etc/nginx/certs", "/var/log/nginx"]

ADD logger.conf /etc/nginx/conf.d/logger.conf
ADD buffer.conf /etc/nginx/conf.d/buffer.conf
ADD jamo-nginx /usr/local/bin/jamo-nginx
RUN chmod a+x /usr/local/bin/jamo-nginx

# Define default command.
CMD ["/usr/local/bin/jamo-nginx"]

# Expose ports.
EXPOSE 80
EXPOSE 443
