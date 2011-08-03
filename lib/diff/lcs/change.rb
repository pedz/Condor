# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
#! /usr/env/bin ruby
#--
# Copyright 2004 Austin Ziegler <diff-lcs@halostatue.ca>
#   adapted from:
#     Algorithm::Diff (Perl) by Ned Konz <perl@bike-nomad.com>
#     Smalltalk by Mario I. Wolczko <mario@wolczko.com>
#   implements McIlroy-Hunt diff algorithm
#
# This program is free software. It may be redistributed and/or modified under
# the terms of the GPL version 2 (or later), the Perl Artistic licence, or the
# Ruby licence.
# 
# $Id: change.rb,v 1.4 2004/08/08 20:33:09 austin Exp $
#++
# Provides Diff::LCS::Change and Diff::LCS::ContextChange.

# Represents a simplistic (non-contextual) change. Represents the removal or
# addition of an element from either the old or the new sequenced enumerable.
module Diff::LCS
  class Change
    # Returns the action this Change represents. Can be '+' (#adding?), '-'
    # (#deleting?), '=' (#unchanged?), # or '!' (#changed?). When created by
    # Diff::LCS#diff or Diff::LCS#sdiff, it may also be '>' (#finished_a?) or
    # '<' (#finished_b?).
    attr_reader :action
    attr_reader :position
    attr_reader :element
    
    include Comparable
    def ==(other)
      (self.action == other.action) and
        (self.position == other.position) and
        (self.element == other.element)
    end
    
    def <=>(other)
      r = self.action <=> other.action
      r = self.position <=> other.position if r.zero?
      r = self.element <=> other.element if r.zero?
      r
    end
    
    def initialize(action, position, element)
      @action = action
      @position = position
      @element = element
    end
    
    # Creates a Change from an array produced by Change#to_a.
    def to_a
      [@action, @position, @element]
    end
    
    def self.from_a(arr)
      Diff::LCS::Change.new(arr[0], arr[1], arr[2])
    end
    
    include Diff::LCS::ChangeTypeTests
  end
end
