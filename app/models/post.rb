class Post < ApplicationRecord
  has_many :genres
  has_many :favorites
  has_many :favorited_users, through: :favorites, source: :user
  has_many :post_comments
  belongs_to :user
  enum genre_id: { 春: 0, 夏: 1, 秋: 2, 冬: 3, その他: 4 }

  attachment :image, destroy: false
  validates :title, presence: true
  validates :image, presence: true
  validates :caption, presence: true, length: { maximum: 200 }

  def favorited_by?(user)
    # その投稿にuser_idとpost_idが存在しているかを調べる
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
  
  # 説明文省略
  def short_description
    description[0, 9] + '...'
  end
  
end
