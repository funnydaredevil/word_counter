FROM ubuntu:14.04

RUN apt-get update && apt-get install -y curl

# == Install Packages for Ruby Environments.
RUN sudo apt-get update
RUN sudo apt-get install -y software-properties-common wget vim build-essential openssl \
    libreadline6 libreadline6-dev curl git-core \
    zlib1g zlib1g-dev libssl-dev libyaml-dev libxml2-dev libxslt-dev autoconf automake cmake \
    libtool imagemagick libmagickwand-dev libpcre3-dev language-pack-zh-hans libevent-dev \
    libgmp-dev libgmp3-dev redis-tools nodejs htop


# Clean apt-get
RUN \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN curl https://get.acme.sh | sh

# == Install Ruby
ENV RUBY_VERSION "2.5.1"
RUN echo 'gem: --no-document' >> /usr/local/etc/gemrc &&\
  mkdir /src && cd /src && git clone https://github.com/rbenv/ruby-build.git --depth 1 &&\
  cd /src/ruby-build && ./install.sh &&\
  cd / && rm -rf /src/ruby-build &&\
  ruby-build $RUBY_VERSION /usr/local/
RUN gem install bundler

# == Install Nginx
RUN curl -sSL https://git.io/vVHhf | bash

ENV GEM_HOME /usr/local/bundle
ENV BUNDLE_PATH="$GEM_HOME" \
  BUNDLE_BIN="$GEM_HOME/bin" \
  BUNDLE_SILENCE_ROOT_WARNING=1 \
  BUNDLE_APP_CONFIG="$GEM_HOME"
ENV PATH $BUNDLE_BIN:$PATH
RUN mkdir -p "$GEM_HOME" "$BUNDLE_BIN" \
  && chmod 777 "$GEM_HOME" "$BUNDLE_BIN"

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV HOME=/var/www/word_counter PATH=/var/www/word_counter/bin:$PATH

WORKDIR /var/www/word_counter
