require 'rails_helper'

RSpec.describe Chat, type: :model do
  describe '#create' do
    before do
      @chat = FactoryBot.build(:chat)
    end

    describe 'チャットの作成' do
      context 'チャットが作成できる場合' do
        it 'チャットアイコンをクリックすると,チャットの作成ができること' do
          expect(@chat).to be_valid
        end
      end
    end
  end
end
