class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:user_id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "User succesfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:user_id])
  end

  def update
    @user = User.find(params[:user_id])
    if @user.update(user_params)
      redirect_to @user, notice: "User succesfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @user.destroy
    redirect_to root_path
  end

  private
  
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
