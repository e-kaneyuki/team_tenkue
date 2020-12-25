require 'rails_helper'

RSpec.describe User, type: :model do
  describe "有効な値の時" do
    it "userが有効なこと" do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end

  describe "無効な値の時" do
    it "nameが空なら無効なこと" do
      user = FactoryBot.build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to be_present
    end
  
    it "emailが空なら無効なこと" do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to be_present
    end

    it "emailが正しく無い値なら無効なこと" do
      user = FactoryBot.build(:user, email: "test@com")
      user.valid?
      expect(user.errors[:email]).to be_present
    end
  
    it "passwordが7文字以下なら無効なこと" do
      user = FactoryBot.build(:user, password: "abc1234")
      user.valid?
      expect(user.errors[:password]).to be_present
    end

    it "passwordが33文字以上なら無効なこと" do
      user = FactoryBot.build(:user, password: "12a"*11 )
      user.valid?
      expect(user.errors[:password]).to be_present
    end

    it "passwordに全角が含まれていると無効なこと" do
      user = FactoryBot.build(:user, password: "あいうえお12345")
      user.valid?
      expect(user.errors[:password]).to be_present
    end
  end
end
