class AffiliationsController < ApplicationController

  def index
    if params[:term]
      @affiliations = Affiliation.find(:all, :conditions => ['name ILIKE ?', "%#{params[:term]}%"], limit: 10, order: :name)
    else
      @affiliations = Affiliation.all
    end

    respond_to do |format|
      format.html
      format.json { render :json => @affiliations.to_json }
    end
  end

  def show
    @minipost = Minipost.new
    @affiliation = Affiliation.find(params[:id])
    if @affiliation.nil?
      redirect_to root_path
    else
      @feed_items = @affiliation.miniposts.paginate(per_page: 20, page: params[:page])

      if request.xhr?
        render partial: 'shared/feed_item', collection: @feed_items
      end
    end
  end
end
