require 'rails_helper'

RSpec.describe "Footprints", :type => :request do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    @another_user = FactoryBot.create(:user)
  end

  describe "GET#index" do
    context "正常に足跡一覧画面へ移動できる場合" do
      it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do 
        get footprints_path(@user.id)
        expect(response.status).to eq 200
      end
      it 'indexアクションにリクエストするとレスポンスに各セクションのタイトルが存在する' do 
        get footprints_path(@user.id)
        expect(response.body).to include('最近の足跡', '詳細ページアクセス数', '＜過去20アクセス分の足跡を表示＞')
      end
    end
    context "足跡一覧画面へ移動できない場合" do
      it 'ログアウト状態でindexアクションにリクエストするとログイン画面にリダイレクトされる' do 
        sign_out @user
        get footprints_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  after do
    sign_out @user
  end
end
