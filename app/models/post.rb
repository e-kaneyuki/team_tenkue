class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :content, presence: true, length: { maximum: 140 }
  has_many :likes
end
