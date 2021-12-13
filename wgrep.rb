#!/usr/bin/env ruby
# Id$ nonnax 2021-12-12 19:16:55 +0800
require_relative 'wup/wup'
require 'ansi_color'

q=PIPE_ARGV().dup

exit if q.nil?
q.chomp!

Wup.new.grep(q) do |k, varr|
  v=varr
    .map{|l| l.gsub(q, q.magenta) }
    .join("\n")

  puts k
  puts "-[#{k.split(':').first}]".rjust(80, '-')
  puts v
  puts
end
