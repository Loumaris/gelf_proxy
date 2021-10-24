FROM ruby:3.0.2

EXPOSE 4567

WORKDIR /app

ADD . /app

RUN bundle install

CMD ["bundle", "exec", "rackup", "config.ru", "-p", "4567", "-o", "0.0.0.0"]