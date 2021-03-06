FROM ruby:2.2.0
MAINTAINER Shashikant jagtap <shashikant.jagtap@aol.co.uk>

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev openjdk-7-jre-headless lib32z1 lib32ncurses5 g++-multilib
RUN apt-get update
RUN apt-get install -y wget

RUN apt-get -y install nodejs
RUN apt-get install -y python-software-properties python g++ make
RUN apt-get install -y bash curl git patch bzip2 build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev libgdbm-dev ncurses-dev automake libtool bison subversion pkg-config libffi-dev libcurl3-dev imagemagick libmagickwand-dev libpcre3-dev
RUN apt-get install -y wget
RUN apt-get install -y nodejs
RUN apt-get install -y npm
RUN apt-get install -y git
RUN apt-get install -y curl
RUN apt-get install -y unzip
RUN apt-get install -y android-tools-adb
RUN apt-get install -y openjdk-7-jre-headless lib32z1 lib32ncurses5 g++-multilib
RUN apt-get install -y vim
RUN apt-get -y install nodejs-legacy
RUN apt-get install -y curl patch gawk g++ gcc make libc6-dev patch libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev
RUN npm install -g phantomjs

RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
RUN bundle install
ADD . /myapp
