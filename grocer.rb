require 'pp'
require 'pry'

def find_item_by_name_in_collection(name, collection) 
 i = 0 
 while i < collection.length do 
  if collection[i][:item] == name 
  return collection[i]
end
  i += 1 
end
nil 
end 


 


  
  # Implement me first!
  #
  # Consult README for inputs and outputs



def consolidate_cart(cart)
  new_cart = []
  counter = 0 
  while counter < cart.length do 
    new_cart_item = find_item_by_name_in_collection(cart[counter][:item], new_cart) #returns item if it finds it, and if it doesn't find it will return nil
    if new_cart_item != nil #if this variable has a truthy value,
    new_cart_item[:count] += 1 
  else #if that new cart item is nil, create our item. in hash construct item for the new cart
    new_cart_item = {
      :item => cart[counter][:item],
      :price => cart[counter][:price], 
      :clearance => cart[counter][:clearance],
      :count => 1 #here we are going over item's name price and clearance value and adding a count key value pair and setting that equal to one.
    }
    new_cart << new_cart_item
end 
counter += 1 
end
new_cart 
end

def apply_coupons(cart, coupons) #takes in a cart and our coupons and needs to create a new cart with all the coupons in it. #have to loop through all of the coupons. loop through each of coupons to see if they apply to items in our cart. 
counter = 0 
while counter < coupons.length do 
cart_item = find_item_by_name_in_collection(coupons[counter][:item] , cart ) #returns name of item on coupon and sees if it exists in our cart
#setting it equal to the result of the find_item_by_name_in_collection method
couponed_item_name = "#{coupons[counter][:item]} W/COUPON" #setting up variable. interpolating item name into a string with coupon.
cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart) #want to check if item with coupon above already exists in our cart. will either be an item name w/ coupon or nil.
if cart_item && cart_item[:count] >= coupons[counter][:num]#seeing if item is in the cart and if there is enough of that item in cart for coupon to apply. sees if count is greater than or equal to the number of that item on the coupon we're looking at right now.
if cart_item_with_coupon
  cart_item_with_coupon[:count] += coupons[counter][:num] #if cart item with coupon exists we take that count and increase it by the number of items on our coupon
  cart_item[:count] -= coupons[counter][:num]#if we apply a coupon to an item in our cart, we need to also make sure we subtract the count that that coupon applied to from that item in our cart... ask a question on this one?? what is this subtract line doing exactly and why do we need it? count of items in  cart - and equal to the count of items that coupon applies to 
else 
  cart_item_with_coupon = {
    :item => couponed_item_name, 
    :price => coupons[counter][:cost] / coupons[counter][:num], #cost of items on coupon divided by number of items that that cost applies to
    :count => coupons[counter][:num],
    :clearance => cart_item[:clearance] #now we have this constructed and we want to add this to our cart below.
  }
  cart << cart_item_with_coupon
  cart_item[:count] -= coupons[counter][:num]
  #also need to subtract our number from our cart item count... but why do we do this exactly??? ask a question about this. 
end
end # so we either increasing the count for the couponed item in our cart or adding the couponed item to our cart if it doesn't exist 
counter += 1 
  end
  cart 
end #will return our original cart if there are no coupons

def apply_clearance(cart) #want to loop through each item in this cart and check if each item is on clearance. if is, want to adjust items price for that item and return cart for all adjusted items.
  counter = 0 
  while counter < cart.length do 
    if cart[counter][:clearance] #if this is true, we want to go into that if statement, and if false we don't want to go into that if statement. 
    cart[counter][:price] = (cart[counter][:price] - (cart[counter][:price] * 0.20)).round(2) #called 2 in the round method to round our number to 2 decimal places. 
  end 
    counter += 1 
end
cart
end 

def checkout(cart, coupons) 
  consolidated_cart = consolidate_cart(cart) #this consolidates our cart
  couponed_cart = apply_coupons(consolidated_cart, coupons) #this takes that consolidated cart and applies the coupons 
  final_cart = apply_clearance(couponed_cart) #this takes that couponed cart and applies our clearance value. 
  
  total = 0 
  counter = 0 
  while counter < final_cart.length do 
   total += final_cart[counter][:price] * final_cart[counter][:count] #adding to our total the price of item in final cart *
  #the count of the item.
  counter += 1 
end 
if total > 100 
  total -= (total * 0.10) #multiply current total by 10% and subtract the result of this from our current total. this is to give the situational 10% discount. also... do you need a 0 in front of typing percentages? I first put .10 and it wanted me to have 0.10 I think?? ask a question on this one too. 
end
total 
end 
