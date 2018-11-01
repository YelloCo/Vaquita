FROM ruby:2.5

ENV RAILS_ENV production

RUN apt-get update -qq
RUN apt-get install -y build-essential sqlite3 libsqlite3-dev

WORKDIR /var/www/vaquita
ADD . /var/www/vaquita

RUN gem install bundler --no-doc
RUN bundle install --without development test
RUN bundle exec rake db:setup

EXPOSE 80
