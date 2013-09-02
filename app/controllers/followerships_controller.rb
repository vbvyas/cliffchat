class FollowershipsController < ApplicationController
  before_filter :authenticate

  def index
   topics = current_user.topics
   m = []
   topics.each do |t|
     m << t.minipost_ids
   end
   m = m.flatten.uniq
   @feed_items = Minipost.where("affiliation_id = ? AND id in (?)", current_user.affiliation_id, m).paginate(per_page: 20, page: params[:page])
   if request.xhr?
     render partial: 'shared/feed_item', collection: @feed_items
   end
  end

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
