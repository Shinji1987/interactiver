require 'rails_helper'

RSpec.describe Comment, :type => :model do
  describe '#create' do
    before do
      @comment = FactoryBot.build(:comment)
    end

    describe 'コメントの投稿' do
      context 'コメントの投稿ができる場合' do
        it '必要な情報を適切に入力すると,コメントの投稿ができること' do
          expect(@comment).to be_valid
        end
      end

      context 'コメントの投稿ができない場合' do
        it 'コメント欄に入力しないと投稿できない' do
          @comment.comment = ""
          @comment.valid?
          expect(@comment.errors.full_messages).to include("コメントを入力してください")
        end
      end
    end
  end
end
