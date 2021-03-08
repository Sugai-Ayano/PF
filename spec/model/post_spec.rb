  require 'rails_helper'

  RSpec.describe Post, 'Postモデルのテスト', type: :model do
    describe'バリテーションのテスト' do
      subject{ post.valid? }
      user = FactoryBot.create(:user)

      let(:post){ create(:post, :user => user) }
#      let!(:post){ build(:post, user_id: user.id) }

      context 'titleカラム' do
        it '空白でないこと' do
          post.title = ''
          is_expected.to eq false
        end
      end

      context 'captionカラム' do
        it '空白でないこと' do
          post.caption = ''
          is_expected.to eq false
        end
        it '200文字以下であること: 200文字は○' do
          post.caption = Faker::Lorem.characters(number: 200)
          is_expected.to eq true
        end
        it '200文字以下であること: 201文字は×' do
          post.caption = Faker::Lorem.characters(number: 201)
          is_expected.to eq false
        end
      end
    end
  end