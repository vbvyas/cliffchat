class FollowershipsController < ApplicationController

  def create
    @topic = Topic.find(params[:followership][:topic_id])
    current_user.follow!(@topic)
    respond_to do |format|
      format.html { redirect_to @topic }
      format.js
    end
  end

  def destroy
    @topic = Followership.find(params[:id]).topic
    current_user.unfollow!(@topic)
    respond_to do |format|
      format.html { redirect_to @topic }
      format.js
    end
  end
end
