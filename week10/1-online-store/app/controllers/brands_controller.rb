class BrandsController < ApplicationController
  def index
    render json: Brand.all
  end

  def show
    render json: Brand.find(params[:id])
  end

  def new
    @brand = Brand.new
  end

  def create
    # <<-JSON
    # {
    #   "name": "So fancy",
    #   "quality": "SSS"
    #  }
    # JSON
    # params[:name], params[:quality]
    # params[:controller] # brands
    # params[:action] # create
    # params[:brand] = { name: 'So Fancy', quality: 'SS' }
    # Brand.new(params)
    @brand = Brand.create!(brand_params)
    # render json: brand, status: :created
    # render json: brand.errors, status: :unprocessable_entity
    # brand_params = params.require(:brand).permit(:name, :description)
    # Brand.new(brand_params[:brand]
    render json: @brand
  end

  def edit
    @brand = Brand.find(params[:id])
  end

  def destroy
    @brand = Brand.find(params[:id])
    @brand.destroy
    render json: Brand.all
  end

  def update
    @brand = Brand.find(params[:id])
    @brand.update!(brand_params)
    render json: @brand
  end

  def count
    @brands = Brand.all.count

    render json: @brands
  end

  def range_count
    render json: Brand.where('id >= ?', params[:id]).limit(params[:count].to_i)
  end

  def range_index
    render json: Brand.where('id >= ?', params[:id])
  end

  private

  def brand_params
    params.require(:brand).permit(:name,:description)
  end
end
