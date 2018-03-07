class UrlCrop < ApplicationRecord
  # started like web-url
  # before_create :check
  before_save :downcase_url, :find_obj
  HTTP_REG_EXP = /\A(http|https):\/\/([a-zA-Z0-9]+[\.\-]{1})+[a-zA-Z0-9]{2,5}\//

  validates :base_url, presence: true, length: { maximum: 255 },
                                       format: { with: HTTP_REG_EXP }

  private

    def downcase_url
      self.base_url = base_url.downcase
    end

    def find_obj
      if UrlCrop.find_by(base_url: :base_url)
        render plain: "exists"
      end
    end

end
