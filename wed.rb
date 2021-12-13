#!/usr/bin/env ruby
# Id$ nonnax 2021-12-12 19:35:05 +0800
require_relative 'wup/wup'

key=PIPE_ARGV().dup

exit if key.nil?
key.chomp!

Wup.new.edit(key) do |text|
  IO.editor(text).chomp
end
