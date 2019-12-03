class UsersController < ApplicationController

  before_action :set_user, only: [:show,:edit, :update, :destroy, :followers, :followees]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params(:name, :username, :password, :password_confirmation))
    @user.set_img_url
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      render :new
    end
  end

  def check_user
    @user = User.find_by(username: params[:user][:username])
    if  @user
      if (params[:user][:password] == @user.password)
          redirect_to @user
      end
    else
      render :login
    end
  end

  def show

    if current_user
      @current_user_does_not_follow = !current_user_follows?
      @current_user_follows = current_user_follows?
      @authorization =  authorization?
    else
      render :index
    end
  end

end