#!/usr/bin/env ruby
# Id$ nonnax 2021-12-12 19:16:55 +0800
# require 'gdbm'
# require 'rubytools/string_ext'
# 
require_relative 'wup/wup'

key=ARGV.first

Wup.new.tap do |wup|
  wup 
  .select{|k, v| /#{key}/.match(k)}
  .each do |kmatched, v|
    puts kmatched
    puts "-[#{kmatched.split(':').first}]".rjust(80, '-')
    
    v=wup.to_dec(kmatched, v)
    puts v
    puts    
  end  
end
