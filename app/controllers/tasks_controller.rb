class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :is_owner, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to @task
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
     @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to @task
    else
      render :new
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_url
  end

  private

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def is_owner
    unless current_user == Task.find(params[:id]).user
      redirect_to root_url
    end
  end
end
