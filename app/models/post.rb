class Post < ApplicationRecord
  has_many :genres
  has_many :favorites
  has_many :favorited_users, through: :favorites, source: :user
  has_many :comments
  belongs_to :user

  attachment :image, destroy: false
  validates :title, presence: true
  validates :image_id, presence: true

end
