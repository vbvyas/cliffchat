class InterestsController < ApplicationController

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
