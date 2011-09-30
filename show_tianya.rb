require 'rubygems'
require 'cgi'
require 'open-uri'
require 'hpricot'

url = 'tianya.htm'

content = open(url).read

# items are div class='listbox'

doc = Hpricot(content)
elements = (doc/"div.listbox")
puts "#{elements.size} results:"
elements.each { |e|
  link = e.at('h3').at('a')
  puts '----------------------------------------'
  puts "title: #{(link/'//text()').join('')}"
  puts "link: #{link['href']}"
  related = e/"p.related"
  puts "author: #{related.at('a').inner_html}"
  text = related.inner_html
  ind = text.index('Ê±¼ä')
  puts "date: #{text[(ind + 6) .. (ind + 21)]}"
  puts "description: #{e.at('p.summary').inner_html}"
}
