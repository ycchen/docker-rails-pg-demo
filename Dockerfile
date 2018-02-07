# # ./Dockerfile

# FROM phusion/passenger-ruby23

# # set the app directory var
# ENV APP_HOME /home/app
# ENV BUNDLE_PATH /bundle

# WORKDIR $APP_HOME

# RUN apt-get update -qq

# # Install apt dependencies
# RUN apt-get install -y --no-install-recommends \
#   build-essential \
#   curl libssl-dev \
#   git \
#   unzip \
#   zlib1g-dev \
#   libxslt-dev \
#   mysql-client \
#   libpq-dev \
#   nodejs \
#   sqlite3

# # Install bundler
# RUN gem install bundler

# # Separate task from `add ..` as it will be skipped if gemfile.lock hasn't changed
# COPY Gemfile* ./

# #Install gems to /bundle
# RUN bundle install

# COPY . .

# EXPOSE 3000

# CMD ["/sbin/my_init"]
FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /deep_space_9
WORKDIR /deep_space_9
COPY Gemfile /deep_space_9/Gemfile
COPY Gemfile.lock /deep_space_9/Gemfile.lock
RUN bundle install
COPY . /deep_space_9