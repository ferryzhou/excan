# input a set of items
# filtering based on ban words

class ItemsFilter

def initialize
	@patterns = load_patterns('ban_words.txt')
end

# check title and description
def filter(items)
	new_items = Array.new
	items.each { |item| new_items.push(item) unless should_ban(item) }
	new_items
end

def should_ban(item)
	@patterns.each { |pattern|
		#return true if ((item.title =~ pattern) or (item.description =~ pattern))
		return true if (item.title =~ pattern)
	}
	false
end

def load_patterns(filename)
	patterns = Array.new
	File.open(filename, 'r') do |f|
		while (line = f.gets)
			#p line
			a = line.strip!
			#p a
			patterns.push(Regexp.new(a)) if not a.nil?
		end
	end
	patterns
end

end
