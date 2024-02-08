#!/usr/bin/env ruby
# frozen_string_literal: true

def index_array(table)
  @container = []
  table.each_with_index{|i,idx| @container.append([idx, i].flatten)}
  @container
end

@find_head = ->(t, h) { index_array(t.first)[1..-1].select{|head| head[1].match?(h)} }
@find_key  = ->(h, k) { h.sample.keys.select{|key| key.downcase.match?(k.downcase)} }
