class PagesController < ApplicationController
  def home    
    if signed_in?
      @title = 'cliffchat - Home'
      @minipost = Minipost.new
      @feed_items =  current_user.feed.paginate(per_page: 20, page: params[:page]) 

      if request.xhr?
        render partial: 'shared/feed_item', collection: @feed_items
      end
    else
      @title = 'Welcome to cliffchat'
    end
  end

  def about
    @title = 'About cliffchat'
  end

  def termsofuse
    @title = 'cliffchat - Terms of Use'
  end

  def privacystatement
    @title = 'cliffchat - Privacy Statement'
  end  
  
  def followus
    @title = 'cliffchat - Follow Us'
  end
  
  def faq
    @title = 'cliffchat - FAQ'
  end

  def contact
    @title = 'cliffchat - Contact'
  end
end
