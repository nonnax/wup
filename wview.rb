#!/usr/bin/env ruby
# Id$ nonnax 2021-12-12 19:16:55 +0800
require_relative 'wup/wup'

key=PIPE_ARGV().dup

exit if key.nil?
key.chomp! if key

Wup.new.tap do |wup|
  if wup.key?(key)
    puts key
    puts "-[#{key.split(':').first}]".rjust(80, '-')
    puts wup.to_dec( key, wup[key] )
  end
  puts
end
