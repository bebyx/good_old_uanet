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
    if verify_recaptcha(model: @user) && @user.save
        session[:user_id] = @user.id
        flash[:notice] = "Ласкаво просимо!"
        redirect_to user_path(@user)
    else
        render 'new'
    end

  end

  def edit
  end

  def update

    if @user.update(user_params)
      flash[:notice] = "Дані користувача оновлено."
      redirect_to records_path
    else
      render 'edit'
    end

  end

  def show
    user_records = Record.where(user_id: @user.id)
    @approved_records = user_records.where(approved: true)
    @pending_records = user_records.where(approved: false)
  end

  def admin
    @pending_records = Record.where(approved: false)
  end

  def destroy
    @user.destroy
    flash[:alert] = "Користувача видалено."
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
      flash[:alert] = "Ви можете редагувати тільки свій профіль."
      redirect_to user_path(@user)
    end
  end

  def require_no_user
    if logged_in?
      flash[:alert] = "Ви вже маєте один акаунт. Його можна оновити."
      redirect_to records_path
    end
  end

  def require_admin
    if !current_user.admin?
      flash[:alert] = "Тільки адміни можуть видаляти користувачів."
      redirect_to records_path
    end
  end


end
