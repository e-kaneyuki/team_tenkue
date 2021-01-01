require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "有効な値の時" do
    it "commentが登録できること" do
      expect(FactoryBot.build(:comment)).to be_valid
    end

    it "140文字以内なら登録できること" do
      expect(FactoryBot.build(:comment,comment: "a"*140)).to be_valid
    end
  end

  describe "無効な値の時" do
    it "commentが空なら登録できないこと" do
      comment = FactoryBot.build(:comment,comment: nil)
      comment.valid?
      expect(comment.errors[:comment]).to be_present
    end

    it "commentが141文字以上なら登録できないこと" do
      comment = FactoryBot.build(:comment,comment: "a"*141)
      comment.valid?
      expect(comment.errors[:comment]).to be_present
    end
  end
end
