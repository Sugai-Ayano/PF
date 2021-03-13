require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe'バリテーションのテスト アップデート'do
    subject{ user.valid?(:update) }
    let!(:other_user){ create(:user) }
    let(:user){ build(:user) }

    context 'introductionカラム' do
      it '50文字以下であること: 50文字は○' do
        user.introduction = Faker::Lorem.characters(number: 50)
        is_expected.to eq true
      end
      it '51文字以上であること: 51文字は×' do
        user.introduction = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
    end
  end
  describe'バリテーションのテスト'do
    subject{ user.valid? }
    let!(:other_user){ create(:user) }
    let(:user){ build(:user) }

    context'nameカラム' do
      it '2文字以上であること: 1文字は×' do
        user.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字は○' do
        user.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '20文字以下であること: 20文字は○' do
        user.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以上であること: 21文字は×' do
        user.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
      it '一意性があること' do
        user.name = other_user.name
        is_expected.to eq false
      end
    end
  end
end