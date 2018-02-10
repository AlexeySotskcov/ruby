class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  def change
    add_index :name, :email, unique: true
  end
end
