class LecturesController < ApplicationController
  def index
    @lectures = Lecture.all
  end

  def new
    @lecture = Lecture.new
  end

  def show
    @lecture = Lecture.find(params[:id])
  end

  def edit
    @lecture = Lecture.find(params[:id])
  end

  def create
    @lecture = Lecture.create!(lecture_params)

    redirect_to action: :index
  end

  def destroy
    @lecture = Lecture.find(params[:id])
    @lecture.destroy
    redirect_to action: :index
  end

  def update
    @lecture = Lecture.find(params[:id])
    @lecture.update!(lecture_params)

    redirect_to lecture_path
  end

  private

  def lecture_params
    params.require(:lecture).permit(:name, :text_body)
  end

end

