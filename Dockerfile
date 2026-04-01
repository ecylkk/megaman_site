# syntax = docker/dockerfile:1
ARG RUBY_VERSION=3.4-slim
FROM registry.docker.com/library/ruby:$RUBY_VERSION as base

WORKDIR /rails

# Install packages needed for build and deployment
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    git \
    pkg-config \
    libvips-dev \
    libsqlite3-dev \
    libyaml-dev \
    curl \
    libpq-dev \
    shared-mime-info && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Ensure Bundler is installed and gem paths are correct
ENV GEM_HOME="/usr/local/bundle"
ENV BUNDLE_PATH="$GEM_HOME" \
    BUNDLE_BIN="$GEM_HOME/bin" \
    BUNDLE_APP_CONFIG="$GEM_HOME"
ENV PATH="$BUNDLE_BIN:$PATH"

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

# Copy application code
COPY . .

# Fix line endings
RUN sed -i 's/\r$//' bin/*

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
