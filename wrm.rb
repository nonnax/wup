#!/usr/bin/env ruby
# Id$ nonnax 2021-12-12 22:01:16 +0800
require 'gdbm'
require 'rubytools/pipe_argv'

key=PIPE_ARGV().dup

exit unless key
key.chomp!

GDBM.open('wdb.db') do |db|
   p db.delete(key) if db.key?(key) 
   db.reorganize
end
