class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :content
      t.timestamps
      t.references :user, type: :bigint, foreign_key: true
    end
  end
end
