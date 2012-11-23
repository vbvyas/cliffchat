class PagesController < ApplicationController
  def home    
    if signed_in?
      @title = 'closefeed - Home'
      @minipost = Minipost.new
      @feed_items =  current_user.feed.paginate(per_page: 20, page: params[:page]) 

      if request.xhr?
        render partial: 'shared/feed_item', collection: @feed_items
      end
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

  def contact
    @title = 'closefeed - Contact'
  end
end
