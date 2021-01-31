class ChatsController < ApplicationController
  def new
    @friend_lists = FriendRequest.where("from_user_id = ? or to_user_id = ?", current_user.id, current_user.id).where(requesting_status: 2).pluck(:from_user_id, :to_user_id)
  end

  def create
    @chat = Chat.new
    if @chat.save
      @message = Message.new
      redirect_to new_chat_message_path(@chat.id)
    else
      render("users/show")
    end
  end
end