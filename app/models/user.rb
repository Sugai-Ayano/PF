class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :favorites
  has_many :favorited_posts, through: :favorites, source: :post
  has_many :commnets
  has_many :posts

  # フォローしている
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォローされている
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # フォローしている
  has_many :follower_user, through: :followed, source: :follower
  # フォローされている
  has_many :following_user, through: :follower, source: :followed

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
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :email, presence: true
  validates :encrypted_password, presence: true, length: {minimum:6}
  validates :introduction, length: { maximum: 50 }

  # def active_for_authentication?
  #   super && (self.is_deleted == false)
  # end
end
