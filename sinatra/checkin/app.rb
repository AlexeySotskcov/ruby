require 'sinatra'
require 'sqlite3'
require 'date'
require 'participant'

db = SQLite3::Database.open('test1.db')
db.execute "CREATE TABLE IF NOT EXISTS Personal(Id INTEGER PRIMARY KEY, Name TEXT, Dat DATE, TimeIn DATETIME, TimeOut DATE)"
#http://www.w3ii.com/ru/sqlite/sqlite_data_types.html
get ('/') do

  @date = Date.today.strftime('%d-%m-%Y')
  #ip = Socket::getaddrinfo(Socket.gethostname,"echo",Socket::AF_INET)[0][3]
  @time = DateTime.now.strftime('%H:%M')

@dat = db.execute( "select * from Personal" )



  erb :index
end

post ('/create') do
  @enter = Participant.new
#  @enter.name = params['']
  @enter.time_in = params['time_in']
  @enter.date = params['date']
  db.execute("insert into Personal (Dat) values (#{@enter.date})")
  redirect "/"
#p @enter.date
end
