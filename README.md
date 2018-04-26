# Test task, a twitter client

This app has been built as a test task. It is a simple twitter client, written in Ruby with sinatra framework. It can fetch tweets by queries.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Requirements

You need to have ruby 2.3 or later intalled on your machine to run this app. Also you need the gem `bundler` installed.`

```
gem install bundler
```

### Installing

Clone the project. Go to the root directory and install all dependencies by running

```
bundle install
```

If you don't have a twitter application registered, then you need to create one here https://apps.twitter.com/app/new.
Add credentials of your twitter application to the `.env` file in the root directory of the project

```
CONSUMER_KEY=your_app_key
CONSUMER_SECRET=your_app_secret
```

Run the project

```
bundle exec ruby application.rb
```

Go to http://localhost:4567/ to use it.

## Running the tests

```
bundle exec rspec spec
```

## Deployment

You can use puma, unicorn or whatever server you like to run the app in production.
