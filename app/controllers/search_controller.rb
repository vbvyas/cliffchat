class SearchController < ApplicationController
  
  def new
    keywords = params[:search][:text].split
    miniposts = []
    responses = []
    keywords.each do |k|
      k.downcase!
      topic = Topic.find_by_name(k)
      miniposts += topic.miniposts unless topic.nil?
      miniposts += Minipost.where('content LIKE ?', "%#{k}%")
      responses += Response.select(:minipost_id).where('content LIKE ?', "%#{k}%")
    end
    minipost_ids = []
    responses.each do |r|
      minipost_ids << r.minipost_id
    end
    miniposts += Minipost.find(minipost_ids)
    @miniposts = miniposts.paginate(:page => params[:page])
    @response = Response.new
  end

end
