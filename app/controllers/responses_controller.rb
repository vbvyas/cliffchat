class ResponsesController < ApplicationController
  before_filter :authenticate
  before_filter :authorized_user, :only => :destroy

  def create
    @response = current_user.responses.build(params[:response])
    minipost = Minipost.find(params[:response][:minipost_id])
    minipost.responses << @response

    topics = @response.content.split
    topics.each do |t|
      if t =~ /^#\w+/
        t.downcase!
        t.sub!(/[[:punct:]]*$/, '')
        t.sub!('#', '')
        t = t.split(/[[:punct:]]/).first
        topic = Topic.find_or_create_by_name(t) unless t.blank?
      end
    end

    respond_to do |format|
      if @response.save
        format.html { redirect_back_or root_path }
        format.js
      else
        format.html do
          @minipost = Minipost.new
          @feed_items =  current_user.feed.paginate(:page => params[:page]) 
          @response = Response.new
          render 'pages/home'
        end
        format.js
      end
    end
  end

  def destroy
    respond_to do |format|
      @response.destroy
      format.html { redirect_back_or root_path }
      format.js
    end
  end

  private

    def authorized_user
      @response = current_user.responses.find_by_id(params[:id])
      redirect_to root_path if @response.nil?
    end
end
