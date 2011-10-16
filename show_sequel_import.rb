require './sequel_import'

db_path = 'development.sqlite3'
filepath = 'tianya.htm'
method = 'tianya_forum'
dirpath = '../cancer_htm/tianya_zhongliu'

DB = Sequel.sqlite(db_path)
table = DB[:posts]
table.delete
#sequel_import_file(table, filepath, method)
#sequel_import_files(table, File.join(dirpath, '*.htm'), method)
sequel_import_dir_incrementally(table, dirpath, method)
