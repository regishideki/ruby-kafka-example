FROM ruby

VOLUME /app
COPY Gemfile Gemfile.lock /app/
WORKDIR /app

RUN bundle install

COPY . .
