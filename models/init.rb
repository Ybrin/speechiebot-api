# encoding: utf-8
=begin
db_file = open(File.expand_path('../json/mc_db.json',
                                File.dirname(__FILE__)))
db_json = db_file.read
db = JSON.parse(db_json)
DataMapper.setup(:mc, ENV['DATABASE_URL'] || "mysql://#{db['username']}:"\
                                                  "#{db['password']}@"\
                                                  "#{db['hostname']}/"\
                                                  "#{db['database']}")

require_relative 'minecraft/init'
=end

# DataMapper.finalize
