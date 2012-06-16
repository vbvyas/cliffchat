class MinipostsController < ApplicationController
  before_filter :authenticate
  before_filter :authorized_user, :only => :destroy

  def new
    @minipost = current_user.miniposts.new
  end
  
  def create
    @minipost = current_user.miniposts.build(params[:minipost])
    @minipost.affiliation_id = current_user.affiliation_id
    topics = params[:minipost][:topics].split
    topics.each do |t|
      t.downcase!
      topic = Topic.find_by_name(t) || Topic.create(:name => t)
      @minipost.topics << topic unless @minipost.topics.include?(topic)
    end

    flash[:success] = "post created!" 
    respond_to do |format|
      if @minipost.save
        @response = Response.new
        format.html { redirect_to root_path }
        format.js
      else
        format.html do
          @feed_items = []
          render 'pages/home' 
        end
        format.js
      end
    end
  end

  def destroy
    respond_to do |format|
      @minipost.destroy
      format.html { redirect_back_or root_path }
      format.js
    end
  end

  private

    def authorized_user
      @minipost = current_user.miniposts.find_by_id(params[:id])
      redirect_to root_path if @minipost.nil?
    end

end
