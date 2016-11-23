FROM node:4-onbuild
MAINTAINER Bryan CS <yanser25@gmail.com>

ADD . /var/www/srv

WORKDIR /var/www/srv

RUN npm install

CMD ["nodejs", "app.js"]
