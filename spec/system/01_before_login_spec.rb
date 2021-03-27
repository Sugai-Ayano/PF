  require 'rails_helper'

  describe '[STEP1]ユーザーログイン前のテスト' do
    describe 'トップ画面のテスト' do
      before do
        visit root_path
      end

      context '表示内容の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq '/'
        end
      end
    end

    describe 'サイト詳細画面のテスト' do
      before do
        visit '/about'
      end

      context '表示内容の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq '/about'
        end
      end
    end

    describe 'サイト詳細のテスト' do
      before do
        visit '/about'
      end

      context 'リンクの内容を確認' do
        subject { current_path }

        it 'ホームを押すとトップ画面に遷移する' do
          home_link = find_all('a')[0].native.inner_text
          home_link = home_link.delete('')
          home_link.gsub!(/\n/, '')
          click_link home_link
          expect(current_path).to eq root_path
        end
        it 'サイト詳細を押すと、サイト詳細画面に遷移する' do
          about_link = find_all('a')[1].native.inner_text
          about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link about_link
          expect(current_path).to eq about_path

        end
        it 'ログインを押すと、ログイン画面に遷移する' do
          login_link = find_all('a')[2].native.inner_text
          login_link = login_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link login_link
          expect(current_path).to eq new_user_session_path
        end
        it '新規登録を押すと、新規登録画面に遷移する' do
          signup_link = find_all('a')[3].native.inner_text
          signup_link = signup_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link signup_link
          expect(current_path).to eq new_user_registration_path
        end
      end
    end

    describe 'ユーザー新規登録のテスト' do
      before do
        fill_in 'user[name]', with:Faker::Lorem.characters(numbers: 10)
        fill_in 'user[email]', with:Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end
    end

    describe 'ユーザーログイン' do
      let(:user){ create(:user) }

      before do
        visit new_user_session_path
      end

      context 'ログイン失敗のテスト' do
        before do
          fill_in 'user[email]', with: ""
          fill_in 'user[password]', with: ""
          click_button 'ログイン'
        end

        it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
          expect(current_path).to eq'/users/sign_in'
        end
      end
    end
  end