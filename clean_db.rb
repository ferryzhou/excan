require './sequel_import'

db_path = 'development.sqlite3'

DB = Sequel.sqlite(db_path)
table = DB[:posts]
table.delete
