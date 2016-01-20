require 'minitest/autorun'

require_relative 'shopping_cart.rb'

class ShoppingCardTest < Minitest::Test
  def test_register_item_in_inventory
    inventory = Inventory.new

    inventory.register 'Green Tea', '1.99'
    inventory.register 'Red Tea',   '2.49'
    inventory.register 'Earl Grey', '1.49'

    assert_equal 3, inventory.length
  end

  # def test_register_raise_error
  #   inventory = Inventory.new

  #   inventory.register 'Green Tea', '-0.02'

  #   assert_equal
  # end
end
class CartTest < Minitest::Test

  def test_create_cart
    inventory = Inventory.new

    inventory.register 'Green Tea', '1.99'
    inventory.register 'Red Tea',   '2.49'
    inventory.register 'Earl Grey', '1.49'
    cart = inventory.new_cart

    assert_equal true, (cart.instance_of? Cart)
  end

  # def test_cart_total_with_few_products
  #   inventory = Inventory.new

  #   inventory.register 'Green Tea', '1.99'
  #   inventory.register 'Red Tea',   '2.49'
  #   inventory.register 'Earl Grey', '1.49'
  #   cart = inventory.new_cart
  #   cart.add 'Green Tea'
  #   cart.add 'Red Tea', 2
  #   cart.add 'Green Tea', 2

  #   assert_equal '10.95'.to_d, cart.total
  # end
  
  # def test_promotions_nth_free_item_but_no_discount
  #   inventory = Inventory.new
  #   inventory.register 'Green Tea', '1.00', get_one_free: 4
  #   cart = inventory.new_cart
  #   cart.add 'Green Tea', 3

  #   assert_equal '3.00'.to_d, cart.total
  # end

  # def test_promotions_nth_free_item_with_enough_items_for_discount
  #   inventory = Inventory.new
  #   inventory.register 'Green Tea', '1.00', get_one_free: 4
  #   cart = inventory.new_cart
  #   cart.add 'Green Tea', 8

  #   assert_equal '6.00'.to_d, cart.total
  # end

  # def test_promotions_package_with_not_enough_items_for_discount
  #   inventory = Inventory.new
  #   inventory.register 'Red Tea', '1.00', package: {3 => 20}
  #   cart = inventory.new_cart
  #   cart.add 'Red Tea', 2

    
  #   assert_equal '2.00'.to_d, cart.total
  # end

  # def test_promotions_package_with_enough_items_for_discount
  #   inventory = Inventory.new
  #   inventory.register 'Red Tea', '1.00', package: {3 => 20}
  #   cart = inventory.new_cart
  #   cart.add 'Red Tea', 4

    
  #   assert_equal '3.40'.to_d, cart.total
  # end

  # def test_promotions_threshold_with_not_enough_items_for_discount
  #   inventory = Inventory.new
  #   inventory.register 'Earl Grey', '1.00', threshold: {10 => 50}
  #   cart = inventory.new_cart
  #   cart.add 'Earl Grey', 10
      
  #   assert_equal '10.00'.to_d, cart.total
  # end

  # def test_promotions_threshold_with_enough_items_for_discount
  #   inventory = Inventory.new
  #   inventory.register 'Earl Grey', '1.00', threshold: {10 => 50}
  #   cart = inventory.new_cart
  #   cart.add 'Earl Grey', 15
      
  #   assert_equal '12.50'.to_d, cart.total
  # end

  # def test_cart_invoice_with_promotions
  #   inventory = Inventory.new

  #   inventory.register 'Green Tea',      '2.79', get_one_free: 2
  #   inventory.register 'Black Coffee',   '2.99', package: {2 => 20}
  #   inventory.register 'Milk',           '1.79', threshold: {3 => 30}
  #   inventory.register 'Cereal',         '2.49'
  #   cart = inventory.new_cart
  #   cart.add 'Green Tea', 8
  #   cart.add 'Black Coffee', 5
  #   cart.add 'Milk', 5
  #   cart.add 'Cereal', 3
  #   # expected = "+" + "-"*48 + "+" + "-"*10 + "+\n"
  #   # puts "\n"
  #   puts cart.invoice.to_s
 
  #   #assert_equal cart.invoice.to_s
  # end

  # def test_cart_invoice
  #   inventory = Inventory.new

  #   inventory.register 'Green Tea', '1.99'
  #   inventory.register 'Red Tea',   '2.49'
  #   inventory.register 'Earl Grey', '1.49'
  #   cart = inventory.new_cart
  #   cart.add 'Green Tea'
  #   cart.add 'Red Tea', 2
  #   cart.add 'Green Tea', 2
  #   expected = "+" + "-"*48 + "+" + "-"*10 + "+\n"
  #   puts "\n"
  #   puts cart.invoice.to_s
 
  #   assert_equal cart.invoice.to_s
  # end

  def test_promo_coupons_invoice
    inventory = Inventory.new

    inventory.register 'Green Tea',      '2.79', get_one_free: 2
    inventory.register 'Black Coffee',   '2.99', package: {2 => 20}
    inventory.register 'Milk',           '1.79', threshold: {3 => 30}
    inventory.register 'Cereal',         '2.49'
    inventory.register_coupon 'BREAKFAST', percent: 10

    inventory.register_coupon 'FREE', amount: 40
    
    cart = inventory.new_cart
    cart.add 'Green Tea', 8
    cart.add 'Black Coffee', 5
    cart.add 'Milk', 5
    cart.add 'Cereal', 3
    #cart.use 'BREAKFAST'
    cart.use 'FREE'
    puts cart.invoice
  end
end