require 'rails_helper'

RSpec.describe "チャット", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.build(:user)
    @user2.nickname = "シンジ"
  end
  context '足跡が確認できるとき' do 
    it '足跡が確認できる' do
      # トップページへ移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがある
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'nickname', with: @user2.nickname
      fill_in 'profile', with: @user2.profile
      fill_in 'email', with: @user2.email
      fill_in 'password', with: @user2.password
      fill_in 'password-confirmation', with: @user2.password_confirmation
      fill_in 'last-name', with: @user2.family_name_kanji
      fill_in 'first-name', with: @user2.first_name_kanji
      fill_in 'last-name-kana', with: @user2.family_name_kana
      fill_in 'first-name-kana', with: @user2.first_name_kana
      select @user2.birthday.to_s.slice(0..3), from: 'user_birthday_1i'
      select @user2.birthday.to_s.slice(5..6).to_i, from: 'user_birthday_2i'
      select @user2.birthday.to_s.slice(8..9).to_i, from: 'user_birthday_3i'
      # サインアップボタンを押すとユーザーモデルのカウントが1上がる
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # 正しい情報を入力すればユーザー新規登録ができてトップページに移動したことを確認する
      expect(current_path).to eq(root_path)
      @user2.id = @user.id + 1
      # @userの詳細ページへ移動し、足跡をつける
      visit user_path(@user.id)
      # ログアウトする
      find(".post-j").click
      # ログインする
      sign_in(@user)
      # 足跡アイコンをクリックする
      find(".footprint-icon").click
      # 足跡ページへ遷移したことを確認する
      expect(current_path).to eq("/footprints")
      # アクセス数とアクセス履歴を確認できる
      expect(page).to have_content('詳細ページアクセス数：')
      expect(page).to have_content(@user2.nickname)
    end
  end
  context '足跡が確認できないとき' do 
    it '誰もアクセスしていなければ足跡が確認できない' do
      # ログインする
      sign_in(@user)
      # 足跡アイコンをクリックする
      find(".footprint-icon").click
      # 足跡ページへ遷移したことを確認する
      expect(current_path).to eq("/footprints")
      # アクセス履歴が確認できない
      expect(page).to have_no_content(@user2.nickname)
    end
  end
end