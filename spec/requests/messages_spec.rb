require 'rails_helper'

RSpec.describe "Messages", :type => :request do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    @chat = FactoryBot.create(:chat)
    @message = FactoryBot.create(:message)
  end

  describe "GET#new" do
    context "正常にチャット画面へ移動できる場合" do
      it 'newアクションにリクエストすると正常にレスポンスが返ってくる' do 
        get new_chat_message_path(@chat.id, @user.id)
        expect(response.status).to eq 200
      end
      it '投稿画面へ移動すると「投稿・画像添付ボタン」の表示が返ってくる' do 
        get new_chat_message_path(@chat.id, @user.id)
        expect(response.body).to include('送信', '画像添付')
      end
    end
    context "チャット画面へ移動できない場合" do
      it 'ログアウト状態でnewアクションにリクエストするとログイン画面にリダイレクトされる' do 
        sign_out @user
        get new_chat_message_path(@chat.id)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "POST#create" do
    context "正常にメッセージを送信できる場合" do
      it 'createアクションへのリクエストが成功すること' do 
        @chat_user = FactoryBot.create(:chat_user)
        @chat_user.chat_id = @chat.id
        @chat_user.save
        @another_user = FactoryBot.create(:user) 
        @another_user.id = 2
        @another_user.save
        @user.id = 1
        @user.save
        message_create_params = {:content => @message.content, :sent_user_id => @user.id, :received_user_id => @another_user.id}
        post chat_messages_path(@chat.id, @user.id), :params => {:id => @message.id, :message => message_create_params}
        expect(response.status).to eq 302
      end
      it '正常にメッセージを送信できるか?' do
        expect do
          @chat_user = FactoryBot.create(:chat_user)
          @chat_user.chat_id = @chat.id
          @chat_user.save
          @another_user = FactoryBot.create(:user) 
          @another_user.id = 2
          @another_user.save
          @user.id = 1
          @user.save
          @message.id = 1
          @message.content = "Hello"
          @message.save
          message_create_params = {:content => 'テスト', :sent_user_id => @user.id, :received_user_id => @another_user.id}
          post chat_messages_path(@chat.id, @user.id, @message.content), :params => {:id => @message.id, :message => message_create_params}    
        end.to change(Message, :count).by 1
      end
      it '正常にメッセージを送信した後、チャット画面へリダイレクトされるか?' do 
        @chat_user = FactoryBot.create(:chat_user)
        @chat_user.chat_id = @chat.id
        @chat_user.save
        @another_user = FactoryBot.create(:user) 
        @another_user.id = 2
        @another_user.save
        @user.id = 1
        @user.save
        @message.id = 1
        @message.content = "Hello"
        @message.save
        message_create_params = {:content => 'テスト', :sent_user_id => @user.id, :received_user_id => @another_user.id}
        post chat_messages_path(@chat.id, @user.id, @message.content), :params => {:id => @message.id, :message => message_create_params}
        expect(response).to redirect_to new_chat_message_path(@chat.id)
      end
    end
    context "メッセージを送信できない場合" do
      it '不正な値が含まれている場合、メッセージを送信できないか?' do
        @message.delete
        expect do
          @chat_user = FactoryBot.create(:chat_user)
          @chat_user.chat_id = @chat.id
          @chat_user.save
          @another_user = FactoryBot.create(:user) 
          @another_user.id = 2
          @another_user.save
          @user.id = 1
          @user.save
          post chat_messages_path(@chat.id, @user.id)
        end.to_not change(Message, :count)
      end
      it '不正な値が含まれている場合、投稿画面へ戻るか?' do
        @message.delete
        @chat_user = FactoryBot.create(:chat_user)
        @chat_user.chat_id = @chat.id
        @chat_user.save
        @another_user = FactoryBot.create(:user) 
        @another_user.id = 2
        @another_user.save
        @user.id = 1
        @user.save
        post chat_messages_path(@chat.id, @user.id)
        expect(response).to redirect_to new_chat_message_path(@chat.id)        
      end
    end
  end

  after do
    sign_out @user
  end
end