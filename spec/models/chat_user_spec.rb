require 'rails_helper'

RSpec.describe ChatUser, type: :model do
  describe '#create' do
    before do
      @chat_user = FactoryBot.build(:chat_user)
    end

    describe 'チャットの作成' do
      context 'チャットの作成ができる場合' do
        it 'チャットアイコンをクリックすると,チャットの作成ができること' do
          expect(@chat_user).to be_valid
        end
      end

      context 'チャットの作成ができない場合' do
        it '既に存在する作成者と招待者が同じペアのチャットは作成できない' do
          @chat_user = FactoryBot.create(:chat_user)
          another_chat_user = FactoryBot.build(:chat_user)
          another_chat_user.created_user_id = @chat_user.created_user_id
          another_chat_user.invited_user_id = @chat_user.invited_user_id
          another_chat_user.valid?
          expect(another_chat_user.errors.full_messages).to include('Created userはすでに存在します')
        end
        it '既に存在するペアは作成者と招待者が逆でもチャットを作成できない' do
          @chat_user = FactoryBot.create(:chat_user)
          @chat_user.created_user_id = 2
          @chat_user.invited_user_id = 1
          another_chat_user = FactoryBot.build(:chat_user)
          another_chat_user.created_user_id = @chat_user.invited_user_id
          another_chat_user.invited_user_id = @chat_user.created_user_id
          another_chat_user.valid?
          expect(another_chat_user.errors.full_messages).to include('Created userはすでに存在します')
        end
      end
    end
  end
end