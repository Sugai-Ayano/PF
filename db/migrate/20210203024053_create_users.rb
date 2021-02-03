class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, default: "", null: false
      t.bloolean :is_deleted, defoult: false, null: false
      t.string :image_id
      t.string :encrypted_password, default: "", null: false
      t.string :postal_code, null: false
      t.string :address, null: false
      t.string :password_digest, null: false
      t.string :remember_token, null: false
      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
