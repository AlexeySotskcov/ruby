
#require 'net/http'
require 'nokogiri'
require 'open-uri'
require 'csv'
#для преобразования \uo34d в русскую букву
if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__
  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end


class Parser
  def initialize(uri_products)
    #uri = URI(uri_products)
    #@resourse = Net::HTTP.get(uri)
    @doc = Nokogiri::HTML(open(uri_products))
  end

  def show
    #@resourse.include? ('prodrev-row')
    #получить массив с prodrev-row
    #@all_comments = []
    @all_comments = @doc.css('.prodrev-row').map do |comment|
      #получаем имя комментатора
      commenter = comment.css('.rev-user-name a').text
      #получаем краткое описание
      summary = comment.css('.rev-summary').text
      #получаем полный текст комментария
      rev = comment.css('.rev-content').text
      #получаем "за"
      yes = comment.css('.revpc-container .revpc.pros').text
      #получаем "против"
      no = comment.css('.revpc-container .revpc.cons').text

      { name: commenter,
        summary: summary,
        review: rev,
        best: yes,
        worst: no
      }
    end

#    @all_comments.each do |comment|
#      puts comment
#      puts comment
#      puts "---------------------------"
#    end

# записываем каждое значение комментария в csv-файл
      CSV.open('data.csv', 'w') do |file|
        @all_comments.each do |com|
          file << com.values
        end
      end

  end

end

print 'Введите ссылку на страницу с товаром onliner: '
uri_products = gets.strip
new_parse = Parser.new(uri_products)
new_parse.show

#p resourse.include? ("prodrev-row")
