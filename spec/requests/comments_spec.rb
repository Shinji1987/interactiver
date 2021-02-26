require 'rails_helper'

RSpec.describe "Comments", type: :request do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    @post = FactoryBot.create(:post)
    @comment = FactoryBot.create(:comment)
  end

  describe "GET#new" do
    context "正常にコメント画面へ移動できる場合" do
      it 'newアクションにリクエストすると正常にレスポンスが返ってくる' do 
        get new_post_comment_path(@post.id)
        expect(response.status).to eq 200
      end
      it '投稿画面へ移動すると「投稿・画像添付ボタン」の表示が返ってくる' do 
        get new_post_comment_path(@post.id)
        expect(response.body).to include('コメント', '＜コメント一覧＞')
      end
    end
    context "投稿画面へ移動できない場合" do
      it 'ログアウト状態でnewアクションにリクエストするとログイン画面にリダイレクトされる' do 
        sign_out @user
        get new_post_comment_path(@post.id)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "POST#create" do
    context "正常にコメントできる場合" do
      it '正常にコメントできるか?' do
        expect do
          @comment.user_id = @user.id
          @comment.post_id = @post.id
          @comment.save
          comment_create_params = {comment: @comment.comment}
          post post_comments_path(@post.id), params: {id: @comment.id, comment: comment_create_params}        
        end.to change(Comment, :count).by 1
      end
      it 'createアクションへのリクエストが成功すること' do 
        @comment.user_id = @user.id
        @comment.post_id = @post.id
        @comment.save
        comment_create_params = {comment: @comment.comment}
        post post_comments_path(@post.id), params: {id: @comment.id, comment: comment_create_params}
        expect(response.status).to eq 302
      end
      it '正常に投稿した後、トップページへリダイレクトされるか?' do 
        @comment.user_id = @user.id
        @comment.post_id = @post.id
        @comment.save
        comment_create_params = {comment: @comment.comment}
        post post_comments_path(@post.id), params: {id: @comment.id, comment: comment_create_params}
        expect(response).to redirect_to new_post_comment_path
      end
    end
    context "コメントできない場合" do
      it '不正な値が含まれている場合、投稿できないか?' do
        expect do
          @comment.user_id = @user.id
          @comment.post_id = @post.id
          @comment.save
          comment_create_params = {comment: ""}
          post post_comments_path(@post.id), params: {id: @comment.id, comment: comment_create_params}        
        end.to_not change(Comment, :count)
      end
      it '不正な値が含まれている場合、投稿画面へ戻るか?' do
        @comment.user_id = @user.id
        @comment.post_id = @post.id
        @comment.save
        comment_create_params = {comment: ""}
        post post_comments_path(@post.id), params: {id: @comment.id, comment: comment_create_params}
        expect(response).to redirect_to new_post_comment_path        
      end
    end
  end
end
