class MessagesController < ApplicationController
  before_action :find_chat, only: [:new, :create]
  before_action :authenticate_user!

  def new
    if request.referer&.include?("/messages")
      @user_record_double = ChatUser.where(chat_id: @chat.id).pluck(:created_user_id, :invited_user_id)
      @user_record = @user_record_double.slice(0)
      @user_arr = @user_record.select do |x|
        x != current_user.id
      end
      @user = User.find_by(id: @user_arr)
    elsif request.referer&.include?("/users")
      @user = User.find_by(id: params[:format])
    elsif request.referer&.include?("/chats")
      chat_user = ChatUser.where(chat_id: @chat.id).pluck(:created_user_id, :invited_user_id).slice(0)
      chat_user_record = chat_user.select do |x|
        x != current_user.id
      end
      @user = User.find_by(id: chat_user_record)
    end
    @messages = Message.where(chat_id: @chat.id)
    @message = Message.new
  end

  def create
    @user_record_double = ChatUser.where(chat_id: @chat.id).pluck(:created_user_id, :invited_user_id)
    @user_record = @user_record_double.slice(0)
    @user_arr = @user_record.select do |x|
      x != current_user.id
    end
    @user = User.find_by(id: @user_arr)
    
    @message = @chat.messages.new(message_params)
    if @message.save
      respond_to do |format|
        format.html{redirect_to new_chat_message_path(@chat.id)}
        format.json
      end
    else
      flash[:notice] = "メッセージを入力、又は画像を添付してください"
      @messages = @chat.messages.includes(:user)
      redirect_to new_chat_message_path(@chat.id)
    end
  end

  private

  def message_params
    params.permit(:content, :message_image).merge(sent_user_id: current_user.id, received_user_id: @user.id)
  end

  def find_chat
    @chat = Chat.find(params[:chat_id])
  end
end