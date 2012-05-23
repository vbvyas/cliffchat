module ApplicationHelper
  def logo
    image_tag("logo.png", :alt => "CloseFeed", :class => "round")
  end

  def title
    base_title = "CloseFeed"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
