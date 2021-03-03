require 'rails_helper'

RSpec.describe 'コメント', :type => :system do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post)
    @comment_comment = Faker::Lorem.sentence
  end
  context 'コメントができるとき'do
    it 'ログインしたユーザーは新規コメントできる' do
      # ログインする
      sign_in(@user)
      # 投稿ページに移動する
      visit new_post_path
      # フォームに情報を入力する
      attach_file "post-image", "#{Rails.root}/spec/fixtures/Yokosuka.jpg", :make_visible => true
      fill_in 'post_text', :with => @post.text
      # 送信するとPostモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Post.count }.by(1)
      # 投稿があることを確認する
      expect(page).to have_selector("img[src$='Yokosuka.jpg']")
      expect(page).to have_content(@post.text)
      # その投稿のコメントページに移動する
      visit new_post_comment_path(@post.id)
      # フォームに情報を入力する
      fill_in 'comment_comment', :with => @comment_comment
      # 送信するとCommentモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Comment.count }.by(1)
      # コメントページに遷移することを確認する
      expect(current_path).to eq(new_post_comment_path(@post.id))
      # コメントページには先ほどコメントした内容が存在することを確認する
      expect(page).to have_content(@comment_comment)
    end
  end
  context 'コメントができないとき'do
    it 'ログインしていないとコメントページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 投稿画面のURLをダイレクトに入力
      visit "/posts/#{@post.id}/comments/new"
      # ログイン画面へリダイレクトされる
      expect(current_path).to eq(new_user_session_path)
    end
    it '空の情報を入力するとコメントできない' do
      # ログインする
      sign_in(@user)
      # 投稿ページに移動する
      visit new_post_path
      # フォームに情報を入力する
      attach_file "post-image", "#{Rails.root}/spec/fixtures/Yokosuka.jpg", :make_visible => true
      fill_in 'post_text', :with => @post.text
      # 送信するとPostモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Post.count }.by(1)
      # 投稿があることを確認する
      expect(page).to have_selector("img[src$='Yokosuka.jpg']")
      expect(page).to have_content(@post.text)
      # その投稿のコメントページに移動する
      visit new_post_comment_path(@post.id)
      # コメントフォームに空の情報を入力する
      fill_in 'comment_comment', :with => ''
      # 送信するとCommentモデルのカウントが変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Comment.count }.by(0)
      # コメントページに戻ることを確認する
      expect(current_path).to eq(new_post_comment_path(@post.id))
    end
  end
end