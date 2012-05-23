class PagesController < ApplicationController
  def home    
    if signed_in?
      @title = :Home
      @minipost = Minipost.new
      @feed_items =  current_user.feed.paginate(:page => params[:page]) 
      @response = Response.new
    else
      @title = 'Welcome to closefeed'
    end
  end

  def about
    @title = 'About closefeed'
  end

  def termsofuse
    @title = 'closefeed - Terms of Use'
  end

  def privacystatement
    @title = 'closefeed - Privacy Statement'
  end  
  
  def followus
    @title = 'closefeed - Follow Us'
  end
  
  def faq
    @title = 'closefeed - FAQ'
  end
end
