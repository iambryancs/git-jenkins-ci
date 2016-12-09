FROM node:4-onbuild
MAINTAINER Bryan CS <yanser25@gmail.com>

ADD . /var/www/srv

WORKDIR /var/www/srv

RUN npm install

RUN chmod +x ./script/test.sh
RUN ./script/test.sh

CMD ["nodejs", "app.js"]
