FROM node:10

ENV APP_ROOT /app/webapp
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT

COPY package.json yarn.lock $APP_ROOT/
RUN yarn

COPY . $APP_ROOT/

CMD ["yarn", "run", "dev"]