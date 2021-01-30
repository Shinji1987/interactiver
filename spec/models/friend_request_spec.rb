require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  describe '#create' do
    before do
      @friend_request = FactoryBot.build(:friend_request)
    end

    describe '友達申請の申請と承認' do
      context '友達申請の申請と承認ができる場合' do
        it '友達申請を実行すると,申請が相手のユーザーへ送られること' do
          expect(@friend_request).to be_valid
        end
        it '申請が送られた相手のユーザーが承認すると二人は友達関係に移行すること' do
          @friend_request.requesting_status = 2
          expect(@friend_request).to be_valid
        end
      end

      context '友達申請が送れない場合' do
        it '同じユーザーが同じユーザーに対して友達申請を送ったら、二度目以降は送信できない' do
          @friend_request.save
          another_request = FactoryBot.build(:friend_request)
          another_request.from_user_id = @friend_request.from_user_id
          another_request.to_user_id = @friend_request.to_user_id
          another_request.valid?
          expect(another_request.errors.full_messages).to include('From userはすでに存在します')
        end
      end
    end
  end
end
