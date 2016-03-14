class CategoriesController < ApplicationController
  def index
    render json: Category.all
  end

  def show
    render json: Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create!(category_params)

    render json: @category
  end

  def update
    @category = Category.find(params[:id])
    @category.update!(category_params)
    render json: @category
  end
  
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    render json: Category.all
  end
  
  def count
    @categories = Category.all.count

    render json: @categories
  end

  def range_count
    render json: Category.where('id >= ?', params[:id]).limit(params[:count].to_i)
  end

  def range_index
    render json: Category.where('id >= ?', params[:id])
  end



  private

  def category_params
    params.require(:category).permit(:name)
  end
end
