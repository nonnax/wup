#!/usr/bin/env ruby
# Id$ nonnax 2021-12-12 19:16:55 +0800
require 'gdbm'
require 'rubytools/pipe_argv'
require 'rubytools/string_ext'

key=PIPE_ARGV().dup

exit if key.nil?
key.chomp! if key

GDBM.open('wdb.db') do |db| 
  if db.key?(key)
    puts key
    puts "-[#{key.split(':').first}]".rjust(80, '-')
    puts (key.match(/safe/) ? db[key].decode64 :  db[key] )
  end
  puts    
end
