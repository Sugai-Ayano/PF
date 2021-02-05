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
  # 検索機能
  def self.search_for(content, method)
    if method == 'perfect'
      Post.where(title: content)
    elsif method == 'forward'
      Post.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Post.where('title LIKE ?', '%'+content)
    else
      Post.where('title LIKE ?', '%'+content+'%')
    end
  end
end
