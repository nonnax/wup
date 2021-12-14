files=%w[README.md
wup/wup.rb
bin/wup
bin/wed
bin/wgrep
bin/wgrepz
bin/wkeys
bin/wls
bin/wcat
bin/wcatz
bin/wrm
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
  s.executables += %w[wup wed wgrep wgrepz wkeys wls wcat wcatz wrm]
  s.homepage = "https://github.com/nonnax/wup.git"
  s.license = "GPL-3.0"
end
