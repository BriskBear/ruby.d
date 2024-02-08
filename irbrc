puts "\u001b[38;5;31m#{Time.new}\u001b[0m" # Timestamp console open

begin
  require 'active_support/core_ext/hash/indifferent_access'
  require 'colorize'
  require 'csv'
  require 'interactive_editor'
  require 'pathname'
  require 'yaml'
rescue LoadError => err
  warn "Gem Unavailable: \033[38;5;196m#{err}\033[0m"
end

path="#{ENV['HOME']}/.config/ruby/scrit"
@path = { dwn: Pathname.new('/tmp/dwn'), c: Pathname.new('/home/elijahdaniel/code') }

if ENV['RAILS_ENV'] === 'development'
  IRB.conf[:IRB_NAME] = "\033[38;5;196mrails\033[0m"
elsif ENV['RAILS_ENV'] === 'production'
  IRB.conf[:IRB_NAME] = "\033[38;5;196mrails\033[0m"
elsif ENV['IRB_NAME']
  IRB.conf[:IRB_NAME] = "\033[38;5;196m#{ENV['IRB_NAME']}\033[0m"
else
  IRB.conf[:IRB_NAME] = "\033[38;5;196mirb\033[0m"
end

IRB.conf[:PROMPT][:CUSTOM] = {
  :AUTO_INDENT => true,
  :PROMPT_I => '%N.%m{ ',
  :PROMPT_S => '%N.%m{ ',
  :PROMPT_C => '%N.$m{ ',
  :RETURN => "L" + "\033[38;5;196m \033[0m%s\n"
}

methods = Dir.children(path)
methods.each do |m|
  load "#{path}/#{m}"
end
puts "\033[0;36mLoaded Profile methods\033[0m"

alias q exit

IRB.conf[:PROMPT_MODE] = :CUSTOM
IRB.conf[:SAVE_HISTORY] = 10000
