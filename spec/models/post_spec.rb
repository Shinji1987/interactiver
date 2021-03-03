require 'rails_helper'

RSpec.describe Post, :type => :model do
  describe '#create' do
    before do
      @post = FactoryBot.build(:post)
      @post.post_image = fixture_file_upload('app/assets/images/Yokosuka.jpg')
    end

    describe 'テキスト・画像の投稿' do
      context 'テキスト・画像の投稿ができる場合' do
        it '必要な情報を適切に入力すると,テキスト・画像の投稿ができること' do
          expect(@post).to be_valid
        end
        it '画像がなくても,投稿ができること' do
          @post.post_image = nil
          expect(@post).to be_valid
        end
      end

      context '商品の出品ができない場合' do
        it 'テキストを入力しないと投稿できない' do
          @post.text = ""
          @post.valid?
          expect(@post.errors.full_messages).to include("テキストを入力してください")
        end
      end
    end
  end
end
