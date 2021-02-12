require 'rails_helper'

RSpec.describe Security, type: :model do
  describe '#create' do
    before do
      @security = FactoryBot.build(:security)
    end

    describe 'ブロックの適用' do
      context 'ブロックができる場合' do
        it 'ブロックボタンを押すと,ブロックが適用されること' do
          expect(@security).to be_valid
        end
      end

      context 'ブロックができない場合' do
        it 'ブロック元のユーザーIDがないと、ブロックできない' do
          @security.block_user_id = nil
          @security.valid?
          expect(@security.errors.full_messages).to include('Block userを入力してください')
        end
        it 'ブロック先のユーザーIDがないと、ブロックできない' do
          @security.blocked_user_id = nil
          @security.valid?
          expect(@security.errors.full_messages).to include('Blocked userを入力してください')
        end
      end
    end
  end
end
