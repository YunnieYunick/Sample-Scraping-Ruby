require 'nokogiri'
require 'open-uri'

search_word = ["Google", "yahoo"]

doc = Nokogiri::HTML(open('https://www.google.com'))

doc.xpath('//*[@id="prm"]/div/a').each do |link|
  if search_word.any? {|w| link.content.include?(w)}
    #send mail
    puts link.content
  end
end
