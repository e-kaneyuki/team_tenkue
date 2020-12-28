require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "有効な値の時" do
    it "postが有効なこと" do
      expect(FactoryBot.build(:post)).to be_valid
    end
  end

  describe "無効な値の時" do
    it "contentが空なら無効なこと" do
      post = FactoryBot.build(:post, content: nil)
      post.valid?
      expect(post.errors[:content]).to be_present
    end

    it "contentが141文字以上なら無効なこと" do
      post = FactoryBot.build(:post, content: "あ"*141)
      post.valid?
      expect(post.errors[:content]).to be_present
    end
  end
end
