require 'rails_helper'

RSpec.describe Like, type: :model do
  describe '#create' do
    before do
      @like = FactoryBot.build(:like)
    end

    describe 'いいねの挿入' do
      context 'いいねの挿入ができる場合' do
        it 'いいねを押すと,コメントの投稿ができること' do
          expect(@like).to be_valid
        end
      end

      context 'いいねの挿入ができない場合' do
        it '同じユーザーが一度いいねを挿入するといいねできない' do
          @like.save
          another_like = FactoryBot.build(:like)
          another_like.user_id = @like.user_id
          another_like.post_id = @like.post_id
          another_like.valid?
          expect(another_like.errors.full_messages).to include('Postはすでに存在します')
        end
      end
    end
  end
end