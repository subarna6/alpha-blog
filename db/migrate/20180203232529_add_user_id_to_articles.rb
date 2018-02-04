class AddUserIdToArticles < ActiveRecord::Migration
  def change
    unless column_exists? :articles, :user_id
      add_column :articles, :user_id, :integer
    end
  end
end