require 'nokogiri'
require 'open-uri'
require 'mail'

search_word = ["search_word1", "search_word2"]
target_site = {
                'target_site1' => 'selector1',
                'target_site2' => 'selector2'
              }
mail_to = 'mail_to_address'
options = { :address               => 'smtp.gmail.com',
            :port                  => 587,
            :domain                => 'gmail.com',
            :user_name             => 'mail_user',
            :password              => 'mail_user_pw',
            :authentication        => :plain,
            :enable_starttls_auto  => true  
          }

target_site.each do |key, value|
  doc = Nokogiri::HTML(open(key))
  doc.css(value).each do |link|
    if search_word.any? {|w| link.content.include?(w)}
      mail = Mail.new do
        from    options[:user_name ]
        to      mail_to
        subject "Scraping #{key}"
        body "Get: #{link.content}"
      end
      mail.charset = 'utf-8'
      mail.delivery_method(:smtp, options)
      mail.deliver
    end
  end
end