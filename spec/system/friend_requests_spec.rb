require 'rails_helper'

RSpec.describe "友達機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.build(:user)
    @user2.nickname = "シンジ"
  end
  context '友達関係を構築できるとき' do 
    it '友達関係を構築できる' do
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
      # 詳細画面へ遷移したことを確認する
      expect(current_path).to eq(user_path(@user2.id))
      # 友達申請ボタンを押すと友達モデルのカウントが1上がる
      expect{
        find(".friend_request_img").click
        visit user_path(@user2.id)
      }.to change { FriendRequest.count }.by(1)
      # ログアウトする
      find(".post-j").click
      # @user2でログインする
      visit new_user_session_path
      fill_in 'email', with: @user2.email
      fill_in 'password', with: @user2.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # @user2の詳細画面へ移動する
      visit user_path(@user2.id)
      # 「1件の友達申請」の表示があることを確認する
      expect(page).to have_content('1件の友達申請')
      # 友達アイコンをクリックして友達申請承認ページへ移動する
      find(".friend-request-icon").click
      # @user2のニックネームが表示されていることを確認する
      expect(page).to have_content(@user2.nickname)
      # 承認ボタンを押すと友達モデルのrequesting_statusが1から2になる
      @friend_request = FriendRequest.all.slice(0)
      @friend_request.requesting_status == 1
      find('.accept_button_icon').click
      @friend_request.requesting_status == 2
      # @user2の詳細ページへ遷移することを確認
      expect(current_path).to eq(user_path(@user2.id))
      # 友達リストの中に@userが表示されていることを確認する
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content('友達リスト: 1人')
    end
    it '友達申請を拒否できる' do
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
      # 詳細画面へ遷移したことを確認する
      expect(current_path).to eq(user_path(@user2.id))
      # 友達申請ボタンを押すと友達モデルのカウントが1上がる
      expect{
        find(".friend_request_img").click
        visit user_path(@user2.id)
      }.to change { FriendRequest.count }.by(1)
      # ログアウトする
      find(".post-j").click
      # @user2でログインする
      visit new_user_session_path
      fill_in 'email', with: @user2.email
      fill_in 'password', with: @user2.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # @user2の詳細画面へ移動する
      visit user_path(@user2.id)
      # 「1件の友達申請」の表示があることを確認する
      expect(page).to have_content('1件の友達申請')
      # 友達アイコンをクリックして友達申請承認ページへ移動する
      find(".friend-request-icon").click
      # @user2のニックネームが表示されていることを確認する
      expect(page).to have_content(@user2.nickname)
      # 承認拒否ボタンを押すと友達モデルのカウントが1下がる
      expect{
        find('.reject_button_icon').click
      }.to change { FriendRequest.count }.by(-1)
      # @user2の詳細ページへ遷移することを確認
      expect(current_path).to eq(user_path(@user2.id))
      # 友達リストの中に@userが表示されていることを確認する
      expect(page).to have_no_content(@user.nickname)
      expect(page).to have_content('友達リスト: 0人')
    end
  end
  context '友達関係を解除できるとき' do 
    it '友達関係を解除できる' do
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
      # 詳細画面へ遷移したことを確認する
      expect(current_path).to eq(user_path(@user2.id))
      # 友達申請ボタンを押すと友達モデルのカウントが1上がる
      expect{
        find(".friend_request_img").click
        visit user_path(@user2.id)
      }.to change { FriendRequest.count }.by(1)
      # ログアウトする
      find(".post-j").click
      # @user2でログインする
      visit new_user_session_path
      fill_in 'email', with: @user2.email
      fill_in 'password', with: @user2.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # @user2の詳細画面へ移動する
      visit user_path(@user2.id)
      # 「1件の友達申請」の表示があることを確認する
      expect(page).to have_content('1件の友達申請')
      # 友達アイコンをクリックして友達申請承認ページへ移動する
      find(".friend-request-icon").click
      # @user2のニックネームが表示されていることを確認する
      expect(page).to have_content(@user2.nickname)
      # 承認ボタンを押すと友達モデルのrequesting_statusが1から2になる
      @friend_request = FriendRequest.all.slice(0)
      @friend_request.requesting_status == 1
      find('.accept_button_icon').click
      @friend_request.requesting_status == 2
      # @user2の詳細ページへ遷移することを確認
      expect(current_path).to eq(user_path(@user2.id))
      # 友達リストの中に@userが表示されていることを確認する
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content('友達リスト: 1人')
      # @userの詳細ページへ移動する
      visit user_path(@user.id)
      # @userの詳細ページへ遷移することを確認
      expect(current_path).to eq(user_path(@user.id))
      # 既に友達のユーザーの詳細ページ上には、友達申請アイコンがなく、代わりに友達アイコンが表示されている
      expect(page).to have_no_content('友達ではありません')
      expect(page).to have_content('既に友達です')
      # 友達アイコンをクリックすると友達モデルのカウントが1下がる
      expect{
        find('.already_friend_img').click
        visit user_path(@user.id)
      }.to change { FriendRequest.count }.by(-1)
      # 詳細ページ上には、友達アイコンがなく、代わりに友達申請アイコンが表示されている
      expect(page).to have_content('友達申請')
      expect(page).to have_no_content('既に友達です')
    end
  end
  context '友達申請を送信できないとき' do
    it '既に友達関係があるユーザーには友達申請を送信できない' do
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
      # 詳細画面へ遷移したことを確認する
      expect(current_path).to eq(user_path(@user2.id))
      # 友達申請ボタンを押すと友達モデルのカウントが1上がる
      expect{
        find(".friend_request_img").click
        visit user_path(@user2.id)
      }.to change { FriendRequest.count }.by(1)
      # ログアウトする
      find(".post-j").click
      # @user2でログインする
      visit new_user_session_path
      fill_in 'email', with: @user2.email
      fill_in 'password', with: @user2.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # @user2の詳細画面へ移動する
      visit user_path(@user2.id)
      # 「1件の友達申請」の表示があることを確認する
      expect(page).to have_content('1件の友達申請')
      # 友達アイコンをクリックして友達申請承認ページへ移動する
      find(".friend-request-icon").click
      # @user2のニックネームが表示されていることを確認する
      expect(page).to have_content(@user2.nickname)
      # 承認ボタンを押すと友達モデルのrequesting_statusが1から2になる
      @friend_request = FriendRequest.all.slice(0)
      @friend_request.requesting_status == 1
      find('.accept_button_icon').click
      @friend_request.requesting_status == 2
      # @user2の詳細ページへ遷移することを確認
      expect(current_path).to eq(user_path(@user2.id))
      # 友達リストの中に@userが表示されていることを確認する
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content('友達リスト: 1人')
      # @userの詳細ページへ移動する
      visit user_path(@user.id)
      # @userの詳細ページへ遷移することを確認
      expect(current_path).to eq(user_path(@user.id))
      # 既に友達のユーザーの詳細ページ上には、友達申請アイコンがなく、代わりに友達アイコンが表示されている
      expect(page).to have_no_content('友達ではありません')
      expect(page).to have_content('既に友達です')
    end
    it '既に友達申請送信済みのユーザーには友達申請を送信できない' do
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
      # 詳細画面へ遷移したことを確認する
      expect(current_path).to eq(user_path(@user2.id))
      # 友達申請ボタンを押すと友達モデルのカウントが1上がる
      expect{
        find(".friend_request_img").click
        visit user_path(@user2.id)
      }.to change { FriendRequest.count }.by(1)
      # 友達申請を一度押したあとは、もう一度友達申請を送信することができない
      expect(page).to have_content('友達申請キャンセル')
    end
    it '友達申請を受信しているユーザーには友達申請を送信できない' do
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
      # 詳細画面へ遷移したことを確認する
      expect(current_path).to eq(user_path(@user2.id))
      # 友達申請ボタンを押すと友達モデルのカウントが1上がる
      expect{
        find(".friend_request_img").click
        visit user_path(@user2.id)
      }.to change { FriendRequest.count }.by(1)
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
      # @userの詳細画面には友達申請アイコンが表示されていないことを確認する
      expect(page).to have_content('友達申請受信済み')
    end
  end
end