module MinipostsHelper

  def wrap(content)
    contents = content.split
    contents.each do |c|
      if c.first == '#'
        c.sub!(/[[:punct:]]*$/, '')
        topic = c.downcase
        topic.sub!('#', '')
        if Topic.find_by_name(topic)
          t = Topic.find_by_name(topic)
          content.sub!(c, link_to(c, t, class: 'delete'))
        end
      end
    end
    sanitize(raw(content.split.map{ |s| wrap_long_string(s) }.join(' ')))
  end

  private

    def wrap_long_string(text, max_width = 60)
      zero_width_space = "&#8203;"
      regex = /.{1,#{max_width}}/
      (text.length < max_width) ? text :
        text.scan(regex).join(zero_width_space)
    end
end
