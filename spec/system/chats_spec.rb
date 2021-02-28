require 'rails_helper'

RSpec.describe "チャット", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.build(:user)
    @user2.nickname = "シンジ"
    @chat_text1 = Faker::Lorem.sentence
    @chat_text2 = Faker::Lorem.sentence
  end
  context 'チャットができるとき' do 
    it '正しい値を入力すればチャットができる' do
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
      # ログアウトする
      find(".post-j").click
      # ログインする
      sign_in(@user)
      # 検索したいユーザーのニックネームを検索バーに入力する
      fill_in 'keyword', with: @user2.nickname
      # ヘッダーの検索ボタンをクリックする
      find('input[name="commit"]').click
      # 検索したユーザー名と「友達ではありません」が表示されていることを確認する
      expect(page).to have_content(@user2.nickname)
      expect(page).to have_content('友達ではありません')
      # 検索したユーザーの詳細画面へ移動
      visit user_path(@user2.id)
      # @user2の詳細画面へ遷移したことを確認する
      expect(current_path).to eq(user_path(@user2.id))
      # チャットアイコンをクリックするとチャットモデルのカウントが1上がる
      expect{
        find(".messanger_img").click
      }.to change { Chat.count }.by(1)
      # フォームに情報を入力する
      attach_file "message_image", "#{Rails.root}/spec/fixtures/Yokosuka.jpg", make_visible: true
      fill_in 'content', with: @chat_text1
      # 送信するとMessageモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Message.count }.by(1)
      # メッセージが未読状態になっていて、送信済みの画像とテキストが表示されていることを確認する
      expect(page).to have_content('未読')
      expect(page).to have_selector("img[src$='Yokosuka.jpg']")
      expect(page).to have_content(@chat_text1)
      # ログアウトする
      find(".post-j").click
      # @user2でログインする
      visit new_user_session_path
      fill_in 'email', with: @user2.email
      fill_in 'password', with: @user2.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # @userの詳細画面へ移動する
      visit user_path(@user.id)
      # @userの詳細画面へ遷移したことを確認する
      expect(current_path).to eq(user_path(@user.id))
      # チャットアイコンをクリックしてもチャットモデルのカウントが変わらない
      expect{
        find(".messanger_img").click
      }.to change { Chat.count }.by(0)
      # 受信したメッセージを確認する
      expect(page).to have_selector("img[src$='Yokosuka.jpg']")
      expect(page).to have_content(@chat_text1)
      # フォームに情報を入力する
      fill_in 'content', with: @chat_text2
      # 送信するとMessageモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Message.count }.by(1)
      # 送信したメッセージを確認する
      expect(page).to have_content(@chat_text2)
      # ログアウトする
      find(".post-j").click
      # ログインする
      sign_in(@user)
      # @user2の詳細画面へ移動
      visit user_path(@user2.id)
      # チャットアイコンをクリックしてチャットページへ移動する
      find(".messanger_img").click
      # 送受信したメッセージ全て表示されていて、自分が送信したメッセージが既読になっていることを確認する
      expect(page).to have_content('既読')
      expect(page).to have_selector("img[src$='Yokosuka.jpg']")
      expect(page).to have_content(@chat_text1)
      expect(page).to have_content(@chat_text2)
    end
    it 'テキストのみ(画像無し)でもチャットができる' do
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
      # ログアウトする
      find(".post-j").click
      # ログインする
      sign_in(@user)
      # 検索したいユーザーのニックネームを検索バーに入力する
      fill_in 'keyword', with: @user2.nickname
      # ヘッダーの検索ボタンをクリックする
      find('input[name="commit"]').click
      # 検索したユーザー名と「友達ではありません」が表示されていることを確認する
      expect(page).to have_content(@user2.nickname)
      expect(page).to have_content('友達ではありません')
      # 検索したユーザーの詳細画面へ移動
      visit user_path(@user2.id)
      # @user2の詳細画面へ遷移したことを確認する
      expect(current_path).to eq(user_path(@user2.id))
      # チャットアイコンをクリックするとチャットモデルのカウントが1上がる
      expect{
        find(".messanger_img").click
      }.to change { Chat.count }.by(1)
      # フォームに情報を入力する
      fill_in 'content', with: @chat_text1
      # 送信するとMessageモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Message.count }.by(1)
      # メッセージが未読状態になっていて、送信済みの画像とテキストが表示されていることを確認する
      expect(page).to have_content('未読')
      expect(page).to have_content(@chat_text1)
      # ログアウトする
      find(".post-j").click
      # @user2でログインする
      visit new_user_session_path
      fill_in 'email', with: @user2.email
      fill_in 'password', with: @user2.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # @userの詳細画面へ移動する
      visit user_path(@user.id)
      # @userの詳細画面へ遷移したことを確認する
      expect(current_path).to eq(user_path(@user.id))
      # チャットアイコンをクリックしてもチャットモデルのカウントが変わらない
      expect{
        find(".messanger_img").click
      }.to change { Chat.count }.by(0)
      # 受信したメッセージを確認する
      expect(page).to have_content(@chat_text1)
      # フォームに情報を入力する
      fill_in 'content', with: @chat_text2
      # 送信するとMessageモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Message.count }.by(1)
      # 送信したメッセージを確認する
      expect(page).to have_content(@chat_text2)
      # ログアウトする
      find(".post-j").click
      # ログインする
      sign_in(@user)
      # @user2の詳細画面へ移動
      visit user_path(@user2.id)
      # チャットアイコンをクリックしてチャットページへ移動する
      find(".messanger_img").click
      # 送受信したメッセージ全て表示されていて、自分が送信したメッセージが既読になっていることを確認する
      expect(page).to have_content('既読')
      expect(page).to have_content(@chat_text1)
      expect(page).to have_content(@chat_text2)
    end
    it '画像のみでも(テキスト無し)でもチャットができる' do
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
      # ログアウトする
      find(".post-j").click
      # ログインする
      sign_in(@user)
      # 検索したいユーザーのニックネームを検索バーに入力する
      fill_in 'keyword', with: @user2.nickname
      # ヘッダーの検索ボタンをクリックする
      find('input[name="commit"]').click
      # 検索したユーザー名と「友達ではありません」が表示されていることを確認する
      expect(page).to have_content(@user2.nickname)
      expect(page).to have_content('友達ではありません')
      # 検索したユーザーの詳細画面へ移動
      visit user_path(@user2.id)
      # @user2の詳細画面へ遷移したことを確認する
      expect(current_path).to eq(user_path(@user2.id))
      # チャットアイコンをクリックするとチャットモデルのカウントが1上がる
      expect{
        find(".messanger_img").click
      }.to change { Chat.count }.by(1)
      # フォームに情報を入力する
      attach_file "message_image", "#{Rails.root}/spec/fixtures/Yokosuka.jpg", make_visible: true
      # 送信するとMessageモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Message.count }.by(1)
      # メッセージが未読状態になっていて、送信済みの画像とテキストが表示されていることを確認する
      expect(page).to have_content('未読')
      expect(page).to have_selector("img[src$='Yokosuka.jpg']")
      # ログアウトする
      find(".post-j").click
      # @user2でログインする
      visit new_user_session_path
      fill_in 'email', with: @user2.email
      fill_in 'password', with: @user2.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # @userの詳細画面へ移動する
      visit user_path(@user.id)
      # @userの詳細画面へ遷移したことを確認する
      expect(current_path).to eq(user_path(@user.id))
      # チャットアイコンをクリックしてもチャットモデルのカウントが変わらない
      expect{
        find(".messanger_img").click
      }.to change { Chat.count }.by(0)
      # 受信したメッセージを確認する
      expect(page).to have_selector("img[src$='Yokosuka.jpg']")
      # フォームに情報を入力する
      fill_in 'content', with: @chat_text2
      # 送信するとMessageモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Message.count }.by(1)
      # 送信したメッセージを確認する
      expect(page).to have_content(@chat_text2)
      # ログアウトする
      find(".post-j").click
      # ログインする
      sign_in(@user)
      # @user2の詳細画面へ移動
      visit user_path(@user2.id)
      # チャットアイコンをクリックしてチャットページへ移動する
      find(".messanger_img").click
      # 送受信したメッセージ全て表示されていて、自分が送信したメッセージが既読になっていることを確認する
      expect(page).to have_content('既読')
      expect(page).to have_selector("img[src$='Yokosuka.jpg']")
      expect(page).to have_content(@chat_text2)
    end
  end
  context 'チャットができないとき' do
    it '不正な値を入力すルトメッセージを送信できない' do
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
      # ログアウトする
      find(".post-j").click
      # ログインする
      sign_in(@user)
      # 検索したいユーザーのニックネームを検索バーに入力する
      fill_in 'keyword', with: @user2.nickname
      # ヘッダーの検索ボタンをクリックする
      find('input[name="commit"]').click
      # 検索したユーザー名と「友達ではありません」が表示されていることを確認する
      expect(page).to have_content(@user2.nickname)
      expect(page).to have_content('友達ではありません')
      # 検索したユーザーの詳細画面へ移動
      visit user_path(@user2.id)
      # @user2の詳細画面へ遷移したことを確認する
      expect(current_path).to eq(user_path(@user2.id))
      # チャットアイコンをクリックするとチャットモデルのカウントが1上がる
      expect{
        find(".messanger_img").click
      }.to change { Chat.count }.by(1)
      # フォームに情報を入力する
      fill_in 'content', with: ''
      # 送信するとMessageモデルのカウントが変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Message.count }.by(0)
    end
  end
end