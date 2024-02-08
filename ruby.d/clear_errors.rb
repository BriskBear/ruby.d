#!/usr/bin/env ruby
# frozen_string_literal: true

def clear_errors(*leaf)
  require 'csv'
  require_relative 'index_array'

  @result = index_array(CSV.readlines('/tmp/dwn/account.csv'))
  @err    = @result.reject{|r| r[1].empty?}
  @output = @result.select{|r| r[1].empty?}
  @output.insert(0, @err[0])
  @output = @output.map{|r| r[2..-1]}
  leaf.empty? && leaf = 'account'

  out_leaf = "/tmp/dwn/#{leaf}.csv" 
  err_leaf = "/tmp/dwn/#{leaf}_errors.csv" 
  File.exist?(out_leaf) && File.delete(out_leaf)
  File.exist?(err_leaf) && File.delete(err_leaf)

  CSV.open(out_leaf, 'wb') do |csv|
    @output.each do |row|
      csv << row
    end
  end
  CSV.open(err_leaf, 'wb') do |csv|
    @err.each do |row|
      csv << row
    end
  end
end
