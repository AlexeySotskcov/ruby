class AddActivationToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :activashion_digest, :string
    add_column :users, :activated, :bolean, default: false
    add_column :users, :activated_at, :datetime
  end
end
