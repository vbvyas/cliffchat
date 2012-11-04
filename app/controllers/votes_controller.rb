class VotesController < ApplicationController
  before_filter :authenticate

  def create
    @response = Response.find(params[:vote][:votedresponse_id])
    current_user.voteresponse!(@response)
    respond_to do |format|
      format.html { redirect_back_or root_path }
      format.js
    end
  end
end
