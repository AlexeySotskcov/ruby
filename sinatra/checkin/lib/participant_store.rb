require 'sqlite3'

class ParticipantStore

  def initialize
    @base = SQLite3::Database.open('test1.db')
  end

  def save(data)
    @base.execute("insert into Personal (Date, TimeIn) values (#{data.date}, #{data.time_in})")
  end

end
