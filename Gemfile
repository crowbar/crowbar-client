source "https://rubygems.org"
gemspec

group :development do
  gem "guard", require: false
  gem "guard-rubocop", require: false
  gem "guard-rspec", require: false

  # Temporary fix for a ruby 2.2 requirement
  # https://travis-ci.org/crowbar/crowbar-client/builds/127797633
  gem "listen", "~> 3.0.7"
end

group :test do
  gem "simplecov", require: false
  gem "coveralls", require: false
  gem "codeclimate-test-reporter", require: false
  gem "rubocop", require: false
end

instance_eval(File.read("Gemfile.local")) if File.exist? "Gemfile.local"
