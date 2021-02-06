class PostsController < ApplicationController
  # before_action :authenticate_user!, except: :show
  require 'nokogiri'
  require 'open-uri'
  require 'date'

  def index
    if user_signed_in?
      @posts = Post.all.order('created_at DESC')
      post_list_users = FriendRequest.where("from_user_id = ? or to_user_id = ?", current_user.id, current_user.id).where(requesting_status: 2).pluck(:from_user_id, :to_user_id)
      
      @post_lists_users = post_list_users.flatten!

      if @post_lists_users != nil
        @post_list_users = @post_lists_users.uniq
      end

      @post = Post.new
      @like = Like.create
    end
    @users_record = User.search(params[:keyword])
    @users = @users_record.select(:id)

    url = 'http://info.finance.yahoo.co.jp/fx/detail/?code=USDJPY=FX'
    doc = Nokogiri::HTML(open(url))
    @bid = doc.xpath("//*[@id='USDJPY_detail_bid']").text
    @ask = doc.xpath("//*[@id='USDJPY_detail_ask']").text
    @time = DateTime.now
    @mmk_bid = doc.xpath("//*[@ids='EURJPY_detail_bid']").text
    @mmk_ask = doc.xpath("//*[@ids='EURJPY_detail_ask']").text
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render("posts/new")
    end
  end

  private

  def post_params
    params.require(:post).permit(:text, :post_image).merge(user_id: current_user.id)
  end
end
