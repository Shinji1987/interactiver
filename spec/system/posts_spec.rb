require 'rails_helper'

RSpec.describe '投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post_text = Faker::Lorem.sentence
  end
  context '投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      sign_in(@user)
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('思ったことを書きましょう！(投稿はココをクリック)')
      # 投稿ページに移動する
      visit new_post_path
      # フォームに情報を入力する
      attach_file "post-image", "#{Rails.root}/spec/fixtures/Yokosuka.jpg", make_visible: true
      fill_in 'post_text', with: @post_text
      # 送信するとPostモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Post.count }.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq(root_path)
      # トップページには先ほど投稿した内容が存在することを確認する（画像）
      expect(page).to have_selector("img[src$='Yokosuka.jpg']")
      # トップページには先ほど投稿した内容が存在することを確認する（テキスト）
      expect(page).to have_content(@post_text)
    end
  end
  context '投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 投稿画面のURLをダイレクトに入力
      visit '/posts/new'
      # ログイン画面へリダイレクトされる
      expect(current_path).to eq(new_user_session_path)
    end
    it '空の情報を入力すると投稿できない' do
      # ログインする
      sign_in(@user)
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('思ったことを書きましょう！(投稿はココをクリック)')
      # 投稿ページに移動する
      visit new_post_path
      # フォームに空の情報を入力する
      fill_in 'post_text', with: ''
      # 送信するとPostモデルのカウントが変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Post.count }.by(0)
      # 投稿ページに戻ることを確認する
      expect(current_path).to eq('/posts')
    end
  end
end