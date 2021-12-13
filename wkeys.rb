#!/usr/bin/env ruby
# Id$ nonnax 2021-12-12 19:26:41 +0800
require 'gdbm'
GDBM.open('wdb.db'){|db| puts db.keys.sort }
