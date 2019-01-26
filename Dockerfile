FROM alpine:3.8

MAINTAINER didlich <didlich@t-online.de>

ENV HUGO_USER hugo
ENV HUGO_GROUP hugo

ENV HUGO_VERSION=0.17
RUN apk add --update su-exec wget ca-certificates && \
  cd /tmp/ && \
  wget https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
  tar xzf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
  rm -r hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
  mv hugo*/hugo* /usr/bin/hugo && \
  apk del wget ca-certificates && \
  rm /var/cache/apk/*

## create user
RUN addgroup -S "${HUGO_GROUP}" && \
    adduser -D -H -s /bin/false -S -G "${HUGO_USER}" "${HUGO_GROUP}"

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x  /docker-entrypoint.sh

VOLUME /src
VOLUME /dst

EXPOSE 1313 8082

WORKDIR /src
ENTRYPOINT ["/docker-entrypoint.sh"]

