class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  jp_prefecture :prefecture_code

  has_many :favorites, dependent: :destroy
  has_many :favorited_posts, through: :favorites, source: :post
  has_many :commnets
  has_many :posts, dependent: :destroy

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
  validates :postal_code, presence: true
  validates :prefecture_code, presence: true
  validates :city, presence: true
  validates :street, presence: true

  # 退会機能
  def active_for_authentication?
    super && (self.is_deleted == false)
  end

  # ゲストログイン機能
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
  end

  # いいね機能
  def already_favorited?(post)
    self.favorites.exists?(post_id: post.id)
  end

  # 住所検索機能
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end
end
