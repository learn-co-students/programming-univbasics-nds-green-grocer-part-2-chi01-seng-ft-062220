require_relative './part_1_solution.rb'


def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  coupons.each do |coupon_item|
    cart.each do |cart_item|
      if cart_item[:item] == coupon_item[:item]
        if cart_item[:count] >= coupon_item[:num]
          a = cart.length
          cart_item[:count] -= coupon_item[:num]
          puts a
          cart[a] = {
            :item => cart_item[:item] + " W/COUPON",
            :price => coupon_item[:cost] / coupon_item[:num],
            :clearance => cart_item[:clearance],
            :count => coupon_item[:num]
            }
        end
      end
    end
  end
  cart      
end


def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do |grocery_item|
    if grocery_item[:clearance] == true
       new_price = grocery_item[:price] * 0.80
       grocery_item[:price] = new_price.round(2)
    end
  cart
  end
end


def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
  final_total = 0
  
  consolidated_cart = consolidate_cart(cart)

  pre_clearance_total = apply_coupons(consolidated_cart, coupons)
  
  ready_for_checkout_total = apply_clearance(pre_clearance_total)
  
  ready_for_checkout_total.each do |grocery_item|
    item_total = grocery_item[:price] * grocery_item[:count]
    final_total = final_total + item_total
  end
  
  if final_total > 100.00
    final_total = final_total * 0.90
  end
  final_total
end

