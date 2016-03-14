module Search
    # :type :slug
    # Brand.where('name LIKE ?', '%brand%').all
    # scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"])}
    
  def self.by_type_and_slug(params)
    case params[:type]
    when 'brand'
      @brands = Brand.search("#{params[:slug]}")
    when 'product'
      @products = Product.search("#{params[:slug]}")
    when 'category'
      @categories = Category.search("#{params[:slug]}")
    end
  end

  def self.by_type_property_type(params)
    slug = params[:slug]
    prop = params[:property]

    case params[:type]
    when 'brand'
      @brands = Brand.search_property("#{prop}", "#{slug}")
    when 'product'
      @products = Product.search_property("#{prop}", "#{slug}")
    when 'category'
      @categories = Category.search_property("#{prop}", "#{slug}")
    end
  end
end
