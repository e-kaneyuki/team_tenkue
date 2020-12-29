require 'rails_helper'

RSpec.describe User, type: :model do
  describe "有効な値の時" do
    it "userが登録できること" do
      expect(FactoryBot.build(:user)).to be_valid
    end

    it "passwordが8文字以上なら登録できること" do
      expect(FactoryBot.build(:user,password: "abcd1234")).to be_valid
    end

    it "passwordが32文字以内なら登録できること" do
      expect(FactoryBot.build(:user,password: "a1"*16)).to be_valid
    end
  end

  describe "無効な値の時" do
    it "nameが空なら登録できないこと" do
      user = FactoryBot.build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to be_present
    end
  
    it "emailが空なら登録できないこと" do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to be_present
    end

    it "emailが正しく無い値なら登録できないこと" do
      user = FactoryBot.build(:user, email: "test@com")
      user.valid?
      expect(user.errors[:email]).to be_present
    end
  
    it "passwordが7文字以下なら登録できないこと" do
      user = FactoryBot.build(:user, password: "abc1234")
      user.valid?
      expect(user.errors[:password]).to be_present
    end

    it "passwordが33文字以上なら登録できないこと" do
      user = FactoryBot.build(:user, password: "12a"*11 )
      user.valid?
      expect(user.errors[:password]).to be_present
    end

    it "passwordに全角が含まれていると登録できないこと" do
      user = FactoryBot.build(:user, password: "あいうえお12345")
      user.valid?
      expect(user.errors[:password]).to be_present
    end

    it "passwordに半角英字がないと登録できないこと" do
      user = FactoryBot.build(:user, password: "1234567890")
      user.valid?
      expect(user.errors[:password]).to be_present
    end

    it "passwordに半角数字がないと登録できないこと" do
      user = FactoryBot.build(:user, password: "abcdefghijk")
      user.valid?
      expect(user.errors[:password]).to be_present
    end
  end
end
