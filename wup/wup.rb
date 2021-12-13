#!/usr/bin/env ruby
# Id$ nonnax 2021-12-12 15:55:27 +0800
require 'rubytools'
require 'editor'
require 'gdbm'
require 'fzf'
require 'string_ext'
require 'pipe_argv'

class Wup
  attr_accessor :post
  attr :latest_post_key

  def initialize
    @post={}
    @dbfile='wdb.db'
  end

  def timenow()=Time.now.strftime('%H%M%S')

  def today()=Time.now.strftime('%Y%m%d')

  def get(tag: 'note')
    
    template=<<~___
    date: #{today}
    tag: #{tag}
    ---
    ___

    text=yield template

    header, body=text.split(/[-]{3,}\n/)
    post=header.split(/\n/).map{|e| e.split(/:\s*/,2).map(&:strip) }.to_h
    @post=post.merge!('post'=> body)
    @post=nil if body.to_s.strip.empty?
    save()
  end

  def save
    raise if @post.nil?
    
    gdbm do |db|
      key=@post['tag']
      post_body=@post['post']
      post_body=to_encode(key, post_body)

      db_key=[key, @post['date'], timenow].join(':')
      db[db_key]=post_body
      @latest_post_key=db_key
    end
  rescue => e
    puts "Error: Invalid Post\n#{e}"
  end
  private :save
  
  def latest_post
    self[@latest_post_key]
  rescue
    puts "Not saved #{@latest_post_key}"
  end

  def [](key)
    gdbm{|db| db[key] if db.key?(key)}
  end

  def to_h
    gdbm{|db| db.to_h}
  end

  def keys
    gdbm{|db| db.keys}
  end
  
  def grep(q)
    return if q.empty?
    gdbm do |db| 
      db.to_h
        .select{ |k, v| 
                  /#{q}/.match(v) || ( k.match(/safe/) && /#{q}/.match( to_decode(k, v) ) ) 
          }
        .each do |k, vq|
          vq = to_decode(k, vq)
          val = vq
                .split("\n")
                .select{|l| /#{q}/.match(l) }
          yield(k, val)
        end
    end
  end

  def to_encode(key, text)
    text=text.chomp.encode64 if key.match(/^safe/) && !text.chomp.base64?
    text
  end

  def to_decode(key, text)
    text=text.decode64 if key.match(/^safe/) #&& text.chomp.base64?
    text.chomp
  end
  
  def edit(key)
    text=nil
    gdbm{|db| text=db[key] if db.key?(key) }
    return if text.nil?

    text=to_decode(key, text)

    v=yield( text)
    gdbm do |db| 
      v=to_encode(key, v) 
      db[key]=v if db.key?(key) 
      db.reorganize
    end
  end

  def gdbm(&block)
      GDBM.open(@dbfile, &block)
  end
  private :gdbm
  
end

