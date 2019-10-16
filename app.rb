require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open('https://www.google.com'))

doc.xpath('//*[@id="prm"]/div/a').each do |link|
  puts link.content
end
