FROM alpine:latest

# install nginx
RUN apk --update --no-cache add nginx wget runit

# install consul-template
# RUN wget "http://releases.hashicorp.com/consul-template/0.20.0/consul-template_0.20.0_linux_amd64.tgz"
ADD consul-template_0.20.0_linux_amd64.tgz /usr/local/bin/

ADD nginx.service /etc/service/nginx/run
RUN chmod a+x /etc/service/nginx/run
ADD consul-template.service /etc/service/consul-template/run
RUN chmod a+x /etc/service/consul-template/run

RUN rm -v /etc/nginx/conf.d/*
RUN mkdir -p /run/nginx/
ADD nginx.conf.ctmpl /etc/consul-templates/nginx.conf.ctmpl

ADD nginx.conf /etc/nginx/nginx.conf

CMD ["runsvdir", "/etc/service"]
