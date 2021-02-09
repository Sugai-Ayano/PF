class ChangeCommentsToPostComments < ActiveRecord::Migration[5.2]
  def change
    rename_table :comments, :post_comments
  end
end
