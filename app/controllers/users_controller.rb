class UsersController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update]
  # 本人のみprofileの編集更新が可能
  before_action :check_user_correct, only: [:edit, :update]
  
  def show
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App"
      redirect_to @user
    else 
      render 'new'
    end
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def set_message
    @user = User.find(params[:id])
  end
  
  def check_user_correct
    redirect_to root_url if @user != current_user
  end
end
