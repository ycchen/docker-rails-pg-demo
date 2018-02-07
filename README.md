# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* This example is from Docker's quickstart
*  https://docs.docker.com/compose/rails/
```ruby
# Dockerfile
FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /deep_space_9
WORKDIR /deep_space_9
COPY Gemfile /deep_space_9/Gemfile
COPY Gemfile.lock /deep_space_9/Gemfile.lock
RUN bundle install
COPY . /deep_space_9
```

```ruby
touch Gemfile
#Gemfile
source 'https://rubygems.org'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'

touch Gemfile.lock

# create docker-compose.yml
version: '3'
services:
  db:
    image: postgres
  web:
    build: .
    command: bundle exec rails s -p 3000 -b '0.0.0.0'
    volumes:
      - .:/deep_space_9
    ports:
      - "3000:3000"
    depends_on:
      - db
```

```ruby
# run following command to generate rails application
docker-compose run web rails new . --force --database=postgresql

# build the images
docker-compose build

# connect the database, config/database.yml
default: &default
  adapter: postgresql
  encoding: unicode
  host: db
  username: postgres
  password:
  pool: 5

development:
  <<: *default
  database: myapp_development


test:
  <<: *default
  database: myapp_test

# bring up applications
docker-compose up

# create database
docker-compose run web rake db:create

# stop the applciation

docker-compose down

# rebuild the application

docker-compose up --build

```


