#!/usr/bin/env ruby
task default: %w[build]

desc "Bundle install dependencies"
task :bundle do
  sh "bundle install"
end

desc "Build the wup.gem file"
task build: %w[bundle] do
  sh "gem build wup.gemspec"
end

desc "install wup-0.0.1.gem"
task install: %w[build] do
  sh "sudo gem install wup-0.0.1.gem"
end
