#!/usr/bin/env ruby
# Id$ nonnax 2021-12-13 14:45:28 +0800
require_relative 'wup/wup'

Wup.new.tap do |wup|
  p wup.get do |t|
    # decouples the editor
    # other methods are allowed to update it. 
    # i.e. from a stream source to update to the db
    IO.editor(t)
  end
  # p wup.latest_post
end
