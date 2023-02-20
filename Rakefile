

task default: %w[build]

desc "Bundle install dependencies"
task :bundle do
  sh "bundle install"
end

desc "Build the wup.gem file"
task :build do
  sh "gem build wup.gemspec"
end

desc "install wup-x.x.x.gem"
task install: %w[build] do
  sh "gem install $(ls wup-*.gem)"
end
