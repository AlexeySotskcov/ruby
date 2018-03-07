class UrlCropsController < ApplicationController

  def new
    @url = UrlCrop.new
  end

  def create

    @url = UrlCrop.find_by(base_url: params[:url_crop][:base_url].downcase)
    unless @url
      @url = UrlCrop.new(url_params)
      if @url.save
        @url.short_url = url_generator
        @url.save
      end
    end
<<<<<<< HEAD
    render 'new'
    #render plain: @url.short_url
=======
    render plain: @url.short_url
>>>>>>> cropper
    #render plain: request.original_url
  end

  def must_be_redirected
    url = request.original_url
    if url.split('/').last.length == 5
      url_r = UrlCrop.find_by(short_url: url.split('/').last)
      redirect_to url_r.base_url
    else
      redirect_to root_path
    end
  end

<<<<<<< HEAD
  def update
    @url = UrlCrop.find_by(base_url: params[:url_crop][:base_url].downcase)
    if @url.update_attributes(url_params)
      render 'new'
    end
  end
=======
>>>>>>> cropper

  private

    def url_params
      params.require(:url_crop).permit(:base_url)
    end

    def url_generator
      symbols = ('a'..'z').to_a + ('A'..'Z').to_a
      shorts = ''
      5.times do
        shorts << symbols[rand(symbols.length - 1)]
      end
      shorts
    end

end
