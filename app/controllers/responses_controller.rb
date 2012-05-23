class ResponsesController < ApplicationController
  before_filter :authenticate
  before_filter :authorized_user, :only => :destroy

  def create
    @response = current_user.responses.build(params[:response])
    minipost = Minipost.find(params[:response][:minipost_id])
    minipost.responses << @response
    if @response.save
      flash[:success] = "Response created!"
      redirect_back_or root_path
    else
      @minipost = Minipost.new
      @feed_items =  current_user.feed.paginate(:page => params[:page]) 
      @response = Response.new
      render 'pages/home'
    end
  end

  def destroy
    @response.destroy
    redirect_back_or root_path
  end

  private

    def authorized_user
      @response = current_user.responses.find_by_id(params[:id])
      redirect_to root_path if @response.nil?
    end
end
