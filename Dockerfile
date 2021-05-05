FROM ruby:3.0.1
WORKDIR /opt/propersso
COPY Gemfile Gemfile.lock /opt/propersso
COPY package.json yarn.lock /opt/propersso
# Install Yarn.
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn
RUN bundle install
RUN yarn install --production
COPY . /opt/propersso
RUN bundle exec rake webpacker:install
RUN bundle exec rake yarn:install
RUN rails db:migrate
# Set "rails server -b 0.0.0.0" as the command to
# run when this container starts.
CMD ["rails", "server", "-b", "0.0.0.0"]


# docker build -t propersso .
# docker run -dp 3000:3000 propersso
# docker run -it --name running-propersso propersso