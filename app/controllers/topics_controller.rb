class TopicsController < ApplicationController
  before_filter :authenticate

  def show
    @topic = Topic.find(params[:id])
    @miniposts = @topic.miniposts.where("affiliation_id = ?", current_user.affiliation_id).paginate(:page => params[:page])
    @miniposts.each do |minipost|
      @responses = minipost.responses
    end
    @title = @topic.name
    @response = Response.new
  end
end
