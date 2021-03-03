require 'rails_helper'

RSpec.describe "FriendRequests", :type => :request do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    @another_user = FactoryBot.create(:user)
    @friend_request = FactoryBot.create(:friend_request)
  end

  describe "GET#index" do
    context "正常に友達リスト一覧画面へ移動できる場合" do
      it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do 
        get user_friend_requests_path(@user.id)
        expect(response.status).to eq 200
      end
      it 'indexアクションにリクエストするとレスポンスに各セクションのタイトルが存在する' do 
        get user_friend_requests_path(@user.id)
        expect(response.body).to include('友達リスト一覧', '友達リスト')
      end
    end
    context "友達リスト一覧画面へ移動できない場合" do
      it 'ログアウト状態でindexアクションにリクエストするとログイン画面にリダイレクトされる' do 
        sign_out @user
        get user_friend_requests_path(@user.id)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "POST#create" do
    context "正常に投稿できる場合" do
      it '正常に投稿できるか?' do
        expect do
          friend_create_params = {:from_user_id => @friend_request.from_user_id, :to_user_id => @friend_request.to_user_id, :requesting_status => @friend_request.requesting_status}
          post user_friend_requests_path(@another_user.id), :xhr => true, :params => {:id => @friend_request.id, :friend_request => friend_create_params}        
        end.to change(FriendRequest, :count).by 1
      end
      it 'createアクションへのリクエストが成功すること' do 
        friend_create_params = {:from_user_id => @friend_request.from_user_id, :to_user_id => @friend_request.to_user_id, :requesting_status => @friend_request.requesting_status}
        post user_friend_requests_path(@another_user.id), :xhr => true, :params => {:id => @friend_request.id, :friend_request => friend_create_params}
        expect(response.status).to eq 200
      end
    end
  end

  describe "DELETE#destroy" do
    context "正常に友達申請をキャンセルできる場合" do
      it '正常に友達申請を解除できるか?' do
        expect do
          @another_user.id = 2 
          @another_user.save
          @user.id = 1
          @user.save
          friend_create_params = {:from_user_id => @friend_request.from_user_id, :to_user_id => @friend_request.to_user_id, :requesting_status => @friend_request.requesting_status}
          delete user_friend_request_path(@another_user.id, @user.id), :xhr => true, :params => {:id => @friend_request.id, :friend_request => friend_create_params}        
        end.to change(FriendRequest, :count).by -1
      end
      it '友達申請キャンセルのリクエストが成功すること' do 
        @another_user.id = 2 
        @another_user.save
        @user.id = 1
        @user.save
        friend_create_params = {:from_user_id => @friend_request.from_user_id, :to_user_id => @friend_request.to_user_id, :requesting_status => @friend_request.requesting_status}
        delete user_friend_request_path(@another_user.id, @user.id), :xhr => true, :params => {:id => @friend_request.id, :friend_request => friend_create_params}
        expect(response.status).to eq 200
      end
    end
  end

  describe "DELETE#reject" do
    context "正常に友達申請を拒否できる場合" do
      it '正常に友達申請を拒否できるか?' do
        expect do
          @another_user.id = 1 
          @another_user.save
          @user.id = 2
          @user.save
          friend_create_params = {:from_user_id => @friend_request.from_user_id, :to_user_id => @friend_request.to_user_id, :requesting_status => @friend_request.requesting_status}
          delete reject_user_friend_request_path(@another_user.id, @user.id), :params => {:id => @friend_request.id, :friend_request => friend_create_params}        
        end.to change(FriendRequest, :count).by -1
      end
      it '友達申請キャンセルのリクエストが成功すること' do 
        @another_user.id = 1 
        @another_user.save
        @user.id = 2
        @user.save
        friend_create_params = {:from_user_id => @friend_request.from_user_id, :to_user_id => @friend_request.to_user_id, :requesting_status => @friend_request.requesting_status}
        delete reject_user_friend_request_path(@another_user.id, @user.id), :params => {:id => @friend_request.id, :friend_request => friend_create_params}
        expect(response.status).to eq 302
      end
    end
  end

  describe "DELETE#remove" do
    context "正常に友達関係をキャンセルできる場合" do
      it '正常に友達申請を拒否できるか?' do
        expect do
          @another_user.id = 1
          @another_user.save
          @user.id = 2
          @user.save
          friend_create_params = {:from_user_id => @friend_request.from_user_id, :to_user_id => @friend_request.to_user_id, :requesting_status => @friend_request.requesting_status}
          delete remove_user_friend_request_path(@another_user.id, @user.id), :params => {:id => @friend_request.id, :friend_request => friend_create_params}        
        end.to change(FriendRequest, :count).by -1
      end
      it '友達関係キャンセルのリクエストが成功すること' do 
        @another_user.id = 1
        @another_user.save
        @user.id = 2
        @user.save
        friend_create_params = {:from_user_id => @friend_request.from_user_id, :to_user_id => @friend_request.to_user_id, :requesting_status => @friend_request.requesting_status}
        delete remove_user_friend_request_path(@another_user.id, @user.id), :params => {:id => @friend_request.id, :friend_request => friend_create_params}
        expect(response.status).to eq 302
      end
    end
  end

  describe "GET#edit" do
    context "正常に友達申請承認画面へ移動できる場合" do  
      it 'editアクションにリクエストすると正常にレスポンスが返ってくる' do 
        @another_user.id = 1
        @another_user.save
        @user.id = 2
        @user.save
        get edit_user_friend_request_path(@another_user.id, @user.id)
        expect(response.status).to eq 200
      end
    end
    context "正常に友達申請承認画面へ移動できない場合" do
      it 'ログアウト状態でeditアクションにリクエストするとログイン画面にリダイレクトされる' do 
        sign_out @user
        @another_user.id = 1
        @another_user.save
        @user.id = 2
        @user.save
        get edit_user_friend_request_path(@another_user.id, @user.id)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "PATCH#update" do
    context "正常に友達申請を承認できる場合" do
      it '正常に友達申請を承認した時、リクエストが成功することされるか?' do 
        @another_user.id = 1
        @another_user.save
        @user.id = 2
        @user.save
        patch user_friend_request_path(@another_user.id, @user.id)
        expect(response.status).to eq 302
      end
      it '正常に友達申請を承認できるか?' do 
        @another_user.id = 1
        @another_user.save
        @user.id = 2
        @user.save
        patch user_friend_request_path(@another_user.id, @user.id)
        expect(@friend_request.reload.requesting_status).to eq 2
      end
      it '正常に友達申請を承認した後、更新された友達承認画面へリダイレクトされるか?' do 
        @another_user.id = 1
        @another_user.save
        @user.id = 2
        @user.save
        patch user_friend_request_path(@another_user.id, @user.id)
        expect(response).to redirect_to edit_user_friend_request_path
      end
    end
  end

  after do
    sign_out @user
  end
end