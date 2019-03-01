class JobsController < ApplicationController

  def index
    @jobs = Job.find_each(batch_size: 100)
  end

  def show
    @job = Job.find params[:id]
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new job_params

    if @job.save
      redirect_to jobs_path, notice:"创建成功"
    else
      render :new
    end
  end

  def edit
    @job = Job.find params[:id]
  end

  def update
    @job = Job.find params[:id]

    if @job.update job_params
      redirect_to jobs_path, notice:"更新成功"
    else
      render :edit
    end
  end

  def destroy
    @job = Job.find params[:id]
    @job.destroy
    redirect_to jobs_path
    flash[:alert] = "删除成功"
  end

  private

  def job_params
    params.require(:job).permit(:title, :description)
  end
end
