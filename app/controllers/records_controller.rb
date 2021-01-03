class RecordsController < ApplicationController

  before_action :set_record, only: [:edit, :update, :show, :destroy, :approve]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update]
  before_action :require_admin, only: [:destroy, :approve]

  def index
    @records = Record.where(approved: true).paginate(page: params[:page], per_page: 20)
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

    if current_user.admin?
      @record.update_attribute(:approved, approve_param[:approved] => true)
    end

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

  def approve
    @record.update_attribute(:approved, approve_param[:approved] => true)

    redirect_to admin_path
  end

  def destroy
    @record.destroy

    redirect_to records_path
  end

  private
    def record_params
      params.require(:record).permit(:name, :first_year, :webarchive, :link, :comment, :description, :approved)
    end

    def approve_param
      params.permit(:record)
    end

    def set_record
      @record = Record.find(params[:id])
    end

    def require_same_user
     if current_user != @record.user && !current_user.admin?
        flash[:alert] = "Ви можете редагувати тільки власні записи."
        redirect_to records_path
     end
    end

    def require_admin
      if !current_user.admin?
        flash[:alert] = "Тільки адміни можуть це робити."
        redirect_to records_path
      end
    end
end
