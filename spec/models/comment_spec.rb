require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "有効な値の時" do
    it "commentが有効なこと" do
      expect(FactoryBot.build(:comment)).to be_valid
    end
  end

  describe "無効な値の時" do
    it "commentが空なら無効なこと" do
      comment = FactoryBot.build(:comment,comment: nil)
      comment.valid?
      expect(comment.errors[:comment]).to be_present
    end

    it "commentが141文字以上なら無効なこと" do
      comment = FactoryBot.build(:comment,comment: "a"*141)
      comment.valid?
      expect(comment.errors[:comment]).to be_present
    end
  end
end
