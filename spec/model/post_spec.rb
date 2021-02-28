  require 'rails_helper'

  Rspec.describe 'Postモデルのテスト', type :model do
    describe'バリテーションのテスト' do
      subject{ post.valid? }

      let{:post}{ create(:post) }
      let!(:post){ build(:post, user_id: user.id) }

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

    describe 'アソシエーションのテスト' do
      context 'Userモデルとの関係' do
        it 'N:1となっている' do
          expect(Post.reflect_on_association(:user).macro).to
          eq :belongs_to
        end
      end
    end
  end