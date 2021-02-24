require 'rails_helper'

RSpec.describe "Securitys", type: :request do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    @security = FactoryBot.create(:security)
  end

  describe "GET#new" do
    context "正常にブロックリスト画面へ移動できる場合" do
      it 'newアクションにリクエストすると正常にレスポンスが返ってくる' do 
        get new_security_path
        expect(response.status).to eq 200
      end
      it 'ブロック機能の画面へ移動すると「＜ブロックリスト＞」が返ってくる' do 
        get new_security_path
        expect(response.body).to include('＜ブロックリスト＞')
      end
    end
    context "ブロックリスト画面へ移動できない場合" do
      it 'ログアウト状態でnewアクションにリクエストするとログイン画面にリダイレクトされる' do 
        sign_out @user
        get new_security_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "POST#create" do
    context "正常にブロックできる場合" do
      it '正常にブロックできるか?' do
        expect do
          @another_user = FactoryBot.create(:user) 
          block_create_params = {block_user_id: @user.id, blocked_user_id: @another_user}
          post securitys_path(@another_user.id), params: {id: @security.id, shop: block_create_params}        
        end.to change(Security, :count).by 1
      end
      it 'リクエストが成功すること' do 
        @another_user = FactoryBot.create(:user) 
        block_create_params = {block_user_id: @user.id, blocked_user_id: @another_user}
        post securitys_path(@another_user.id), params: {id: @security.id, shop: block_create_params} 
        expect(response.status).to eq 302
      end
      it '正常にブロックした後、ブロック機能ページへリダイレクトされるか?' do 
        @another_user = FactoryBot.create(:user) 
        block_create_params = {block_user_id: @user.id, blocked_user_id: @another_user}
        post securitys_path(@another_user.id), params: {id: @security.id, shop: block_create_params} 
        expect(response).to redirect_to new_security_path
      end
    end
  end

  describe "DELETE#destroy" do
    context "正常にブロックを解除できる場合" do
      it '正常にブロックを解除できるか?' do
        expect do
          @another_user = FactoryBot.create(:user)
          @another_user.id = 2 
          @another_user.save
          @user.id = 1
          @user.save
          block_create_params = {block_user_id: @user.id, blocked_user_id: @another_user.id}
          delete security_path(@another_user.id), params: {id: @security.id, shop: block_create_params}        
        end.to change(Security, :count).by -1
      end
      it 'リクエストが成功すること' do 
        @another_user = FactoryBot.create(:user)
        @another_user.id = 2 
        @another_user.save
        @user.id = 1
        @user.save
        block_create_params = {block_user_id: @user.id, blocked_user_id: @another_user.id}
        delete security_path(@another_user.id), params: {id: @security.id, shop: block_create_params}  
        expect(response.status).to eq 302
      end
      it '正常にブロックした後、ブロック機能ページへリダイレクトされるか?' do 
        @another_user = FactoryBot.create(:user)
        @another_user.id = 2 
        @another_user.save
        @user.id = 1
        @user.save
        block_create_params = {block_user_id: @user.id, blocked_user_id: @another_user.id}
        delete security_path(@another_user.id), params: {id: @security.id, shop: block_create_params}   
        expect(response).to redirect_to new_security_path
      end
    end
  end

  after do
    sign_out @user
  end
end