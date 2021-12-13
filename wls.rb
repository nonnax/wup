#!/usr/bin/env ruby
# Id$ nonnax 2021-12-12 19:16:55 +0800
# require 'gdbm'
# require 'rubytools/string_ext'
# 
key=ARGV.first

# GDBM.open('wup.db') do |db|
  # db
    # .to_h
    # .keys
    # .select{|k| /#{key}/.match(k)}
    # .each do |kmatched|
      # puts kmatched
      # puts "-[#{kmatched.split(':').first}]".rjust(80, '-')
      # 
      # v=db[kmatched]
      # v=v.decode64 if kmatched.match(/^safe/)
      # puts v
      # puts
    # end
# end

require_relative 'wup/wup'

wup=Wup.new

wup.gdbm do |db|
  db
    .to_h
    .keys
    .select{|k| /#{key}/.match(k)}
    .each do |kmatched|
      puts kmatched
      puts "-[#{kmatched.split(':').first}]".rjust(80, '-')
      
      v=db[kmatched]
      v=wup.to_decode(kmatched, v)
      puts v
      puts    
    end  
end