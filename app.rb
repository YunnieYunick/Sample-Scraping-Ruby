require 'nokogiri'
require 'open-uri'
require 'mail'

search_word = ["Google", "Designer"]


mail = Mail.new do
  from    'FROM_MAIL'
  to      'TO_MAIL'
  subject 'Scraping Test'
  body 'scraping'
end

options = { :address               => 'smtp.gmail.com',
            :port                  => 587,
            :domain                => 'gmail.com',
            :user_name             => 'FROM_MAIL',
            :password              => 'FROM_MAIL_PW',
            :authentication        => :plain,
            :enable_starttls_auto  => true  }



doc = Nokogiri::HTML(open('URL'))

doc.xpath('XPATH').each do |link|
  if search_word.any? {|w| link.content.include?(w)}
    mail.charset = 'utf-8'
    mail.delivery_method(:smtp, options)
    mail.deliver
  end
end
