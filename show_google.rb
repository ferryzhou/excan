# parse google search results
require 'rubygems'
require 'cgi'
require 'open-uri'
require 'hpricot'

#test_url = 'http://www.google.com/search?hl=en&lr=lang_zh-CN&biw=1280&bih=668&tbs=lr:lang_1zh-CN&q=+site:tianya.cn+%E5%BE%97%E4%BA%86%E7%99%8C%E7%97%87+-%E6%96%B0%E9%97%BB+-%E6%97%A0%E7%85%A7%E7%A5%9E%E5%8C%BB#q=site:tianya.cn+%E5%BE%97%E4%BA%86%E7%99%8C%E7%97%87+%E5%85%AC%E5%85%AC&hl=en&lr=lang_zh-CN&tbs=lr:lang_1zh-CN&prmd=imvns&ei=1tV3TuuCEYrZ0QHiz8TqCw&start=10&sa=N&bav=on.2,or.r_gc.r_pw.r_cp.&fp=1f4291994997c597&biw=1280&bih=668'

url = 'google_sample.htm'

content = open(url).read

# items are h3 after 

#q = %w{纽约时报：爱尔兰联合银行获14亿英镑融资}.map { |w| CGI.escape(w) }.join("+")
#url = "http://www.google.com/search?q=#{q}"
doc = Hpricot(content)
elements = (doc/"h3[@class='r'] a")
titles = []
links = []
puts "#{elements.size} results:"
elements.each { |e|
   links.push(e["href"])
   #titles.push(e
   puts links.last
   puts (e/"//*/text()").join(' - ')
}

#p content
