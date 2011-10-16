require './sequel_import'

db_path = '../excan_rails/db/development.sqlite3'
method = 'tianya'

DB = Sequel.sqlite(db_path)
table = DB[:posts]
sequel_import_dir_incrementally(table, '../cancer_htm/tianya', method)
