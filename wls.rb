#!/usr/bin/env ruby
# Id$ nonnax 2021-12-12 19:16:55 +0800
require 'gdbm'
require 'rubytools/string_ext'

key=ARGV.first

GDBM.open('wup.db') do |db| 
  db
    .to_h
    .keys
    .select{|k| /#{key}/.match(k)}
    .each do |like_key|
      puts like_key
      puts "-[#{like_key.split(':').first}]".rjust(80, '-')
      
      v=db[like_key]
      v=v.decode64 if like_key.match(/^safe/)
      puts v
      puts    
    end
end
