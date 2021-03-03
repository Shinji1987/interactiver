require 'rails_helper'

RSpec.describe "Likes", :type => :request do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    @post = FactoryBot.create(:post)
    @like = FactoryBot.create(:like)
  end

  describe "POST#create" do
    context "正常に「いいね」できる場合" do
      it '正常に「いいね」できるか?' do
        expect do
          like_create_params = {}
          post post_likes_path(@post.id), :xhr => true, :params => {:id => @like.id, :like => like_create_params}        
        end.to change(Like, :count).by 1
      end
      it 'createアクションへのリクエストが成功すること' do 
        like_create_params = {}
        post post_likes_path(@post.id), :xhr => true, :params => {:id => @like.id, :like => like_create_params}
        expect(response.status).to eq 200
      end
    end
  end
end