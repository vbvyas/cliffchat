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
end
