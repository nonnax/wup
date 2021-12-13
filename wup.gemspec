files=%w[README.md
wup/wup.rb
bin/wed
bin/wgrep
bin/win
bin/wkeys
bin/wls
bin/wq
bin/wrm
bin/wview
bin/wviewz
wup.gemspec
]

Gem::Specification.new do |s|
  s.name = 'wup'
  s.version = '0.0.1'
  s.date = '2021-12-12'
  s.summary = "Wup - a CLI (markdown) journal"
  s.authors = ["xxanon"]
  s.email = "ironald@gmail.com"
  s.files = files
  s.executables += %w[wed wgrep win wkeys wls wq wrm wview wviewz]
  s.homepage = "https://github.com/nonnax/wup.git"
  s.license = "GPL-3.0"
end
