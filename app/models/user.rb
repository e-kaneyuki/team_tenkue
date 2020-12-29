class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,32}+\z/i
  validates :name, presence: true
  validates :email, { presence: true, format: { with: VALID_EMAIL_REGEX } }
  validates :password, { presence: true, length: { minimum: 8,maximum: 32 },format: { with: VALID_PASSWORD_REGEX } }
  has_many :comments, dependent: :destroy

  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end
end
