class SolutionsController < ApplicationController
  before_action :set_task

  def index
    @solutions = @task.solutions
  end

  def show
    @solution = @task.solutions.find(params[:id])
  end

  def new
    @solution = Solution.new
  end

  def edit
    @solution = @task.solutions.find(params[:id])
  end

  def create
    @solution = @task.solutions.create!(solution_params)
    redirect_to action: :index
  end

  def update
    @solution = @task.solutions.find(params[:id])
    @solution.update!(solution_params)

    redirect_to lecture_task_solution_path
  end

  def destroy
    @solution = @task.solutions.find(params[:id])
    @solution.destroy

    redirect_to action: :index
  end

  private

  def solution_params
    params.require(:solution).permit(:text_block, :task_id)
  end

  def set_lecture
    @lecture = Lecture.find(params[:lecture_id])
  end

  def set_task
    set_lecture
    @task = @lecture.tasks.find(params[:task_id])
  end
end
