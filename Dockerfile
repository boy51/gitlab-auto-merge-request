FROM alpine:3.6

RUN apk add --no-cache \
  bash \
  curl \
  grep \
  jq

COPY merge-request.sh /usr/bin/
COPY merge-request-post-deploy.sh /usr/bin/
RUN ["chmod", "+x", "/usr/bin/merge-request-post-deploy.sh"]

WORKDIR /usr/bin
ENTRYPOINT [ "/bin/bash", "-l", "-c" ]
