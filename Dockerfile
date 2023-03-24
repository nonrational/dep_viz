FROM hexpm/elixir:1.14.3-erlang-24.3.4.10-ubuntu-trusty-20191217

RUN apt-get update
RUN apt-get install -y curl build-essential

# Install python2
RUN curl -sL https://gist.githubusercontent.com/pigeonflight/39e7513e46b419b8b51f8671445c4ea2/raw/baf8f006972791d10d4956161374ac5b39172b98/install-python-2.7.14.sh | bash -

# Install Node.js 12.x
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y --force-yes nodejs

# Set the working directory
WORKDIR /app
COPY . .

WORKDIR /app/assets
# RUN npm i -g n
# RUN n 12
RUN npm install

WORKDIR /app
# Install dependencies
RUN mix local.hex --force && mix local.rebar --force
RUN mix deps.get

# Expose the application port
EXPOSE 4040

# Start the application
CMD ["mix", "phx.server"]
