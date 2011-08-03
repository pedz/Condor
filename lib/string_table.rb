# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
class StringTable
  @@strings = Hash.new
  @@reverse = Array.new
  @@next_id = 0
  @@longest = 0

  # Add a string and return its id
  def self.add_string(s)
    l = s.length
    if @@longest < l
      @@longest = l
    end
    @@strings[s] ||= (@@reverse[@@next_id += 1] = s; @@next_id)
  end

  def self.longest
    @@longest
  end

  # Retrieve string
  def self.lookup(id)
    @@reverse[id]
  end
end
