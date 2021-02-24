require 'rails_helper'

RSpec.describe "Posts", type: :request do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    @post = FactoryBot.create(:post)
  end
  
  describe "GET#index" do
    context "正常にトップ画面へ移動できる場合" do
      it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do 
        get root_path
        expect(response.status).to eq 200
      end
      it 'indexアクションにリクエストするとレスポンスに各セクションのタイトルが存在する' do 
        get root_path
        expect(response.body).to include('為替情報', '知り合いかも', '思ったことを書きましょう！(投稿はココをクリック)', 'ビジネスニュース')
      end
    end
  end

  describe "GET#new" do
    context "正常に投稿画面へ移動できる場合" do
      it 'newアクションにリクエストすると正常にレスポンスが返ってくる' do 
        get new_post_path
        expect(response.status).to eq 200
      end
      it '投稿画面へ移動すると「投稿・画像添付ボタン」の表示が返ってくる' do 
        get new_post_path
        expect(response.body).to include('投稿する', '画像添付')
      end
    end
    context "投稿画面へ移動できない場合" do
      it 'ログアウト状態でnewアクションにリクエストするとログイン画面にリダイレクトされる' do 
        sign_out @user
        get new_post_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "POST#create" do
    context "正常に投稿できる場合" do
      it '正常に投稿できるか?' do
        expect do
          post_create_params = {text: @post.text}
          post posts_path(@user.id, @post), params: {id: @post.id, post: post_create_params}        
        end.to change(Post, :count).by 1
      end
      it 'リクエストが成功すること' do 
        post_create_params = {text: @post.text}
        post posts_path(@user.id, @post), params: {id: @post.id, post: post_create_params}
        expect(response.status).to eq 302
      end
      it '正常に投稿した後、トップページへリダイレクトされるか?' do 
        post_create_params = {text: @post.text}
        post posts_path(@user.id, @post), params: {id: @post.id, post: post_create_params}
        expect(response).to redirect_to root_path
      end
    end
    context "投稿できない場合" do
      it '不正な値が含まれている場合、投稿できないか?' do
        expect do
          post_create_params = {text: ""}
          post posts_path(@user.id, @post), params: {id: @post.id, post: post_create_params}        
        end.to_not change(Post, :count)
      end
      it '不正な値が含まれている場合、投稿画面へ戻るか?' do
        post_create_params = {text: ""}
        post posts_path(@user.id, @post), params: {id: @post.id, post: post_create_params}
        expect(response).to render_template :new        
      end
    end
  end

  after do
    sign_out @user
  end
end
