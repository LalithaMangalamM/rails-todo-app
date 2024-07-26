class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  def index
    @tasks = current_user.tasks
    if params[:search].present?
      @tasks = @tasks.where("task_name ILIKE ? OR description ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    end

    if params[:status].present?
      @tasks = @tasks.where(status: params[:status])
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_path, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @task.user == current_user
      @task.destroy
      respond_to do |format|
        format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      redirect_to tasks_url, alert: "You are not authorized to delete this task."
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:task_name, :description, :dead_line, :status, :reminder_sent, :deadline_mail_sent)
  end
end
