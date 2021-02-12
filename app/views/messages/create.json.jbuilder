json.array! @messages do |message|
  json.id message.id
  json.content message.content
  json.sent_user_id message.sent_user_id
  json.received_user_id message.received_user_id
  json.chat_id message.chat_id
  json.created_at message.created_at.strftime("%Y年%m月%d日 %H時%M分")
  json.updated_at message.updated_at
end