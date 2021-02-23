require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:rspec_session) { { current_user: 2 } }

  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    @user.image = fixture_file_upload('spec/fixtures/Yokosuka.jpg')
  end

  describe "GET#show" do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get user_path(@user)
      expect(response.status).to eq 200
    end
    it 'showアクションにリクエストするとレスポンスにユーザー情報が存在する' do 
      get user_path(@user)
      expect(response.body).to include(@user.nickname, @user.email, @user.family_name_kanji, @user.first_name_kanji, @user.family_name_kana, @user.first_name_kana, @user.birthday.to_s, @user.profile)
    end
  end

  after do
    sign_out @user
  end
end