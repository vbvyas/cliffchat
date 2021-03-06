class UsersController < ApplicationController
  before_filter :authenticate, only: [:show, :index, :edit, :update, :following, :followers]
  before_filter :correct_user, only: [:edit, :update]

  def new
    @user = User.new
    @title = "Sign up"
  end

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @miniposts = @user.miniposts.paginate(:page => params[:page])
    @miniposts.each do |minipost|
      @responses = minipost.responses
    end
    @title = @user.name
    @response = Response.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to cliffchat!"
      redirect_to root_path
    else
      @title = "Sign up"
      render :new
    end
  end

  def edit
    @title = "Edit User"
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit User"
      render 'edit'
    end
  end

  def following
    @users = current_user.followed_users.paginate(page: params[:page])
    @title = "Following"
    render 'show_follow'
  end

  def followers
    @users = current_user.followers.paginate(page: params[:page])
    @title = "Followers"
    render 'show_follow'
  end

  private
  
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
