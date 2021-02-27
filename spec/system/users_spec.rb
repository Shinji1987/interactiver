require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページへ移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがある
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'nickname', with: @user.nickname
      fill_in 'profile', with: @user.profile
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      fill_in 'password-confirmation', with: @user.password_confirmation
      fill_in 'last-name', with: @user.family_name_kanji
      fill_in 'first-name', with: @user.first_name_kanji
      fill_in 'last-name-kana', with: @user.family_name_kana
      fill_in 'first-name-kana', with: @user.first_name_kana
      select @user.birthday.to_s.slice(0..3), from: 'user_birthday_1i'
      select @user.birthday.to_s.slice(5..6).to_i, from: 'user_birthday_2i'
      select @user.birthday.to_s.slice(8..9).to_i, from: 'user_birthday_3i'
      # サインアップボタンを押すとユーザーモデルのカウントが1上がる
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # 正しい情報を入力すればユーザー新規登録ができてトップページに移動したことを確認する
      expect(current_path).to eq(root_path)
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていない
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページへ移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがある
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'nickname', with: ''
      fill_in 'profile', with: ''
      fill_in 'email', with: ''
      fill_in 'password', with: ''
      fill_in 'password-confirmation', with: ''
      fill_in 'last-name', with: ''
      fill_in 'first-name', with: ''
      fill_in 'last-name-kana', with: ''
      fill_in 'first-name-kana', with: ''
      select @user.birthday.to_s.slice(0..3), from: 'user_birthday_1i'
      select @user.birthday.to_s.slice(5..6).to_i, from: 'user_birthday_2i'
      select @user.birthday.to_s.slice(8..9).to_i, from: 'user_birthday_3i'
      # サインアップボタンを押してもユーザーモデルのカウントは上がらない
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる
      expect(current_path).to eq('/users')
    end
  end
end

RSpec.describe "ログイン", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do 
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'email', with: ''
      fill_in 'password', with: ''
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe "詳細ページ", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context '詳細ページを確認できるとき' do 
    it 'ログインしたら詳細ページを確認できる' do
      # ログインする
      sign_in(@user)
      # 自分のニックネームがヘッダー上にあることを確認
      expect(page).to have_content(@user.nickname)
      # 詳細ページへ推移する
      visit user_path(@user.id)
      # 詳細ページで各種テーブルが表示されていることを確認
      expect(page).to have_content("#{@user.nickname}さんの情報")
      expect(page).to have_content("友達リスト:")
      expect(page).to have_content("【ユーザー情報】")
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content(@user.profile)
      expect(page).to have_content(@user.email)
      expect(page).to have_content(@user.family_name_kanji + @user.first_name_kanji)
      expect(page).to have_content(@user.family_name_kana + @user.first_name_kana)
      expect(page).to have_content(@user.birthday.to_s)
      expect(page).to have_content("【店舗情報】")
      expect(page).to have_content("＜店舗写真＞")
      expect(page).to have_content("お店の場所を確認してみましょう！↓　↓　↓")
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # # トップページに移動する
      # visit root_path
      # # トップページにログインページへ遷移するボタンがあることを確認する
      # expect(page).to have_content('ログイン')
      # # ログインページへ遷移する
      # visit new_user_session_path
      # # ユーザー情報を入力する
      # fill_in 'email', with: ''
      # fill_in 'password', with: ''
      # # ログインボタンを押す
      # find('input[name="commit"]').click
      # # ログインページへ戻されることを確認する
      # expect(current_path).to eq(new_user_session_path)
    end
  end
end