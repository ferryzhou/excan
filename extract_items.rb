# encoding: UTF-8

Encoding.default_external = 'UTF-8'

require 'hpricot'
require 'ostruct'
require 'iconv'

def gb2312_to_utf8(str); Iconv.iconv('utf-8', 'GBK', str).join; end

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
      'date'  => text[(ind + 3) .. (ind + 18)],
      'description' => e.at('p.summary').inner_html,
	  'source' => 'tianya'
  })
  end

end

def extract_tianya_forum_items(content)
  content = gb2312_to_utf8(content)
  doc = Hpricot(content)
  tbs = doc.search('table.listtable')
  tbs.shift #remove first
  puts "#{tbs.size} results:"
  tbs.collect do |e|
    begin
    tr = e.at('tr');
	title_e = tr.at('td.posttitle').at('a') 
	author_e = tr.at('td.author').at('a')
	date_e = tr.at('td.ttime')
    OpenStruct.new( {
      'title' => (title_e/'//text()').join(''),
      'link'  => title_e['href'],
      'author' => author_e.inner_html,
	  'author_link' => author_e['href'],
      'date'  => '20' + date_e.inner_html,
      'description' => '',
	  'source' => 'tianya_forum'
    })
	rescue
	  p '[Error]'
      puts $!
	end
  end
end

def extract_items(content, method)
  command = "extract_#{method}_items(content)"
  eval(command)
end

#content = open('tianya.htm').read
#items = extract_tianya_items(content)
#p items.join('-')
