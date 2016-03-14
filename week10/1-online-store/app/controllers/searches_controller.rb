class SearchesController < ApplicationController
  def type
   result = Search.by_type_and_slug(search_params)

    render json: result
  end

  def property
    result = Search.by_type_property_type(search_params)

    render json: result
  end

  private

  def search_params
    params.permit(:type, :slug, :property)
  end
end
