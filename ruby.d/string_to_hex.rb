#!/usr/bin/env ruby
# frozen_string_literal: true

class String
  def number?
    return true if self == '0'
    to_i != 0 ? true : false
  end

  def simplify(char, max)
    alphabet = ('a'..'z').to_a
    compare = max - 6
    idx = char.number? ? char.to_i : alphabet.find_index(char.downcase) % max
    idx < compare ? idx.to_s : alphabet[idx - compare]
  end

  def method_missing(m, *args, &block)
    case 
    when m.to_s.match?('to_b32')
      arry = chars
      return arry.map{|c| simplify(c, 14)}.join
    when m.to_s.match?('to_hex')
      arry = chars
      return arry.map{|c| simplify(c, 16)}.join
    else
      super
    end
  end
end
