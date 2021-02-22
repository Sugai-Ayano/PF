class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include JpPrefecture
  jp_prefecture :prefecture_code

  has_many :favorites, dependent: :destroy
  has_many :favorited_posts, through: :favorites, source: :post
  has_many :post_commnets
  has_many :posts, dependent: :destroy

  attachment :profile_image, destroy: false
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :email, presence: true
  validates :encrypted_password, presence: true, length: {minimum:6}
  validates :introduction, length: { maximum: 50 }
  validates :postal_code, presence: true
  validates :prefecture_code, presence: true
  validates :city, presence: true

  # 自分がフォローされる（被フォロー）側の関係性
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 自分がフォローする（与フォロー）側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed

  # フォロー機能
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def followings?(user)
    followings.include?(user)
  end

  # 退会機能
  def active_for_authentication?
    super && (self.is_deleted == false)
  end

  def self.search_for(content, method)
      # methodがperfectだったら
    if method == 'perfect'
      # データベースから条件に一致したものを一件or複数とってくる
      User.where(name: content)
      # perfctじゃなかったらforword（前方一致）に移動する
    elsif method == 'forward'
      User.where('name LIKE ?', content + '%')
      # perfctじゃなかったらforword（後方一致）に移動する
    elsif method == 'backward'
      User.where('name LIKE ?', '%' + content)
    else
      # 全く一致しない場合
      User.where('name LIKE ?', '%' + content + '%')
    end
  end

  # ゲストログイン機能
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
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

  # 検索機能
  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end
end
