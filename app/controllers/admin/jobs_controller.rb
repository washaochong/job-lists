class Admin::JobsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :edit, :update, :destroy, :show]
  before_action :require_is_admin

  def index
    @jobs = Job.all
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new job_params

    if @job.save
      redirect_to admin_jobs_path
    else
      render :new
    end
  end

  def show
    @job = Job.find params[:id]
  end

  def edit
    @job = Job.find params[:id]
  end

  def update
    @job = Job.find params[:id]

    if @job.update job_params
      redirect_to admin_jobs_path
    else
      render :edit
    end
  end

  def destroy
    @job = Job.find params[:id]
    @job.destroy
    redirect_to admin_jobs_path
    flash[:alert] = "已删除这个招聘信息"
  end

  def require_is_admin
    if !current_user.admin?
      redirect_to jobs_path
      flash[:alert] = "您不是管理员，不能进入。"
    end
  end


  private
  def job_params
    params.require(:job).permit(:title, :description)
  end
end
