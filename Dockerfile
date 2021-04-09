FROM alpine:3.6

RUN apk add --no-cache \
  bash \
  curl \
  grep \
  jq

COPY merge-request.sh /usr/bin/

CMD ["merge-request.sh"]
