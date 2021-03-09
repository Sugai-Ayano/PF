require 'rails_helper'

describe '[STEP2]ユーザーログイン後のテスト' do
  let(:user){ create(:user) }
  let!(:other_user){ create(:user) }
  let!(:post){create(:post, user:user) }
  let!(:other_post){ create(:post, user:other_user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  context '表示内容の確認' do
    it 'URLが正しい' do
      expect(current_path).to eq '/posts'
    end
    it '自分と他人の画像のリンク先が正しい' do
      expect(page).to have_link'', href: post_path(post)
      expect(page).to have_link'', href: post_path(other_post)
    end
    it '自分の投稿と他人の投稿のタイトルのリンク先がそれぞれ正しい' do
      expect(page).to have_link post.title, href: post_path(post)
      expect(page).to have_link other_post.title, href: post_path(other_post)
    end
    it '自分の投稿と他人の投稿の内容が表示される' do
      expect(page).to have_content post.caption.slice(0..5)
      expect(page).to have_content other_post.caption.slice(0..5)
    end
  end

  context '投稿成功のテスト' do
    before do
      fill_in 'post[title]', with: Faker::Lorem.characters(number: 5)
      fill_in 'post[caption]', with: Faker::Lorem.characters(number: 20)
    end

    it 'リダイレクト先が、保存できた投稿の詳細画面になっている' do
      click_button '投稿'
      expect(current_path).to eq'/posts/' + Post.last.id.to_s
    end
  end

  describe '自分のユーザ詳細画面のテスト' do
    before do
      visit user_path(user)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
      it '投稿一覧のユーザ画像のリンク先が正しい' do
        expect(page).to have_link '', href: user_path(user)
      end
    end
  end

  describe '自分のユーザ情報編集画面のテスト' do
    before do
      visit edit_user_path(user)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s + '/edit'
      end
    end

    context '更新成功のテスト' do
      before do
        @user_old_name = user.name
        @user_old_intrpduction = user.introduction
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 9)
        fill_in 'user[introduction]', with: Faker::Lorem.characters(number: 19)
        click_button 'Update User'
      end

       it 'リダイレクト先が、自分のユーザ詳細画面になっている' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
    end
  end
end