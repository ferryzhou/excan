require 'hpricot'
require './item'

def extract_google_items(content)

  doc = Hpricot(content)
  elements = (doc/"h3[@class='r'] a")
  puts "#{elements.size} results:"
  elements.collect { |e|
    Item.new {
	  :link => e['href']
	  :description => (e/"//*/text()").join(' - ')
	}
  }

end
