class ProductsController < ApplicationController
  def index
    render json: Product.all
  end

  def show
    render json: Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create!(product_params)
    render json: @product
  end

  def edit
    @product = Product.find(params[:id])
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    render json: Product.all
  end

  def update
    @product = Product.find(params[:id])
    @product.update!(product_params)
    render json: @product
  end

  def count
   render json: Product.all.count
  end
  
  def range_count
    render json: Product.where('id >= ?', params[:id]).limit(params[:count].to_i)
  end

  def range_index
    render json: Product.where('id >= ?', params[:id])
  end

  private

  def product_params
    params.require(:product).permit(:name, :brand_id, :category_id, :price, :quantity)
  end

end
