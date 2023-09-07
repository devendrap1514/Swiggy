Owner.destroy_all
owner = Owner.create(
  name: "Vinay Sharma",
  username: "vs_123",
  password: "Vinay123",
  password_confirmation: "Vinay123"
)
p owner.errors.full_messages


Customer.destroy_all
customer = Customer.create(
  name: "Devendra Patidar",
  username: "dp_123",
  password: "Devendra123",
  password_confirmation: "Devendra123"
)
p customer.errors.full_messages

Restaurant.destroy_all
restaurant1 = Restaurant.create(restaurant_name: "Apna Sweet", address: "Vijay Nager", user_id: owner.id)
restaurant2 = Restaurant.create(restaurant_name: "Guru Kripa", address: "Sarvate", user_id: owner.id)
p restaurant1.errors.full_messages, restaurant2.errors.full_messages


Dish.destroy_all
Category.destroy_all
category_chinese = Category.create(category_name: "Chinese")
category_indian = Category.create(category_name: "Indian")
p category_chinese.errors.full_messages, category_indian.errors.full_messages


dish1 = Dish.create(dish_name: "Manchurian", category_id: category_chinese.id)
dish2 = Dish.create(dish_name: "Noodles", category_id: category_chinese.id)
dish3 = Dish.create(dish_name: "Paneer", category_id: category_indian.id)
dish4 = Dish.create(dish_name: "Dal", category_id: category_indian.id)
p dish1.errors.full_messages, dish2.errors.full_messages, dish3.errors.full_messages, dish4.errors.full_messages


RestaurantDish.destroy_all
rd1 = RestaurantDish.create(restaurant_id: restaurant1.id, dish_id: dish1.id, price: 40)
rd2 = RestaurantDish.create(restaurant_id: restaurant1.id, dish_id: dish2.id, price: 20)
rd3 = RestaurantDish.create(restaurant_id: restaurant2.id, dish_id: dish3.id, price: 120)
rd4 = RestaurantDish.create(restaurant_id: restaurant2.id, dish_id: dish4.id, price: 70)
p rd1.errors.full_messages, rd2.errors.full_messages, rd3.errors.full_messages, rd4.errors.full_messages
