class FollowershipsController < ApplicationController
  before_filter :authenticate

  #def index
  # topics = current_user.topics
  # minipost_ids = []
  # topics.each do |t|
  #   m << t.minipost_ids
  # end
  # m = m.flatten.uniq
  # @feed_items = Minipost.find(m).where("affiliation_id = ", current_user.affiliation_id) # or Minipost.where(id: m)
  # if request.xhr?
  #   render partial: 'shared/feed_item', collection: @feed_items
  # end
  #end

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
