class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
<<<<<<< HEAD
end
=======
  has_many :posts
end
>>>>>>> 1941528... 掲示板一覧表示機能
