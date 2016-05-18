FROM ruby:2.3.0-slim
MAINTAINER Seigo Uchida <spesnovaQuickRuniita.com> (@spesnova)

WORKDIR /app
EXPOSE 3000
RUN groupadd -r app && useradd -r -g app app

#
# Install nodejs
#   ref: https://github.com/nodejs/docker-node/blob/master/4.1/slim/Dockerfile
#
# gpg keys listed at https://github.com/nodejs/node
RUN set -ex \
  && for key in \
    9554F04D7259F04124DE6B476D5A82AC7E37093B \
    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    0034A06D9D9B0064CE8ADF6BF1747F4AD2306D93 \
    FD3A5288F042B6850C66B31F09FE44734EB7990E \
    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
  ; do \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
  done

ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_VERSION 4.1.1

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
  && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
  && gpg --verify SHASUMS256.txt.asc \
  && grep " node-v$NODE_VERSION-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c - \
  && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-x64.tar.gz" SHASUMS256.txt.asc


#
# Install application dependencies
#   ref: https://github.com/docker-library/mysql/blob/master/5.6/Dockerfile
#
RUN apt-get update \
  && apt-get install -y \
    build-essential \
    libpq-dev \
  && rm -rf /var/lib/apt/lists/*


#
# Install rubygems
#
COPY Gemfile      /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install -j4


#
# Add source and precompile assets
#
COPY . /app
RUN RAILS_ENV=production bundle exec rake assets:precompile \
  && chown -R app:app /app

USER app
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
