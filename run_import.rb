require './sequel_import'

db_path = '../excan_rails/db/development.sqlite3'
filepath = 'tianya.htm'
method = 'tianya'
dirpath = '../cancer_htm/tianya/*.htm'

DB = Sequel.sqlite(db_path)
table = DB[:posts]
sequel_import_dir_incrementally(table, '../cancer_htm/tianya', method)
