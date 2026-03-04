FROM nginx:1.29-alpine AS base
EXPOSE 80

COPY static /usr/share/nginx
# shared 
COPY scripts /etc/nginx/scripts
COPY static /usr/share/nginx/static

RUN sed -i '1iload_module modules/ngx_http_js_module.so;' /etc/nginx/nginx.conf
RUN mkdir -p /etc/nginx/scripts /usr/share/nginx/static

# prod
FROM base AS prod
COPY app.conf /etc/nginx/conf.d/app.conf

# staging
FROM base AS staging
COPY app-staging.conf /etc/nginx/conf.d/app.conf