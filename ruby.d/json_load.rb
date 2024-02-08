#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require 'active_support/core_ext/hash/indifferent_access'

def json_load(path)
  JSON.load_file(path).map(&:with_indifferent_access)
end
