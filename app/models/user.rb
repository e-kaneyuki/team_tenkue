class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,32}+\z/i
  validates :name, presence: true
  validates :email, { presence: true, format: { with: VALID_EMAIL_REGEX } }
  validates :password, { presence: true, length: { minimum: 8,maximum: 32 },format: { with: VALID_PASSWORD_REGEX } }
end
