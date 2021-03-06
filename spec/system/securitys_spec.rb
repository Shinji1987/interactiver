require 'rails_helper'

RSpec.describe "ブロック機能", :type => :system do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.build(:user)
    @user2.nickname = "シンジ"
  end

  context 'ブロックできるとき' do 
    it 'ブロックできる' do
      # トップページへ移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがある
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'nickname', :with => @user2.nickname
      fill_in 'profile', :with => @user2.profile
      fill_in 'email', :with => @user2.email
      fill_in 'password', :with => @user2.password
      fill_in 'password-confirmation', :with => @user2.password_confirmation
      fill_in 'last-name', :with => @user2.family_name_kanji
      fill_in 'first-name', :with => @user2.first_name_kanji
      fill_in 'last-name-kana', :with => @user2.family_name_kana
      fill_in 'first-name-kana', :with => @user2.first_name_kana
      select @user2.birthday.to_s.slice(0..3), :from => 'user_birthday_1i'
      select @user2.birthday.to_s.slice(5..6).to_i, :from => 'user_birthday_2i'
      select @user2.birthday.to_s.slice(8..9).to_i, :from => 'user_birthday_3i'
      # サインアップボタンを押すとユーザーモデルのカウントが1上がる
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # 正しい情報を入力すればユーザー新規登録ができてトップページに移動したことを確認する
      expect(current_path).to eq(root_path)
      @user2.id = @user.id + 1
      # @userのニックネームを検索バーに入力する
      fill_in 'keyword', :with => @user.nickname
      # ヘッダーの検索ボタンをクリックする
      find('input[name="commit"]').click
      # ブロックされる前は検索したユーザー名が表示されていることを確認する
      expect(page).to have_content(@user.nickname)
      # ログアウトする
      find(".post-j").click
      # ログインする
      sign_in(@user)
      # セキュリティアイコンをクリックする
      find(".security-icon").click
      # ブロックページへ遷移したことを確認する
      expect(current_path).to eq("/securitys/new.#{@user.id}")
      # 検索したいユーザーのニックネームを検索バーに入力する
      fill_in 'keyword', :with => @user2.nickname
      # ヘッダーの検索ボタンをクリックする
      find('input[name="commit"]').click
      # 検索したユーザー名が表示されていることを確認する
      expect(page).to have_content(@user2.nickname)
      # ブロックボタンをクリックするとセキュリティモデルのカウントが1上がる
      expect{
        find(".block_button_icon").click
      }.to change { Security.count }.by(1)
      # ログアウトする
      find(".post-j").click
      # @user2でログインする
      visit new_user_session_path
      fill_in 'email', :with => @user2.email
      fill_in 'password', :with => @user2.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # @userのニックネームを検索バーに入力する
      fill_in 'keyword', :with => @user.nickname
      # ヘッダーの検索ボタンをクリックする
      find('input[name="commit"]').click
      # ブロック後は検索したユーザー名が表示されないことを確認する
      expect(page).to have_no_content(@user.nickname)  
    end
    it 'ブロックを解除できる' do
      # トップページへ移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがある
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'nickname', :with => @user2.nickname
      fill_in 'profile', :with => @user2.profile
      fill_in 'email', :with => @user2.email
      fill_in 'password', :with => @user2.password
      fill_in 'password-confirmation', :with => @user2.password_confirmation
      fill_in 'last-name', :with => @user2.family_name_kanji
      fill_in 'first-name', :with => @user2.first_name_kanji
      fill_in 'last-name-kana', :with => @user2.family_name_kana
      fill_in 'first-name-kana', :with => @user2.first_name_kana
      select @user2.birthday.to_s.slice(0..3), :from => 'user_birthday_1i'
      select @user2.birthday.to_s.slice(5..6).to_i, :from => 'user_birthday_2i'
      select @user2.birthday.to_s.slice(8..9).to_i, :from => 'user_birthday_3i'
      # サインアップボタンを押すとユーザーモデルのカウントが1上がる
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # 正しい情報を入力すればユーザー新規登録ができてトップページに移動したことを確認する
      expect(current_path).to eq(root_path)
      @user2.id = @user.id + 1
      # @userのニックネームを検索バーに入力する
      fill_in 'keyword', :with => @user.nickname
      # ヘッダーの検索ボタンをクリックする
      find('input[name="commit"]').click
      # ブロックされる前は検索したユーザー名が表示されていることを確認する
      expect(page).to have_content(@user.nickname)
      # ログアウトする
      find(".post-j").click
      # ログインする
      sign_in(@user)
      # セキュリティアイコンをクリックする
      find(".security-icon").click
      # ブロックページへ遷移したことを確認する
      expect(current_path).to eq("/securitys/new.#{@user.id}")
      # 検索したいユーザーのニックネームを検索バーに入力する
      fill_in 'keyword', :with => @user2.nickname
      # ヘッダーの検索ボタンをクリックする
      find('input[name="commit"]').click
      # 検索したユーザー名が表示されていることを確認する
      expect(page).to have_content(@user2.nickname)
      # ブロックボタンをクリックするとセキュリティモデルのカウントが1上がる
      expect{
        find(".block_button_icon").click
      }.to change { Security.count }.by(1)
      # ログアウトする
      find(".post-j").click
      # @user2でログインする
      visit new_user_session_path
      fill_in 'email', :with => @user2.email
      fill_in 'password', :with => @user2.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # @userのニックネームを検索バーに入力する
      fill_in 'keyword', :with => @user.nickname
      # ヘッダーの検索ボタンをクリックする
      find('input[name="commit"]').click
      # ブロック後は検索したユーザー名が表示されないことを確認する
      expect(page).to have_no_content(@user.nickname)  
      # ログアウトする
      find(".post-j").click
      # ログインする
      sign_in(@user)
      # セキュリティアイコンをクリックする
      find(".security-icon").click
      # ブロックページへ遷移したことを確認する
      expect(current_path).to eq("/securitys/new.#{@user.id}")
      # ブロックページのブロックリスト内に@user2が表示されていることを確認する
      expect(page).to have_content(@user2.nickname) 
      expect(page).to have_content('ブロックしています')
      # ブロック解除ボタンをクリックするとセキュリティモデルのカウントが1下がる
      expect{
        find(".block_button_icon").click
      }.to change { Security.count }.by(-1)
      # ログアウトする
      find(".post-j").click
      # @user2でログインする
      visit new_user_session_path
      fill_in 'email', :with => @user2.email
      fill_in 'password', :with => @user2.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # @userのニックネームを検索バーに入力する
      fill_in 'keyword', :with => @user.nickname
      # ヘッダーの検索ボタンをクリックする
      find('input[name="commit"]').click
      # ブロック解除後は検索したユーザー名が表示されることを確認する
      expect(page).to have_content(@user.nickname)
    end
  end
end
