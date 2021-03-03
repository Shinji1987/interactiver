require 'rails_helper'

RSpec.describe "Chats", :type => :request do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    @another_user = FactoryBot.create(:user)
    @chat = FactoryBot.create(:chat)
    @chat_user = FactoryBot.create(:chat_user)
  end

  describe "GET#new" do
    context "正常にメッセンジャー画面へ移動できる場合" do
      it 'newアクションにリクエストすると正常にレスポンスが返ってくる' do 
        get new_chat_path
        expect(response.status).to eq 200
      end
      it 'ブロック機能の画面へ移動すると「＜ブロックリスト＞」が返ってくる' do 
        get new_chat_path
        expect(response.body).to include('メッセンジャー', '友達リスト:', 'チャット履歴')
      end
    end
    context "ブロックリスト画面へ移動できない場合" do
      it 'ログアウト状態でnewアクションにリクエストするとログイン画面にリダイレクトされる' do 
        sign_out @user
        get new_chat_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "POST#create" do
    context "正常にチャットが作成できる場合" do
      it '正常にチャットが作成できるか?' do
        expect do
          chat_user_create_params = {:created_user_id => @user.id, :invited_user_id => @another_user.id}
          post chats_path(@another_user.id), :params => {:id => @chat_user.id, :chat_user => chat_user_create_params}       
        end.to change(Chat, :count).by 1
      end
      it 'チャット作成のリクエストが成功すること' do 
        chat_user_create_params = {:created_user_id => @user.id, :invited_user_id => @another_user.id}
        post chats_path(@another_user.id), :params => {:id => @chat_user.id, :chat_user => chat_user_create_params} 
        expect(response.status).to eq 302
      end
      it '正常にブロックした後、ブロック機能ページへリダイレクトされるか?' do 
        chat_user_create_params = {:created_user_id => @user.id, :invited_user_id => @another_user.id}
        post chats_path(@another_user.id), :params => {:id => @chat_user.id, :chat_user => chat_user_create_params}
        expect(response).to redirect_to new_chat_message_path(@chat_user.chat_id + 1, @another_user.id)
      end
    end
  end
end
