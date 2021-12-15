#!/usr/bin/env ruby
# Id$ nonnax 2021-12-12 15:55:27 +0800
require 'rubytools'
require 'editor'
require 'gdbm'
require 'fzf'
require 'string_ext'
require 'numeric_ext'
require 'pipe_argv'
require 'fileutils'
require 'yaml'

WUP_ROOT=File.expand_path('~/.wup')

class String
  def to_wup_path
    FileUtils.mkdir_p(WUP_ROOT) unless Dir.exists?(WUP_ROOT)
    [WUP_ROOT, File.basename(self)].join('/')
  end
end

class Wup
  attr_accessor :post
  attr :latest_post_key

  CONFIG='config.yaml'.to_wup_path
  DBFILE='wup.db'.to_wup_path

  def initialize
    @config={'db'=> DBFILE }
    File.exists?(CONFIG) ? @config=YAML.load(File.read(CONFIG)) : File.write(CONFIG, @config.to_yaml)
    @post={}
    @dbfile=@config['db'].to_wup_path
  end

  def backup(tag: 'before')
    Thread.new{ FileUtils.cp @dbfile, @dbfile+".#{tag}.bak" }.join if File.exists?(@dbfile)
  end

  def timenow()=Time.now.to_i.to_base32
  def today()=Time.now.strftime('%Y%m%d')

  def template(date, tag, post="")
    <<~___
    date: #{date}
    tag: #{tag}
    ---
    #{post}
    ___
  end
  
  def get(tag: 'note')
    text=yield template(today, tag)

    header, body=text.split(/[-]{3,}\n/)
    post=header
          .split(/\n/)
          .map{|e| e.split(/:\s*/,2).map(&:strip) }
          .to_h
    @post=post.merge!('post'=> body)
    @post=nil if body.to_s.strip.empty?
    save()
  end

  def save
    raise if @post.nil?
    backup(tag: 'before')
    gdbm do |db|
      key=@post['tag']
      post_body=@post['post']
      post_body=to_enc(key, post_body)

      db_key=[key, @post['date'], timenow].join(':')
      db[db_key]=post_body.strip
      @latest_post_key=db_key
    end
  rescue => e
    puts "Error: Invalid Post\n#{e}"
  ensure
    backup(tag: 'after')
  end
  private :save
  
  def latest_post
    self[@latest_post_key]
  rescue
    puts "Not saved #{@latest_post_key}"
  end

  def [](key)=gdbm{|db| db[key] if db.key?(key)}
  def delete(key)=gdbm{|db| db.delete(key) if db.key?(key) }
  def key?(key)=gdbm{|db| db.key?(key)}
  def keys()=gdbm{|db| db.keys}
  def reorganize()=gdbm{|db| db.reorganize }
  def select(&block)=gdbm{|db| db.select(&block) }
  def to_h()=gdbm{|db| db.to_h}
  def values_at(*a)=gdbm{|db| db.values_at(*a)}
  
  def grep(q)
    return if q.empty?
    query=/#{q}/i
    gdbm do |db| 
      db.to_h
        .select do |k, v| 
           query.match(v) || 
           ( k.match(/safe/) && query.match( to_dec(k, v) ) ) 
        end
        .each do |k, vq|
          acc = to_dec(k, vq)
                .split("\n")
                .select{|l| query.match(l) }
          yield(k, acc)
        end
    end
  end

  def to_enc(key, text)
    text=text.chomp.encode64 if key.match(/^safe/) && !text.base64?
    text
  end

  def to_dec(key, text)
    text=text.decode64 if key.match(/^safe/) && text.base64? || text.chomp.base64?
    text.chomp
  end
  
  def edit(key)
    text=nil
    gdbm{|db| text=db[key] if db.key?(key)}
    return if text.nil?

    text=to_dec(key, text)
    v=yield(text)

    gdbm do |db| 
      v=to_enc(key, v.strip) 
      db[key]=v if db.key?(key) 
      db.reorganize
    end
  end

  def gdbm(&block)=GDBM.open(@dbfile, &block)
  private :gdbm
  
end
