class CreateRecommendations < ActiveRecord::Migration[5.2]
  def change
    create_table :recommendations do |t|
      t.integer :user_id
      t.integer :post_id
      t.string :title
      t.timestamps
    end
  end
end
