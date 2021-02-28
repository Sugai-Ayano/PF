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
        it 'ログインリンクが表示される:左上から3番目のリンクが「ログイン」である' do
          log_in_link = find_all('a')[3].native.inner_text
          expect(log_in_link).to match(/log in/i)
        end
        it 'ログインリンクの内容が正しい' do
          log_in_link = find_all('a')[3].native.inner_text
          expect(page).to have_link log_in_link,href:
          new_user_session_path
        end
        it '新規登録リンクが表示される:左上から4番目のリンクが「新規登録」であるy' do
          sign_up_link = find_all('a')[4].native.inner_text
          expect(sign_up_link).to match(/sign up/i)
        end
        it '新規登録リンクの内容が正しい' do
          sign_up_link = find_all('a')[4].native.inner_text
          expect(page).to have_link sign_up_link,href:
          new_user_registration_path
        end
      end
    end
    
    describe 'サイト詳細画面のテスト' do
      before do
        visit '/home/about'
      end
      
      context '表示内容の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq '/home/about'
        end
      end
    end
    
    describe 'ヘッダーのテスト:ログインしていない場合' do
      before do
        visit root_path
      end
      
      context '表示内容の確認' do
        it 'ホームリンクが表示される:左上から1番目のリンクが「ホーム」である' do
          home_link = find_all('a')[1].native.inner_text
          expect(home_link).to match(/home/i)
        end
        it 'サイト詳細リンクが表示される:左上から2番目のリンクが「サイト詳細」である' do
          about_link = find_all('a')[2].native.inner_text
          expect(about_link).to match(/about/i)
        end
        it 'ログインリンクが表示される:左上から3番目のリンクが「ログイン」である' do
          login_link = find_all('a')[3].native.inner_text
          expect(login_link).to match(/login/i)
        end
        it '新規登録リンクが表示される:左上から4番目のリンクが「新規登録」である' do
          signup_link = find_all('a')[4].native.inner_text
          expect(signup_link).to match(/sign up/i)
        end
  end