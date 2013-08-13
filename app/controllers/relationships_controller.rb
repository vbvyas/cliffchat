class RelationshipsController < ApplicationController
  before_filter :authenticate

  def create
    @user = User.find(params[:relationship][:followed_id])
    puts @user
    current_user.followuser!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollowuser!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
