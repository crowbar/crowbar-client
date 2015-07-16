source "https://rubygems.org"
gemspec

group :development do
  gem "guard", require: false
  gem "guard-rubocop", require: false
  gem "guard-rspec", require: false
end

group :test do
  gem "simplecov", require: false
  gem "coveralls", require: false
  gem "codeclimate-test-reporter", require: false
  gem "rubocop", require: false
end

instance_eval(File.read("Gemfile.local")) if File.exist? "Gemfile.local"
