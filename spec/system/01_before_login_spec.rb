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
    end

    describe 'サイト詳細のテスト' do
      before do
        visit '/home/about'
      end

      context '表示内容の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq'/home/about'
        end
      end

      context 'リンクの内容を確認' do
        subject { current_path }

        it 'ホームを押すとトップ画面に遷移する' do
          home_link = find_all('a')[1].native.inner_text
          home_link = home_link.delete('')
          home_link.gsub!(/\n/, '')
          click_link home_link
          is_expexted.to eq '/'
        end
        it 'サイト詳細を押すと、サイト詳細画面に遷移する' do
          about_link = find_all('a')[2].native.inner_text
          about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link about_link
          is_expexted.to eq '/home/about'
        end
        it 'ログインを押すと、ログイン画面に遷移する'
        login_link = find_all('a')[3].native.inner_text
        login_link = login_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link login_link
        is_expexted.to eq '/users/sign_in'

        it '新規登録を押すと、新規登録画面に遷移する' do
          signup_link = find_all('a')[4].native.inner_text
          signup_link = signup_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link signup_link
          is_expexted.to eq '/users/sign_up'
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
      
      it '正しく登録される' do
        expect{click_button '新規登録'}.to
        change(User.all, :count).by(1)
      end
    end
    
    describe 'ユーザーログイン'
    let(:user){ create(:user) }
    
    before do
      visit new_user_session_path
    end
    
    context 'ログイン成功のテスト' do
      before do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
      end
      
      it 'ログイン後のリダイレクト先が、投稿一覧画面になっている' do
        expect()
      end
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
  
  describe 'ログアウトのテスト' do
    let(:user){ craete(:user) }
    
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
      logout_link = find_all('a')[5].native.inner_text
      logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link logout_link
    end
    
    context 'ログアウト機能のテスト' do
      it '正しくログアウトできている: ログアウト後のリダイレクト先においてサイト詳細画面へのリンクが存在する' do
        expect(page).to have_link"", href:'/home/about'
      end
    end
  end
end