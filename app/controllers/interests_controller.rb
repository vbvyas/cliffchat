class InterestsController < ApplicationController
  before_filter :authenticate

  def index
    @feed_items = current_user.followedposts.paginate(per_page: 20, page: params[:page])
    if request.xhr?
      render partial: 'shared/feed_item', collection: @feed_items
    end
  end
  
  def create
    @minipost = Minipost.find(params[:interest][:followedpost_id])
    current_user.followpost!(@minipost)
    respond_to do |format|
      format.html { redirect_back_or root_path }
      format.js
    end
  end

  def destroy
    @minipost = Interest.find(params[:id]).followedpost
    current_user.unfollowpost!(@minipost)
    respond_to do |format|
      format.html { redirect_back_or root_path }
      format.js
    end
  end
end
