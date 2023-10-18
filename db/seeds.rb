def p_e(*obj)
  obj.each do |o|
    p o.errors.full_messages
  end
end

# Create Category
Dish.destroy_all
Category.destroy_all
category_chinese = Category.create(category_name: 'Chinese')
category_indian = Category.create(category_name: 'Indian')
category_mexican = Category.create(category_name: 'Mexican')
p_e category_chinese, category_indian, category_mexican

# Create Dishes
dish1 = Dish.create(dish_name: 'Manchurian', category_id: category_chinese.id)
dish2 = Dish.create(dish_name: 'Noodles', category_id: category_chinese.id)
dish3 = Dish.create(dish_name: 'Paneer', category_id: category_indian.id)
dish4 = Dish.create(dish_name: 'Dal', category_id: category_indian.id)
p_e dish1, dish2, dish3, dish4

# Create Owner
Owner.destroy_all
owner1 = Owner.create(name: 'Vinay Sharma', username: 'vs_123', password: 'Vinay123',
                      password_confirmation: 'Vinay123', email: 'unknownwalahai@gmail.com')
owner2 = Owner.create(name: 'Akash Chadda', username: 'ac_123', password: 'Akash123',
                      password_confirmation: 'Akash123', email: 'unknownwalahai@gmail.com')
p_e(owner1, owner2)

# Create Customer
Customer.destroy_all
customer1 = Customer.create(name: 'Devendra Patidar', username: 'dp_123', password: 'Devendra123',
                            password_confirmation: 'Devendra123', email: 'unknownwalahai@gmail.com')
customer2 = Customer.create(name: 'Pradeep Patidar', username: 'pp_123', password: 'Devendra123',
                            password_confirmation: 'Devendra123', email: 'unknownwalahai@gmail.com')
p_e(customer1, customer2)

# Create Restaurant
Restaurant.destroy_all
restaurant1 = Restaurant.create(restaurant_name: 'Apna Sweet', address: 'Vijay Nager', owner_id: owner1.id,
                                status: 'open')
restaurant2 = Restaurant.create(restaurant_name: 'Guru Kripa', address: 'Sarvate', owner_id: owner1.id, status: 'close')
restaurant3 = Restaurant.create(restaurant_name: 'Sayaji', address: 'Meghdoot', owner_id: owner2.id, status: 'open')
restaurant4 = Restaurant.create(restaurant_name: 'Maa ki Rasoi', address: 'Palasia', owner_id: owner2.id, status: 'open')
restaurant5 = Restaurant.create(restaurant_name: 'Apna Sweet', address: 'Sapna Sangeeta', owner_id: owner1.id,
                                status: 'open')
restaurant6 = Restaurant.create(restaurant_name: 'Guru Kripa', address: 'Palasia', owner_id: owner1.id, status: 'close')
p_e restaurant1, restaurant2, restaurant3, restaurant4, restaurant5, restaurant6

# Create Restaurant Dishes
RestaurantDish.destroy_all
rd1 = RestaurantDish.create(restaurant_id: restaurant1.id, dish_id: dish1.id, price: 40)
rd2 = RestaurantDish.create(restaurant_id: restaurant1.id, dish_id: dish2.id, price: 20)
rd3 = RestaurantDish.create(restaurant_id: restaurant3.id, dish_id: dish3.id, price: 120)
rd4 = RestaurantDish.create(restaurant_id: restaurant3.id, dish_id: dish4.id, price: 70)
p_e rd1, rd2, rd3, rd4

AdminUser.destroy_all
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
