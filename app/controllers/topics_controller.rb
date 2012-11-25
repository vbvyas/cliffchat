class TopicsController < ApplicationController
  before_filter :authenticate

  def show
    @topic = Topic.find(params[:id])
    @feed_items = @topic.miniposts.where("affiliation_id = ?", current_user.affiliation_id).paginate(per_page: 20, page: params[:page])
    @feed_items.each do |minipost|
      @responses = minipost.responses
    end
    @title = @topic.name
    @response = Response.new

    if request.xhr?
      render partial: 'shared/feed_item', collection: @feed_items
    end
  end
end
