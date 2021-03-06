class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update]
  def index 
    @users = User.all
  end 
  
  def new 
    @user = User.new 
  end 
  
  def create 
    @user = User.new(user_params)
    if @user.save 
      session[:user_id] = @user.id 
      flash[:success] = "WELCOME TO THE ALPHA-BLOG #{@user.username}"
      redirect_to user_path(@user)
    else 
      render 'new'
  end 
end 

def edit 
  @user = User.find(params[:id])
end 

def show 
  @user = User.find(params[:id])
end 

def update 
  @user = User.find(params[:id])
  if @user.update(user_params) 
    flash[:success] = "YOUR ACCOUNT WAS SUCCESSFULLY UPDATED!"
    redirect_to articles_path
  else 
    render 'edit'
  end 
end 
  
  private
  
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end 
  
  def set_user
    @user = User.find(params[:id])
  end 
  
  def require_same_user
  if current_user != @user 
    flash[:danger] = "You can only edit your account!"
    redirect_to root_path
  end 
end 
  
end 