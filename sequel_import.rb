# given a htm root
# extract items and import to database
require 'rubygems'
require 'bundler/setup'
require 'sequel'
require './extract_items'

def sequel_import_file(table, filepath, method)
  p "import #{filepath} ......"
  content = open(filepath).read
  items = extract_items(content, method)
  ignored_count = 0; imported_count = 0;
  items.each do |item|
	if !table.filter(:link => item.link).empty?; ignored_count = ignored_count+1; next; end
    table.insert(
      :title => item.title, 
      :link => item.link,
	  :author => item.author,
	  :description => item.description,
	  :date => item.date,
	  :source => item.source
	)
	imported_count = imported_count + 1;
  end
  p "imported #{imported_count} items; ignored #{ignored_count} items"
end

def sequel_import_files(table, path_regex, method)
  Dir[path_regex].each { |path| sequel_import_file(table, path, method) }
end

def get_lines(sipath)
  return [] if !File.exists?(sipath)
  lines = Array.new
  File.open(sipath, 'r') { |f| f.each_line { |line| lines.push(line.strip)} }
  lines
end

def get_dir_filelist(dirpath)
  Dir[File.join(dirpath, '*.htm')].collect { |x| File.basename(x) }
end

# generate a .si file which includs the imported files
# only import unimported
def sequel_import_dir_incrementally(table, dirpath, method)
  sipath = File.join(dirpath, '.si')
  oldlist = get_lines(sipath); p oldlist
  newlist = get_dir_filelist(dirpath); p newlist
  tasklist = newlist - oldlist; p tasklist
  file = open(sipath, 'a+')
  tasklist.each { |task|
    sequel_import_file(table, File.join(dirpath, task), method)
	file.puts(task)
	file.flush
  }
  file.close
end

def sequel_import_all(table, htm_root)
  Dir[File.join(htm_root, '*')].each { |path| 
    sequel_import_dir_incrementally(table, path, File.basename(path)) 
  }
end
