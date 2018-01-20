require 'nokogiri'
require 'open-uri'
require 'csv'

class Parser

  def initialize(url)

    regexp_url = /^(http|https):\/\/[a-z0-9]+([\.\-]{1}[a-z0-9]+)*\.[a-z]{2,5}/
    pre = regexp_url.match(url)
    @prefix = pre[0]

    # массив, где будут хранится все комментарии
    @all_comments = []
    @page_field = 0
    # счетчик страниц
    @count = 1

    self.startParse(url)
  end

private
  def startParse(url)
    doc = self.openUrl(url)
    self.returnPageNumber(doc)
    unless @page_field == 1
      url = self.firstPage(doc)
      @page_field = 1
    end
    while @page_field == @count
        self.takeInfo(url)
        #  получаем номер следующей страницы
        url = self.nextPage(doc)
        #puts url
        doc = self.openUrl(url)
        self.returnPageNumber(doc)
      #  puts "page_field= #{@page_field}"

        @count += 1
    end
    self.saveInfo
  end

  def returnPageNumber(doc)

    #получаем номер страницы
    page_number = doc.xpath('//*[@name="page"]')
    page_number.each do |atribute|
    #  puts atribute['value']
      @page_field = atribute['value'].to_i
    end
  end

  def firstPage(doc)
    #получаем ссылку на первую страницу
    page = doc.css(".phed strong a").first
    page['href']
  end

  def nextPage(doc)
    nextPage = doc.css(".phed strong a").last
    nPage = nextPage['href']
  end

  def takeInfo(url)

    doc = self.openUrl(url)

    # получить массив с prodrev-row
    @all_comments |= doc.css('.prodrev-row').map do |comment|
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

  end

  def saveInfo

      # записываем каждое значение комментария в csv-файл
      # параметр 'a' дописывает в конец файла, 'w' перезаписывает
      CSV.open('data2.csv', 'a') do |file|
            @all_comments.each do |com|
              file << com.values
            end
          end

  end

  def openUrl(url)

    unless url.include?(@prefix)
      url = @prefix + url
    end
    Nokogiri::HTML(open(url))
  end

end
#m = "https://catalog.onliner.by/mobile/xiaomi/r4x16b/reviews/~sort_by=date~dir=asc~page=1?region=minsk"
#r = Parser.new(m)
#r.startParse(m)
