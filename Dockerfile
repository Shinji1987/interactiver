FROM ruby:2.6.5

RUN apt-get update && \
    apt-get install -y mysql-client nodejs vim --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /interactiver

WORKDIR /interactiver

ADD Gemfile /interactiver/Gemfile
ADD Gemfile.lock /interactiver/Gemfile.lock

RUN gem install bundler
RUN bundle install

ADD . /interactiver

RUN mkdir -p tmp/sockets