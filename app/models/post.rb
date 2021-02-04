class Post < ApplicationRecord
  has_many :genres
  has_many :favorites
  has_many :favorited_users, through: :favorites, source: :user
  has_many :comments
  belongs_to :user

  attachment :image, destroy: false
  validates :title, presence: true
  validates :image_id, presence: true
  validates :content, presence: true, length: { maximum: 200 }
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end
