class AddIndexToBaseUrl < ActiveRecord::Migration[5.1]
  def change
    add_index :url_crops, :base_url
  end
end
