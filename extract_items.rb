# encoding: UTF-8

Encoding.default_external = 'UTF-8'

require 'hpricot'
require 'ostruct'
require 'iconv'

def gb2312_to_utf8(str); Iconv.iconv('utf-8', 'gb2312', str).join; end

def extract_tianya_items(content)

  content = gb2312_to_utf8(content)
  doc = Hpricot(content)
  elements = doc.search("div.listbox")
  puts "#{elements.size} results:"
  elements.collect do |e|
    link = e.at("h3").at("a")
    related = e.search("p.related")
    text = related.inner_html
	ind = text.index('时间')
    OpenStruct.new( {
      'title' => (link/'//text()').join(''),
      'link'  => link['href'],
      'author' => related.at('a').inner_html,
      'date'  => text[(ind + 6) .. (ind + 21)],
      'description' => e.at('p.summary').inner_html,
	  'source' => 'tianya'
  })
  end

end

def extract_items(content, method)
  command = "extract_#{method}_items(content)"
  eval(command)
end

#content = open('tianya.htm').read
#items = extract_tianya_items(content)
#p items.join('-')
