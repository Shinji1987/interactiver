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
  context '詳細ページを確認できないとき' do
    it 'ログインしていないと詳細画面へ移動できない' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      visit user_path(@user.id)
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe "編集", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ユーザー情報の編集ができるとき' do 
    it 'ログインしたら詳細ページを編集できる' do
      # ログインする
      sign_in(@user)
      # 詳細ページに移動する
      visit user_path(@user.id)
      # ユーザー情報編集画面へ移動する
      find('input[name="user_edit_btn"]').click
      # すでに登録済みのユーザー情報がフォームに入っていることを確認する
      expect(
        find('#nickname').value
      ).to eq(@user.nickname)
      expect(
        find('#profile').value
      ).to eq(@user.profile)
      expect(
        find('#last-name').value
      ).to eq(@user.family_name_kanji)
      expect(
        find('#first-name').value
      ).to eq(@user.first_name_kanji)
      expect(
        find('#last-name-kana').value
      ).to eq(@user.family_name_kana)
      expect(
        find('#first-name-kana').value
      ).to eq(@user.first_name_kana)
      expect(
        find('#user_birthday_1i').value
      ).to eq(@user.birthday.to_s.slice(0..3))
      expect(
        find('#user_birthday_2i').value
      ).to eq(@user.birthday.to_s.slice(5..6).to_i.to_s)
      expect(
        find('#user_birthday_3i').value
      ).to eq(@user.birthday.to_s.slice(8..9).to_i.to_s)
      # ユーザー情報を編集する
      fill_in 'nickname', with: 'テスト中'
      fill_in 'profile', with: 'テストをしています'
      fill_in 'last-name', with: '近藤'
      fill_in 'first-name', with: '秀明'
      fill_in 'last-name-kana', with: 'コンドウ'
      fill_in 'first-name-kana', with: 'ヒデアキ'
      select 1970, from: 'user_birthday_1i'
      select 1, from: 'user_birthday_2i'
      select 3, from: 'user_birthday_3i'
      # 編集してもTweetモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 詳細画面に遷移したことを確認する
      expect(current_path).to eq(user_path(@user.id))
      # 詳細ページで更新したユーザー情報が表示されていることを確認
      expect(page).to have_content('テスト中')
      expect(page).to have_content('テストをしています')
      expect(page).to have_content('近藤秀明')
      expect(page).to have_content('コンドウヒデアキ')
      expect(page).to have_content('1970-01-03')
    end
  end
  context 'ユーザー情報の編集ができないとき' do
    it 'ログインしていないと詳細画面へ移動できない' do
      # トップ画面へ移動する
      visit root_path
      # ユーザー変種画面へ移動しようとする
      visit edit_user_path(@user)
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
    it '必須項目の値を空にすると変更できない' do
      # ログインする
      sign_in(@user)
      # 詳細ページに移動する
      visit user_path(@user.id)
      # ユーザー情報編集画面へ移動する
      find('input[name="user_edit_btn"]').click
      # すでに登録済みのユーザー情報がフォームに入っていることを確認する
      expect(
        find('#nickname').value
      ).to eq(@user.nickname)
      expect(
        find('#profile').value
      ).to eq(@user.profile)
      expect(
        find('#last-name').value
      ).to eq(@user.family_name_kanji)
      expect(
        find('#first-name').value
      ).to eq(@user.first_name_kanji)
      expect(
        find('#last-name-kana').value
      ).to eq(@user.family_name_kana)
      expect(
        find('#first-name-kana').value
      ).to eq(@user.first_name_kana)
      expect(
        find('#user_birthday_1i').value
      ).to eq(@user.birthday.to_s.slice(0..3))
      expect(
        find('#user_birthday_2i').value
      ).to eq(@user.birthday.to_s.slice(5..6).to_i.to_s)
      expect(
        find('#user_birthday_3i').value
      ).to eq(@user.birthday.to_s.slice(8..9).to_i.to_s)
      # ユーザー情報を編集する
      fill_in 'nickname', with: ''
      fill_in 'profile', with: ''
      fill_in 'last-name', with: ''
      fill_in 'first-name', with: ''
      fill_in 'last-name-kana', with: ''
      fill_in 'first-name-kana', with: ''
      select '--', from: 'user_birthday_1i'
      select '--', from: 'user_birthday_2i'
      select '--', from: 'user_birthday_3i'
      # 変更ボタンをクリック
        find('input[name="commit"]').click
      # 編集ページへ戻ったことを確認する
      expect(current_path).to eq("/users/#{@user.id}")
    end
  end
end

RSpec.describe "検索", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.build(:user)
    @user2.nickname = "シンジ"
  end
  context 'ユーザーを検索できるとき' do 
    it 'ログインしたらユーザーを検索できる' do
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
      # ログアウトする
      find(".post-j").click
      # ログインする
      sign_in(@user)
      # 検索したいユーザーのニックネームを検索バーに入力する
      fill_in 'keyword', with: @user2.nickname
      # ヘッダーの検索ボタンをクリックする
      find('input[name="commit"]').click
      # 検索したユーザー名が表示されていることを確認する
      expect(page).to have_content(@user2.nickname)
    end
  end
end