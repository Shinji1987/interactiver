require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:rspec_session) { { current_user: 2 } }

  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    @user.image = fixture_file_upload('spec/fixtures/Yokosuka.jpg')
  end

  describe "GET#show" do
    context "正常にユーザー詳細画面へ移動できる場合" do
      it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do 
        get user_path(@user)
        expect(response.status).to eq 200
      end
      it 'showアクションにリクエストするとレスポンスにユーザー情報が存在する' do 
        get user_path(@user)
        expect(response.body).to include(@user.nickname, @user.email, @user.family_name_kanji, @user.first_name_kanji, @user.family_name_kana, @user.first_name_kana, @user.birthday.to_s, @user.profile)
      end
    end
    context "正常にユーザー詳細画面へ移動できない場合" do
      it 'ログアウト状態でshowアクションにリクエストするとログイン画面にリダイレクトされる' do 
        sign_out @user
        get user_path(@user)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "GET#edit" do
    context "正常にユーザー編集画面へ移動できる場合" do  
      it 'editアクションにリクエストすると正常にレスポンスが返ってくる' do 
        get edit_user_path(@user)
        expect(response.status).to eq 200
      end
      it 'ユーザー編集画面へ移動するとユーザー情報のカラムが返ってくる' do 
        get edit_user_path(@user)
        expect(response.body).to include('プロフィール画像', 'ニックネーム', 'プロフィール', 'お名前(全角)', 'お名前カナ(全角)', '生年月日', 'お店の住所')
      end
    end
    context "正常にユーザー編集画面へ移動できない場合" do
      it '別ユーザーのeditアクションにリクエストするとトップページにリダイレクトされる' do 
        sign_out @user
        @another_user = FactoryBot.create(:user)
        sign_in @another_user
        get edit_user_path(@user)
        expect(response).to redirect_to root_path
      end
      it 'ログアウト状態でeditアクションにリクエストするとログイン画面にリダイレクトされる' do 
        sign_out @user
        get edit_user_path(@user)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "PATCH#update" do
    context "正常にユーザー情報を更新できる場合" do
      it '正常にユーザー情報を更新できるか?' do 
        user_update_params = {nickname: "ロバート", family_name_kanji: "山田", first_name_kanji: "太朗", family_name_kana: "ヤマダ", first_name_kana: "タロウ", birthday: "1980-01-01", profile: "楽しくいきましょう！"}
        patch user_path(@user), params: {id: @user.id, user: user_update_params}
        expect(@user.reload.nickname).to eq "ロバート"
        expect(@user.family_name_kanji).to eq "山田"
        expect(@user.first_name_kanji).to eq "太朗"
        expect(@user.family_name_kana).to eq "ヤマダ"
        expect(@user.first_name_kana).to eq "タロウ"
        expect(@user.birthday.to_s).to eq "1980-01-01"
        expect(@user.profile).to eq "楽しくいきましょう！"
      end
      it '正常にユーザー情報を更新した後、更新されたユーザー詳細ページへリダイレクトされるか?' do 
        user_update_params = {nickname: "ロバート", family_name_kanji: "山田", first_name_kanji: "太朗", family_name_kana: "ヤマダ", first_name_kana: "タロウ", birthday: "1980-01-01", profile: "楽しくいきましょう！"}
        patch user_path(@user), params: {id: @user.id, user: user_update_params}
        expect(response).to redirect_to user_path(@user)
      end
    end
    context "正常にユーザー情報を更新できない場合" do
      it '不正な値が入力された時は、更新できなくなっているか?' do 
        user_update_params = {nickname: "", family_name_kanji: "", first_name_kanji: "", family_name_kana: "", first_name_kana: "", birthday: ""}
        patch user_path(@user), params: {id: @user.id, user: user_update_params}
        expect(@user.reload.nickname).to eq "ジョン"
        expect(@user.family_name_kanji).to eq "滝本"
        expect(@user.first_name_kanji).to eq "圭一"
        expect(@user.family_name_kana).to eq "タキモト"
        expect(@user.first_name_kana).to eq "ケイイチ"
        expect(@user.birthday.to_s).to eq "1988-02-06"
      end
      it '不正な値が入力された時は、編集画面へ戻るか?' do 
        user_update_params = {nickname: "", family_name_kanji: "", first_name_kanji: "", family_name_kana: "", first_name_kana: "", birthday: ""}
        patch user_path(@user), params: {id: @user.id, user: user_update_params}
        expect(response).to render_template :edit
      end
    end
  end

  describe "GET#search" do
    context "正常にユーザー検索ができる場合" do
      it 'searchアクションにリクエストすると正常にレスポンスが返ってくる' do 
        get search_user_path(@user)
        expect(response.status).to eq 200
      end
    end
    context "正常にユーザー検索ができない場合" do
      it 'ログアウト状態でsearchアクションにリクエストするとログイン画面にリダイレクトされる' do 
        sign_out @user
        get search_user_path(@user)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  after do
    sign_out @user
  end
end