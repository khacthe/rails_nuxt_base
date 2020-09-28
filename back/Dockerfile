FROM ruby:2.6.6

ENV NODE_VERSION 10

RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - && \
  apt-get install -y nodejs && \
  rm -rf /var/lib/apt/lists/*

RUN apt-get update \
  && apt-get install -y \
  zlib1g-dev \
  build-essential \
  libssl-dev \
  libreadline-dev \
  libyaml-dev \
  libsqlite3-dev \
  libxml2-dev \
  libxslt1-dev \
  libcurl4-openssl-dev \
  libffi-dev \
  git-core \
  vim \
  imagemagick

RUN apt-get update -qq && \
  apt-get install -y build-essential \
  default-libmysqlclient-dev \
  default-mysql-client \
  xvfb \
  redis-tools && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  lsof 
RUN gem install bundler
RUN apt-get clean autoclean \
  && apt-get autoremove -y \
  && rm -rf \
    /var/lib/apt \
    /var/lib/dpkg \
    /var/lib/cache \
    /var/lib/log

ENV APP_ROOT /app/webapp
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT

COPY Gemfile Gemfile.lock ./
RUN bundle install

ADD . ./
CMD bundle exec rails s -p 3000 -b '0.0.0.0'