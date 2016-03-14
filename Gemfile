source "https://rubygems.org"
gemspec

group :development do
  gem "guard", require: false
  gem "guard-rubocop", require: false
  gem "guard-rspec", require: false
end

group :test do
  # Temporary fix for rubocop rake 11 incompatibility
  # https://github.com/bbatsov/rubocop/pull/2931
  gem "rake", "< 11.0.0"

  gem "simplecov", require: false
  gem "coveralls", require: false
  gem "codeclimate-test-reporter", require: false
  gem "rubocop", require: false
end

instance_eval(File.read("Gemfile.local")) if File.exist? "Gemfile.local"
