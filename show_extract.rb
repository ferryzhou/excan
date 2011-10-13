require './extract_items'

if ARGV.size == 0
  p "input a filename"
  exit(1)
end
method = ARGV.size > 1 ? ARGV[1] : 'tianya'
content = open(ARGV[0]).read
p "[#{method}] extract #{ARGV[0]}"
items = extract_items(content, method)
p items.join('-')
