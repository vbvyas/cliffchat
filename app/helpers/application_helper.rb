module ApplicationHelper
  def logo
    image_tag("logo.png", :alt => "closefeed", :class => "round")
  end

  def title
    base_title = "closefeed"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
