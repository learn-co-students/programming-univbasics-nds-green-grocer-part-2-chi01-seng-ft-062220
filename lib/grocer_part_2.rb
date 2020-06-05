require 'pry'
require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
 i = 0
  while i < coupons.length do
    couponed_item = find_item_by_name_in_collection(coupons[i][:item],cart)
    item_name = "#{coupons[i][:item]} W/COUPON"
    item_with_coupon = find_item_by_name_in_collection(item_name,cart)
    if couponed_item && couponed_item[:count] >= coupons[i][:num]
      if item_with_coupon
        item_with_coupon[:count] += coupons[i][:num]
        couponed_item[:count] -= coupons[i][:num]
      else
      item_with_coupon = {
        :item => item_name,
        :price => coupons[i][:cost]/coupons[i][:num],
        :clearance => couponed_item[:clearance],
        :count => coupons[i][:num]
      }
      cart << item_with_coupon
      couponed_item[:count] -= coupons[i][:num]
      end
    end
  i +=1
end
cart
end

def apply_clearance(cart)
i=0
  while i < cart.length
    if cart[i][:clearance] == true
      cart[i][:price] *= 0.8
      cart[i][:price].round(2)
    end
    i+=1
  end
  cart
end

def checkout(cart, coupons)
  total = 0
  original_cart = consolidate_cart(cart)
  coupons_applied = apply_coupons(original_cart, coupons)
  clearance_applied = apply_clearance(coupons_applied)
 
  i = 0
    while i<clearance_applied.count do
      total += clearance_applied[i][:price]*clearance_applied[i][:count]
       i +=1
    end
    if total > 100
      total *= 0.9
    end
total.round(2)
end
