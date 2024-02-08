#!/usr/bin/env ruby
# frozen_string_literal: true

require 'active_support/core_ext/hash/indifferent_access'
require 'yaml'

def yaml_load(leaf)
  raw = YAML.load_file(leaf, permitted_classes: [ActiveSupport::HashWithIndifferentAccess, Symbol])
  raw.is_a?(Array) ? raw.map(&:with_indifferent_access) : raw.with_indifferent_access
end
