# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG DEFAULT_PORT=3000

FROM ruby:3.2.4

# Rails app lives here
WORKDIR /docker/rails

# Set production environment
# TODO Figure out why the production env not working bruh
# ENV RAILS_ENV "production"
ENV RAILS_ENV "test"

RUN apt-get update && apt-get install -y nodejs;

RUN gem install bundler

COPY Gemfile* ./

RUN bundle

ADD . /docker/rails

EXPOSE ${DEFAULT_PORT}

CMD ["rails", "s", "-b", "0.0.0.0"]
