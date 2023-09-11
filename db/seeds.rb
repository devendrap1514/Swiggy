def p_e(*obj)
  obj.each do |o|
    p o.errors.full_messages
  end
end

Owner.destroy_all
owner1 = Owner.create(name: "Vinay Sharma",username: "vs_123",password: "Vinay123",password_confirmation: "Vinay123")
owner2 = Owner.create(name: "Akash Chadda",username: "ac_123",password: "Akash123",password_confirmation: "Akash123")
p_e(owner1, owner2)


Customer.destroy_all
customer1 = Customer.create(name: "Devendra Patidar",username: "dp_123",password: "Devendra123",password_confirmation: "Devendra123")
customer2 = Customer.create(name: "Pradeep Patidar",username: "pp_123",password: "Devendra123",password_confirmation: "Devendra123")
p_e(customer1, customer2)

Restaurant.destroy_all
restaurant1 = Restaurant.create(restaurant_name: "Apna Sweet", address: "Vijay Nager", user_id: owner1.id, status: 'open')
restaurant2 = Restaurant.create(restaurant_name: "Guru Kripa", address: "Sarvate", user_id: owner1.id, status: 'close')
restaurant3 = Restaurant.create(restaurant_name: "Sayaji", address: "Meghdoot", user_id: owner2.id, status: 'open')
restaurant4 = Restaurant.create(restaurant_name: "Maa ki Rasoi", address: "Palasia", user_id: owner2.id, status: 'open')
p_e restaurant1, restaurant2


Dish.destroy_all
Category.destroy_all
category_chinese = Category.create(category_name: "Chinese")
category_indian = Category.create(category_name: "Indian")
category_mexican = Category.create(category_name: "Mexican")
p_e category_chinese, category_indian, category_mexican


dish1 = Dish.create(dish_name: "Manchurian", category_id: category_chinese.id)
dish2 = Dish.create(dish_name: "Noodles", category_id: category_chinese.id)
dish3 = Dish.create(dish_name: "Paneer", category_id: category_indian.id)
dish4 = Dish.create(dish_name: "Dal", category_id: category_indian.id)
p_e dish1, dish2, dish3, dish4


RestaurantDish.destroy_all
rd1 = RestaurantDish.create(restaurant_id: restaurant1.id, dish_id: dish1.id, price: 40)
rd2 = RestaurantDish.create(restaurant_id: restaurant1.id, dish_id: dish2.id, price: 20)
rd3 = RestaurantDish.create(restaurant_id: restaurant2.id, dish_id: dish3.id, price: 120)
rd4 = RestaurantDish.create(restaurant_id: restaurant2.id, dish_id: dish4.id, price: 70)
p_e rd1, rd2, rd3, rd4


ItemStatus.destroy_all
is1 = customer1.cart.item_statuses.create(restaurant_dish_id: rd1.id, quantity: 1)
is2 = customer1.cart.item_statuses.create(restaurant_dish_id: rd2.id, quantity: 1)



