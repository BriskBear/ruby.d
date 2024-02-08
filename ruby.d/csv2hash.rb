#!/usr/bin/env ruby
# frozen_string_literal: true

class Array
  def rm_column(header)
    fail "Not all elements are arrays" if map{|ele| ele.is_a? Array}.include? false

    cdx = first.find_index(header)

    each{|row| row.delete_at(cdx)}
    count
  end

  def to_csv
    fail "Not all elements are Hashes" if map{|ele| ele.is_a? Hash}.include? false
    fail "Hashes have differing keysets" unless first.keys == map(&:keys).uniq.last

    csv = [sample.keys]
    each{|record| csv.append(record.values)}
    csv
  end
end


def csv2hash(csv)
#   symbolize = ->(str) { str.gsub(/\s+/, '_').downcase.to_sym }
  symbolize = lambda do |str|
    cap = str.chars.select{|c| c == c.upcase}
    cap.each{|c| str.gsub!(c, "_#{c.downcase}")}
    str.gsub!(/(\s+)/, '_')
    str.gsub!(/(_+)/, '_')
    str.gsub!(/(^_)/, '')
    str.gsub!(/^i_d_/, 'id_')
    str.gsub!(/_i_d_/, '_id_')
    str.gsub!(/_i_d$/, '_id')
    str.to_sym
  end

  @headers = csv.shift
  @collection = []

  csv.each_with_index do |row, rdx|
    @collection.append({}.with_indifferent_access)
    # warn "\u001b[38;5;208mwarn:\u001b[0m #{@headers}"
    row.each_with_index { |cell, cdx| @collection[rdx].merge!({ symbolize.call(@headers[cdx]) => cell }) }
  end
  @collection
end

def write_csv(name,nest)
  CSV.open("#{name.gsub('.csv', '')}.csv", 'wb') do |csv|
    nest.each do |row|
      csv << row
    end
    nest.count
  end
end
