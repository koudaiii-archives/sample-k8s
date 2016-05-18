FROM gliderlabs/alpine:3.2
MAINTAINER Seigo Uchida <spesnova@gmail.com> (@spesnova)

ENV ENTRYKIT_VERSION 0.4.0
EXPOSE 8080

WORKDIR /

# Install Entrykit
RUN apk-install openssl nginx \
      && rm -rf /var/cache/apk/* \
      && wget https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
      && tar -xvzf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
      && rm entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
      && mv entrykit /bin/entrykit \
      && chmod +x /bin/entrykit \
      && entrykit --symlink

COPY ./nginx.conf.tmpl /etc/nginx/nginx.conf.tmpl

ENTRYPOINT ["render", "/etc/nginx/nginx.conf", "--", "/usr/sbin/nginx"]
