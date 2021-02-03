class User < ApplicationRecord
  has_many :favorites
  has_many :favorited_posts, through: :favorites, source: :post
  has_many :commnets
  has_many :posts

  # フォローしている
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォローされている
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # フォローしている
  has_many :follower_user, through: followed, source: follower
  # フォローされている
  has_many :followed_user, through: follwer, source: followed
 

  # フォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # フォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # 既にフォローしているか確認
  def following?(user)
    following_user.include(user)
  end

  attachment :profile_image, destroy: false
  validates :name, presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: true, length: {minimum:6}


end
