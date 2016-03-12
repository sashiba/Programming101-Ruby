require 'bigdecimal'
require 'bigdecimal/util'

module Promotions
  def self.type(promotion)
    name, options = promotion.first

    case name
    when :get_one_free then GetOneFree.new options
    when :package      then PackageDiscount.new *options.first
    when :threshold    then ThresholdDiscount.new *options.first
    end
  end

  class GetOneFree
    def initialize(nth_free_item)
      @nth_free_item = nth_free_item
    end

    def discount(quantity, price)
      (quantity / @nth_free_item) * price
    end

    def print_promo
      "(buy #{@nth_free_item - 1}, get 1 free)"
    end
  end

  class PackageDiscount
    def initialize(size, percent)
      @size, @percent = size, percent
    end

    def discount(quantity, price)
      packages = quantity / @size
      package_discount = @size * price * (@percent / '100'.to_d)

      packages * package_discount
    end

    def print_promo
      "(get #{@percent}% off for every #{@size})"
    end
  end

  class ThresholdDiscount
    def initialize(threshold, percent)
      @threshold, @percent = threshold, percent
    end

    def discount(quantity, price)
      item_discount = price * (@percent / '100'.to_d)
      items_for_discount = quantity - @threshold if @threshold < quantity

      return 0 if @threshold >= quantity

      items_for_discount * item_discount
    end

    def print_promo
      ordinal = { 1 => 'st', 2 => 'nd', 3 => 'rd' }.fetch @threshold, 'th'

      "(#{@percent}% off of every after the #{@threshold}#{ordinal})"
    end
  end
end

module Coupon
  def self.create(name, discount)
    case discount.keys.first
    when :percent then PercentDiscount.new name, discount[:percent]
    when :amount  then AmountDiscount.new  name, discount[:amount]
    end
  end

  class PercentDiscount
    attr_accessor :name

    def initialize(name, percent)
      @name, @percent = name, percent
    end

    def discount(current_bill)
      current_bill * (@percent / '100'.to_d)
    end

    def print_coupon
      "Coupon #{@name} - %2d%% off" % @percent
    end
  end

  class AmountDiscount
    attr_accessor :name

    def initialize(name, amount)
      @name, @amount = name, amount
    end

    def discount(current_bill)
      return current_bill if @amount > current_bill

      current_bill - @amount
    end

    def print_coupon
      "Coupon #{@name} - %5.2f off" % @amount
    end
  end
end

class Product
  attr_accessor :name, :price, :promotion

  def initialize(name, price, promotion)
    @name, @price, @promotion = name, price, promotion
  end

  def discounted?(quantity)
    price_without_discount(quantity) != price_with_discount(quantity)
  end

  def price_without_discount(quantity)
    price * quantity
  end

  def price_with_discount(quantity)
    return price_without_discount(quantity) if promotion == {}

    price_without_discount(quantity) - promotion.discount(quantity, price)
  end
end

class Inventory
  attr_accessor :products

  def initialize
    @products = []
    @coupons = []
  end

  def register(product, price, promo = {})
    price = price.to_d

    if product.length > 40 or !price.between?(0.01, 999.99) or self[product]
      raise "Invalid parameters passed."
    end
    promo = Promotions.type promo unless promo == {}
    products << Product.new(product, price, promo)
  end

  def register_coupon(coupon_name, discount)
    @coupons << Coupon.create(coupon_name, discount)
  end

  def new_cart
    Cart.new(self)
  end

  def length
    products.length
  end

  def [](name)
    products.find { |product| product.name == name }
  end

  def coupon(coupon_name)
    @coupons.find { |coupon| coupon.name == coupon_name }
  end
end

class Cart
  attr_accessor :inventory, :items, :coupon

  def initialize(inventory)
    @inventory = inventory
    @items = {}
    @coupon = nil
  end

  def add(product, quantity = 1)
    raise "Invalid parameters passed." unless inventory[product]

    return items[product] = quantity unless items[product]

    raise "Quantity not in range." if items[product] <= 0 or items[product] > 99

    items[product] = items[product] + quantity
  end

  def use(coupon_name)
    raise "Already 1 coupon used" unless @coupon == nil

    @coupon = inventory.coupon(coupon_name)
  end

  def items_price
    items_price = 0
    items.each do |product, quantity|
      items_price += inventory[product].price_with_discount(quantity)
    end

    items_price
  end

  def total
    return items_price - coupon_discount unless @coupon.nil?

    items_price
  end

  def coupon_discount
    @coupon.discount items_price
  end

  def invoice
    Invoice.new(self)
  end
end

class Invoice
  attr_accessor :invoice

  def initialize(cart)
    @cart = cart
  end

  def to_s
    @invoice = ""
    header
    products
    line
    total

    invoice
  end

  def line
    invoice << "+" + "-"*48 + "+" + "-"*10 + "+\n"
  end
  def header
    #name(40), qty(2), price(6), |(3), ' '(4)
    line
    print "Name", "qty", "price"
    line
  end

  def products
    @cart.items.each do |product, quantity|
      inventory_product = @cart.inventory[product]
      print product, quantity, inventory_product.price_without_discount(quantity).to_digits
      if inventory_product.discounted?(quantity)
        print "  #{inventory_product.promotion.print_promo}", '',
        "-#{inventory_product.promotion.discount(quantity, inventory_product.price).round(2).to_digits}"
      #round?
      end
    end

    if @cart.coupon then
      print @cart.coupon.print_coupon, '', coupon_discount_pattern(@cart.coupon_discount.to_digits) 
    end
  end

  def coupon_discount_pattern(number)
    number = '-' + number
    "%5.2f" % number
  end

  def total_pattern(number)
    "%5.2f" % number
  end

  def total
    print "TOTAL", "", total_pattern(@cart.total)
    line
  end

  def print(*args)
    invoice << "| %-40s %5s | %8s |\n" % args
  end
end
