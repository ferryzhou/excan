# 
# clean db
# series extract: 
# schedule update //monitoring
# 
require './sequel_import'
require '../page_archiever/multi_page_archiever'
require '../page_archiever/page_archiever'

help_msg = 'excan <clean|exall|update> <options>'

if ARGV.size == 0
  p help_msg
  exit(1)
end

DB_PATH = 'development.sqlite3'
START_URL = 'http://www.tianya.cn/new/techforum/ArticlesList.asp?pageno=1&iditem=100&part=0&subitem=%D6%D7%C1%F6%BF%C6'
HTM_ROOT = '../cancer_htm'
END_COUNT = 2
HTM_FOLDER_NAME = 'tianya_zhongliu'
METHOD = 'tianya_forum'

HTM_FOLDER = File.join(HTM_ROOT, HTM_FOLDER_NAME)

cmd_str = ARGV[0]

DB = Sequel.sqlite(DB_PATH)
TABLE = DB[:posts]

def clean
 TABLE.delete
end

def exall
  p 'archieving html pages ....................'
  archiever = MultiPageArchiever.new(HTM_ROOT)
  archiever.end_count = END_COUNT
  archiever.run(START_URL, HTM_FOLDER_NAME)
  
  import
end

def import
  p "extracting and importing items in #{HTM_FOLDER} ................"
  sequel_import_dir_incrementally(TABLE, HTM_FOLDER, METHOD)
end

def update
  p 'archieving html page ....................'
  PageArchiever.new(HTM_ROOT).read_and_save_url(START_URL, HTM_FOLDER_NAME)
  
  import
end

eval(cmd_str)
