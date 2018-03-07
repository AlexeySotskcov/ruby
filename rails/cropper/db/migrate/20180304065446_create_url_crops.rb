class CreateUrlCrops < ActiveRecord::Migration[5.1]
  def change
    create_table :url_crops do |t|
      t.text :base_url
      t.string :short_url

      t.timestamps
    end
  end
end
