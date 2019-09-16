FROM ruby:2.6.4

ENV RAILS_ON_DOCKER=yes

# Install nodejs 11
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash - && \
  apt-get install -y nodejs

# Install gems
RUN mkdir -p /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
WORKDIR /app
RUN bundle install

# Copy application files
COPY . /app

COPY bin/entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
