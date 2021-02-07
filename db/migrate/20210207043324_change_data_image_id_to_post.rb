class ChangeDataImageIdToPost < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :image_id, :string
  end
end
