class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { maximum: 140 }
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
end
