class MinipostsController < ApplicationController
  before_filter :authenticate
  before_filter :authorized_user, :only => :destroy

  def create
    @minipost = current_user.miniposts.build(params[:minipost])
    @minipost.affiliation_id = current_user.affiliation_id
    if @minipost.save
      flash[:success] = "Post Created!"
      redirect_to root_path
    else
      @feed_items = [] 
      render 'pages/home'
    end
  end

  def destroy
    @minipost.destroy
    redirect_back_or root_path
  end

  private

    def authorized_user
      @minipost = current_user.miniposts.find_by_id(params[:id])
      redirect_to root_path if @minipost.nil?
    end
end
