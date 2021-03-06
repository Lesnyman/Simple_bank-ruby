class UsersController < ApplicationController
  #before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:edit, :update, :show, :index, :destroy, :profile]
  before_action :correct_user,   only: [:edit, :update, :profile]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page], :per_page => 10)
  end

  def show
    @user = User.find(params[:id])
  end
  
  def profile
    @user = User.find(params[:id])
    @account = Account.where(user_id: params[:id])
    return @account, @user
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end


  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      Account.create_accout_for_new_user(@user.id)             
      flash[:success] = "Welcome to the Sample App!"
      redirect_to profile_path(@user)
    else
      render 'new'
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name,:lastname, :email, :password, :password_confirmation)
    end
    
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
    
    
end
