FROM alpine:edge

#install jq for JSON manipulation
RUN apk update \
 && apk add jq \
 && rm -rf /var/cache/apk/*

RUN addgroup -S aws && adduser -S -G aws aws

RUN set -x\
 && apk --no-cache add --virtual .build-deps\
  py2-pip\
  py-setuptools\
 && apk --no-cache add\
  groff\
  less\
  python2\
 && pip --no-cache-dir install awscli\
 && apk del .build-deps\
 && rm -rf /var/cache/apk/*

USER aws

CMD aws
