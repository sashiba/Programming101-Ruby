class TasksController < ApplicationController
  before_action :set_lecture

  def index
    @tasks = @lecture.tasks
  end

  def new
    @task = Task.new
  end

  def show
    @task = @lecture.tasks.find(params[:id])
  end

  def edit
    @task = @lecture.tasks.find(params[:id])
  end

  def create
    @task = @lecture.tasks.create!(task_params)
    redirect_to action: :index
    # @task = Task.new(task_params)
    # @task.lecture_id = params[:lecture_id]
  end

  def update
    @task = @lecture.tasks.find(params[:id])
    @task.update!(task_params)

    redirect_to lecture_task_path
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    redirect_to action: :index
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :lecture_id)
  end

  def set_lecture
    @lecture = Lecture.find(params[:lecture_id])
  end
end
