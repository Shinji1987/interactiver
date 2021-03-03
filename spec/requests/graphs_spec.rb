require 'rails_helper'

RSpec.describe "Graphs", :type => :request do
  
  describe "GET#index" do
    context "正常にグラフ画面へ移動できる場合" do
      it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do 
        get graphs_path
        expect(response.status).to eq 302
      end
    end
  end
end