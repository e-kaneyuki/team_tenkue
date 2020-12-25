class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates_uniqueness_of :user_id, scope: :post_id
  # こっちだと登録されないがエラーが返ってこない
  # validates_uniqueness_of :post_id, scope: :user_id
end
