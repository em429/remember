class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id # automatically log-in user
      redirect_to @user, notice: "User succesfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "User succesfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end

  private
  
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
