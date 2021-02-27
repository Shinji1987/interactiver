require 'rails_helper'

RSpec.describe 'いいね', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post)
  end
  context '「いいね」ができるとき'do
    it 'ログインしたユーザーは「いいね」できる' do
      # ログインする
      sign_in(@user)
      # 投稿ページに移動する
      visit new_post_path
      # フォームに情報を入力する
      attach_file "post-image", "#{Rails.root}/spec/fixtures/Yokosuka.jpg", make_visible: true
      fill_in 'post_text', with: @post.text
      # 送信するとPostモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Post.count }.by(1)
      # 投稿があることを確認する
      expect(page).to have_selector("img[src$='Yokosuka.jpg']")
      expect(page).to have_content(@post.text)
      # その投稿の「いいね」ボタンをクリックするとLikeモデルのカウントが1上がることを確認する
      expect{
        find(".like_img").click
        visit root_path
      }.to change { Like.count }.by(1)
    end
  end
  context '「いいね」ができないとき'do
    it 'ログインしていないとコメントページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 投稿画面のURLをダイレクトに入力
      visit "/posts/#{@post.id}/comments/new"
      # ログイン画面へリダイレクトされる
      expect(current_path).to eq(new_user_session_path)
    end
  end
  context '「いいね」解除ができるとき'do
    it '「いいね」は解除できる' do
      # ログインする
      sign_in(@user)
      # 投稿ページに移動する
      visit new_post_path
      # フォームに情報を入力する
      attach_file "post-image", "#{Rails.root}/spec/fixtures/Yokosuka.jpg", make_visible: true
      fill_in 'post_text', with: @post.text
      # 送信するとPostモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Post.count }.by(1)
      # 投稿があることを確認する
      expect(page).to have_selector("img[src$='Yokosuka.jpg']")
      expect(page).to have_content(@post.text)
      # その投稿の「いいね」ボタンをクリックするとLikeモデルのカウントが1上がることを確認する
      expect{
        find(".like_img").click
        visit root_path
      }.to change { Like.count }.by(1)
      # もう一度「いいね」ボタンを押すと、「いいね」を解除できてlikeモデルのカウントが1下がることを確認する
      expect{
        find(".liked_img").click
        visit root_path
      }.to change { Like.count }.by(-1)
    end
  end
end