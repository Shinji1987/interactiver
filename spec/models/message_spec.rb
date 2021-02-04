require 'rails_helper'

RSpec.describe Message, type: :model do
  describe '#create' do
    before do
      @message = FactoryBot.build(:message)
      @message.message_image = fixture_file_upload('app/assets/images/Yokosuka.jpg')
    end

    describe 'メッセージの投稿' do
      context 'メッセージの投稿ができる場合' do
        it '必要な情報を入力して送信ボタンを押すと,メッセージの投稿ができること' do
          expect(@message).to be_valid
        end
        it '画像を添付した場合は、メッセージ内容がなくても投稿できる' do
          @message.content = ""
          expect(@message).to be_valid
        end
      end

      context 'メッセージの投稿ができない場合' do
        it 'メッセージ内容が無いと、メッセージの投稿ができない' do
          @message.content = ""
          @message.message_image = nil
          @message.valid?
          expect(@message.errors.full_messages).to include('Contentを入力してください')
        end
      end
    end
  end
end
