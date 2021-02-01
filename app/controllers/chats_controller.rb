class ChatsController < ApplicationController
  def new
    @friend_lists = FriendRequest.where("from_user_id = ? or to_user_id = ?", current_user.id, current_user.id).where(requesting_status: 2).pluck(:from_user_id, :to_user_id)
  end

  def create
    @user = User.find_by(id: params[:format])
    unless ChatUser.where("created_user_id = ? or invited_user_id = ?", @user.id, @user.id).where("created_user_id = ? or invited_user_id = ?", current_user.id, current_user.id) != []
      @chat = Chat.new
      if @chat.save
        @chat_user = ChatUser.new(chat_user_params)
        @chat_user.save
        @message = Message.new
        redirect_to new_chat_message_path(@chat.id, @user.id)
      else
        render("users/show")
      end
    else
      @chat_reuse_id = ChatUser.where("created_user_id = ? or invited_user_id = ?", @user.id, @user.id).where("created_user_id = ? or invited_user_id = ?", current_user.id, current_user.id).pluck(:chat_id)
      redirect_to new_chat_message_path(@chat_reuse_id, @user.id)
    end
  end

  private

  def chat_user_params
    params.permit().merge(created_user_id: current_user.id, invited_user_id: @user.id, chat_id: @chat.id)
  end
end