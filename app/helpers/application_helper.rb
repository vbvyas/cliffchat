module ApplicationHelper
  def logo
    "cliffchat"
  end

  def title
    base_title = "cliffchat"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def pageless(total_pages, url=nil, container=nil)
    opts = {
      :totalPages => total_pages,
      :url        => url,
      :loaderMsg  => 'Loading more results',
      :loaderImage => image_path("load.gif")
    }
    
    container && opts[:container] ||= container
    
    javascript_tag("$('#postcontainer').pageless(#{opts.to_json});")
  end
end
