FROM nginx:1.29-alpine
EXPOSE 80
COPY static /usr/share/nginx
RUN sed -i '1iload_module modules/ngx_http_js_module.so;' /etc/nginx/nginx.conf
