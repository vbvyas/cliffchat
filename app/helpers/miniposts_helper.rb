module MinipostsHelper

  def wrap(content)
    contents = content.split
    contents.each do |c|
      if c =~ /^#\w+/
        trimmed = c.sub(/[[:punct:]]*$/, '')
        trimmed.sub!('#', '')
        trimmed = trimmed.split(/[[:punct:]]/).first
        unless trimmed.blank?
          t = trimmed.downcase
          topic = Topic.find_by_name(t)
          trimmed = "#" + trimmed
          c.sub!(trimmed, link_to(trimmed, topic, class: 'delete'))
        end
      end
    end
    content = contents.join(' ')
    san_content = sanitize(content)
    auto_link(san_content)
  end

  private

    def wrap_long_string(text, max_width = 60)
      zero_width_space = "&#8203;"
      regex = /.{1,#{max_width}}/
      (text.length < max_width) ? text :
        text.scan(regex).join(zero_width_space)
    end
end
