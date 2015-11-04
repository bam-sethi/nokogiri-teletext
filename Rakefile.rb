require 'nokogiri'
require 'open-uri'
desc "scrape football matches from the guardian"
  task :get_data do
    puts "Getting fixtures..."
    page = Nokogiri::HTML(open('http://www.theguardian.com/football/fixtures'))
    home =  page.css('.football-match__team--home').text.gsub(/\n/, " ").split(" " * 5)
    away =  page.css('.football-match__team--away').text.gsub(/\n/, " ").split(" " * 5)
    time = page.css('.football-match__status').text.gsub(/\n/, " ").split(" ")
    home.zip(away, time).each do | home, away, time|
      puts  "+ #{home} vs #{away} @ #{time}"
    end
end