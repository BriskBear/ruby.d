#!/usr/bin/env ruby
# frozen_string_literal: true

class DhcpReservations
  require 'active_support/core_ext/hash/indifferent_access'
  attr_reader :records
  def initialize(leaf)
    raw = File.readlines(leaf).map(&:strip)
                              .map(&:chomp)
                              .map{ |l| l.gsub(/\s+/, ' ') }
                              .reject { |s| s.nil? || s&.empty? || s.match?('--') }
                              .sort
    @records = []
    raw.each do |line|
      @mac = line.split(/\s/)[2]
      next if @mac.nil? || @mac.match?('clientId') 
       @records.append({
         :name => line.split(/\s/)[1],
         :ip   => line.split(/\s/)[0],
         :mac  => @mac.include?('-') ? @mac.gsub('-', ':') : @mac
       }.with_indifferent_access)
    end
  end

  def where(name: nil, mac: nil, ip: nil)
    raise 'No Argument Error: expected named argument <name|mac|ip>' if [name, mac, ip].compact === []

    case
    when !name.nil?
      @records.select{|r| r[:name].match? name}
    when !ip.nil?
      ip = ip.to_s
      if ip.count('.') === 3 && ip.match?(/.+\d$/)
        @records.find{|r| r[:ip] === ip}
      else
        @records.select{|r| r[:ip].match? ip}
      end
    when !mac.nil?
      @records.select{|r| r[:mac] === mac}
    else
      raise 'Cannot have argument and not have argument!!'
    end
  end

  @records
end
