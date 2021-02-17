FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y build-essential nodejs
RUN mkdir /myproject
WORKDIR /myproject
COPY Gemfile /myproject/Gemfile
COPY Gemfile.lock /myproject/Gemfile.lock
RUN bundle install
COPY . /myproject

RUN curl https://deb.nodesource.com/setup_12.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y nodejs yarn postgresql-client