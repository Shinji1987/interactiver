require 'rails_helper'

RSpec.describe Read, type: :model do
  describe '#create' do
    before do
      @read = FactoryBot.build(:read)
    end

    describe '既読の有無' do
      context '既読がつく場合' do
        it 'メッセージを送信すると,既読がつくこと' do
          expect(@read).to be_valid
        end
      end

      context '既読がつかない場合' do
        it '同じメッセージには既読がつかない' do
          @read = FactoryBot.create(:read)
          another_read = FactoryBot.build(:read)
          another_read.message_id = @read.message_id
          another_read.valid?
          expect(another_read.errors.full_messages).to include('Messageはすでに存在します')
        end
      end
    end
  end
end