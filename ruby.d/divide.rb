#!/usr/bin/env ruby
# frozen_string_literal: true

# Independent Lambdas
@sproc = ->(s) { eval "lambda { #{s} }" }

# Dependent Lambdas
@divide = lambda do |main, function|
  fn = @sproc.call(function)
  out = main.select(&fn)
  main.reject!(&fn)
  out
end
