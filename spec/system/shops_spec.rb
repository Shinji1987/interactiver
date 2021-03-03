require 'rails_helper'

RSpec.describe "店舗編集", :type => :system do
  before do
    @user = FactoryBot.create(:user)
    @shop = FactoryBot.build(:shop)
  end

  context '店舗情報の編集ができるとき' do 
    it 'ログインしたら店舗情報を編集できる' do
      # ログインする
      sign_in(@user)
      # 詳細ページに移動する
      visit user_path(@user.id)
      # 店舗情報編集画面へ移動する
      find('input[name="shop_edit_btn"]').click
      # 最初は店舗情報フォームが空になっていることを確認する
      expect(
        find('#shopname').value
      ).to eq('')
      expect(
        find('#shop_shop_category_id').value
      ).to eq("1")
      expect(
        find('#shopdescription').value
      ).to eq('')
      expect(
        find('#shopaddress').value
      ).to eq('')
      # 店舗情報を編集する
      fill_in 'shopname', :with => @shop.shop_name
      select '居酒屋', :from => 'shop_shop_category_id'
      fill_in 'shopdescription', :with => @shop.shop_description
      fill_in 'shopaddress', :with => @shop.shop_address
      # 編集してもTweetモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Shop.count }.by(0)
      # 詳細画面に遷移したことを確認する
      expect(current_path).to eq(user_path(@user.id))
      # 詳細ページで更新したユーザー情報が表示されていることを確認
      expect(page).to have_content(@shop.shop_name)
      expect(page).to have_content('居酒屋')
      expect(page).to have_content(@shop.shop_description)
      expect(page).to have_content(@shop.shop_address)
      # 再び店舗情報編集画面へ移動する
      find('input[name="shop_edit_btn"]').click
      # 店舗情報フォームに既存の店舗情報が記入されていることを確認する
      expect(
        find('#shopname').value
      ).to eq(@shop.shop_name)
      expect(
        find('#shop_shop_category_id').value
      ).to eq("2")
      expect(
        find('#shopdescription').value
      ).to eq(@shop.shop_description)
      expect(
        find('#shopaddress').value
      ).to eq(@shop.shop_address)
    end
  end
  context '店舗情報の編集ができないとき' do
    it 'ログインしていないと店舗編集ページへ移動できない' do
      # トップ画面へ移動する
      visit root_path
      # ユーザー変種画面へ移動しようとする
      visit edit_shop_path(@user.id)
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end