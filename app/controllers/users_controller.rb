class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update]
  before_action :require_no_user, only: [:new, :create]
  before_action :require_admin, only: [:destroy, :index]

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
        flash[:success] = "Welcome to Alpha Blog #{@user.username}"
        redirect_to user_path(@user)
    else
        render 'new'
    end

  end

  def edit
  end

  def update

    if @user.update(user_params)
      flash[:success] = "User info was successfully updated"
      redirect_to records_path
    else
      render 'edit'
    end

  end

  def show
    @user_records = Record.where(user_id: @user.id)
  end

  def admin
    @pending_records = Record.where(approved: false)
  end

  def destroy
    @user.destroy
    flash[:danger] = "User has been deleted"
    redirect_to users_path
  end


  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:danger] = "You can manage your profile only"
      redirect_to root_path
    end
  end

  def require_no_user
    if logged_in?
      flash[:danger] = "Log out before signing up a new user"
      redirect_to records_path
    end
  end

  def require_admin
    if !current_user.admin?
      flash[:danger] = "Only admins can delete users"
      redirect_to records_path
    end
  end


end
