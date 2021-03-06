FROM ruby:2.6.4

# Required for the scripts in ./bin to know whether or not
# they're running in a docker container
ENV RAILS_ON_DOCKER="YES"

# Install nodejs 11
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash - && \
  apt-get install -y nodejs

# Install postgres client and GNU parallel, needed for development only
RUN apt-get install -y postgresql-client
RUN apt-get install -y parallel
RUN echo "will cite\n" | parallel --citation &>/dev/null # Tell parallel that we will,
                                                         # in fact, cite it if we use
                                                         # it in an academic publication

# Install yarn
RUN npm install --global yarn

# Set up app path
ENV APP_PATH=/app
RUN mkdir -p $APP_PATH

# cd into $APP_PATH
WORKDIR ${APP_PATH}

# Install gems
COPY Gemfile ${APP_PATH}/Gemfile
COPY Gemfile.lock ${APP_PATH}/Gemfile.lock
RUN bundle install

# Install js
COPY package.json ${APP_PATH}/package.json
COPY yarn.lock ${APP_PATH}/yarn.lock
RUN yarn install --check-files


# Copy application files
COPY . /app

COPY bin/entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
