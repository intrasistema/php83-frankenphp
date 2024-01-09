FROM dunglas/frankenphp
MAINTAINER Maximiliano Contartesi @ TECNOGO

COPY Caddyfile /etc/caddy/Caddyfile
COPY . /app

RUN cp $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini; \
    sed -i 's/variables_order = "GPCS"/variables_order = "EGPCS"/' $PHP_INI_DIR/php.ini;

RUN install-php-extensions \
    mysqli \
    zip \
    grpc \
    intl \
    bcmath \
    sockets \
    protobuf \
    imap \
    soap \
    opcache

HEALTHCHECK --timeout=5s CMD curl --silent --fail http://127.0.0.1:80