require "rubygems"
require "nokogiri"
require "ostruct"

Dir[File.dirname(__FILE__) + '/evernicious/**/*.rb'].each do |file|
  require file
end
