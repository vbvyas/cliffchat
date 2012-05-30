class TopicsController < ApplicationController

  def show
    @topic = Topic.find(params[:id])
    @miniposts = @topic.miniposts.paginate(:page => params[:page])
    @miniposts.each do |minipost|
      @responses = minipost.responses
    end
    @title = @topic.name
    @response = Response.new
  end
end
