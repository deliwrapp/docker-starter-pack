ARG DEBIAN_VERSION

FROM debian:${DEBIAN_VERSION}

ENV HTTPD_PREFIX /usr/local/apache2
ENV PATH $HTTPD_PREFIX/bin:$PATH
RUN mkdir -p "$HTTPD_PREFIX" \
    && chown www-data:www-data "$HTTPD_PREFIX"
WORKDIR $HTTPD_PREFIX

RUN apt-get update && apt-get install -y --no-install-recommends apache2 curl
RUN rm -r /var/lib/apt/lists/*
RUN a2enmod proxy_fcgi ssl rewrite proxy proxy_balancer proxy_http proxy_ajp

RUN sed -i '/Global configuration/a \
ServerName localhost \
' /etc/apache2/apache2.conf

COPY ./vhosts/app.local.conf /etc/apache2/sites-available/app.local.conf
RUN apache2ctl configtest
#RUN /etc/init.d/apache2 reload apache2

RUN a2dissite 000-default.conf
RUN a2ensite app.local.conf
RUN /etc/init.d/apache2 restart apache2

EXPOSE 80 443
RUN rm -f /run/apache2/apache2.pid
CMD ["apachectl", "-D", "FOREGROUND", "-e", "info"]
