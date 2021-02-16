FROM nginx:1.19.6

RUN rm -f /etc/nginx/conf.d/*

ADD nginx.conf /etc/nginx/conf.d/myproject.conf

CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf