module ApplicationHelper
  def logo
    "closefeed"
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
