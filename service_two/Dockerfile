# Use official Ruby image
FROM ruby:3.3.6

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs npm postgresql-client

# Set working directory
WORKDIR /app

# Copy Gemfile and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the app files
COPY . .

# Expose the necessary ports
EXPOSE 3002

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
