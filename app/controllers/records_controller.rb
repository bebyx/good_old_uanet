class RecordsController < ApplicationController

  before_action :set_record, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]

  def index
    @records = Record.all
  end

  def show
  end

  def new
    @record = Record.new
  end

  def edit
  end

  def create
    @record = Record.new(record_params)
    @record.user = current_user

    if @record.save
      redirect_to records_path
    else
      render 'new'
    end
  end

  def update
    if @record.update(record_params)
      redirect_to record_path
    else
      render 'edit'
    end
  end

  def destroy
    @record.destroy

    redirect_to records_path
  end

  private
    def record_params
      params.require(:record).permit(:name, :first_year, :webarchive, :link, :comment, :description)
    end

    def set_record
      @record = Record.find(params[:id])
    end

    def require_same_user
     if current_user != @record.user && !current_user.admin?
        flash[:danger] = "You can manage your articles only"
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
