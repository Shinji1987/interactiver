class MessagesController < ApplicationController
  def new
    @chat = Chat.find(params[:chat_id])
    if request.referer&.include?("/messages/new")
      @user_record_double = ChatUser.where(chat_id: @chat.id).pluck(:created_user_id, :invited_user_id)
      @user_record = @user_record_double.slice(0)
      @user_arr = @user_record.select do |x|
        x != current_user.id
      end
      @user = User.find_by(id: @user_arr)
    else
      @user = User.find_by(id: params[:format])
    end
    @messages = Message.where(chat_id: @chat.id)   
  end

  def create
    @chat = Chat.find(params[:chat_id])
    @user_record_double = ChatUser.where(chat_id: @chat.id).pluck(:created_user_id, :invited_user_id)
    @user_record = @user_record_double.slice(0)
    @user_arr = @user_record.select do |x|
      x != current_user.id
    end
    @user = User.find_by(id: @user_arr)
    
    @message = @chat.messages.new(message_params)
    # binding.pry
    if @message.save
      redirect_to new_chat_message_path(@chat.id)
    else
      @messages = @chat.messages.includes(:user)
      render :new
    end
  end

  private

  def message_params
    params.permit(:content).merge(sent_user_id: current_user.id, received_user_id: @user.id)
  end
end