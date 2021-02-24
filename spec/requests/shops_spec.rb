require 'rails_helper'

RSpec.describe "Shops", type: :request do
  let(:rspec_session) { { current_user: 2 } }

  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    @shop = FactoryBot.create(:shop)
  end

  describe "GET#edit" do
    context "正常に店舗情報編集画面へ移動できる場合" do
      it 'editアクションにリクエストすると正常にレスポンスが返ってくる' do 
        get edit_shop_path(@user)
        expect(response.status).to eq 200
      end
      it 'ユーザー編集画面へ移動すると店舗情報のカラムが返ってくる' do 
        get edit_shop_path(@user)
        expect(response.body).to include('店舗写真', '店舗名', 'カテゴリー', '店舗説明', '店舗住所')
      end
    end
    context "正常に店舗情報編集画面へ移動できない場合" do
      it '別ユーザーのeditアクションにリクエストするとトップページにリダイレクトされる' do 
        sign_out @user
        @another_user = FactoryBot.create(:user)
        sign_in @another_user
        get edit_shop_path(@user)
        expect(response).to redirect_to root_path
      end
      it 'ログアウト状態でeditアクションにリクエストするとログイン画面にリダイレクトされる' do 
        sign_out @user
        get edit_shop_path(@user)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "PATCH#update" do
    context "正常に店舗情報を更新できる場合" do
      it '正常に店舗情報を更新できるか?' do 
        shopping_update_params = {shop_name: "居酒屋 楽", shop_category_id: 5, shop_description: "海鮮居酒屋です", shop_address: "神奈川県横浜市"}
        patch shop_path(@user.id, @shop), params: {id: @shop.id, shop: shopping_update_params}        
        expect(@shop.reload.shop_name).to eq "居酒屋 楽"
        expect(@shop.shop_category_id).to eq 5
        expect(@shop.shop_description).to eq "海鮮居酒屋です"
        expect(@shop.shop_address).to eq "神奈川県横浜市"
      end
      it '正常に店舗情報を更新した後、更新されたユーザー詳細ページへリダイレクトされるか?' do 
        shopping_update_params = {shop_name: "居酒屋 楽", shop_category_id: 5, shop_description: "海鮮居酒屋です", shop_address: "神奈川県横浜市"}
        patch shop_path(@user.id, @shop), params: {id: @shop.id, shop: shopping_update_params}
        expect(response).to redirect_to user_path(@user)
      end
    end
  end  

  after do
    sign_out @user
  end
end
