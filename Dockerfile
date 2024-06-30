FROM alpine:latest
RUN apk --no-cache --update add bash openssh-client privoxy
ADD privoxy.conf /
ADD entrypoint.sh /
CMD ["bash", "/entrypoint.sh"]
