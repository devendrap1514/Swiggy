def print_message(obj)
  obj.each do |o|
    print o.errors.full_messages
  end
  puts
end



Dish.destroy_all
Category.destroy_all
Owner.destroy_all
Customer.destroy_all
Restaurant.destroy_all
RestaurantDish.destroy_all

# Create Category
categories = []
(1..20).each do |i|
  category = Category.create(category_name: Faker::Food.ethnic_category)
  unless category.errors.any?
    categories << category
  end
end
puts("Total category: #{categories.size}")



# require 'open-uri'

# Create Dishes
dishes = []
(1..50).each do |i|
  dish = Dish.create(category: categories.sample, dish_name: Faker::Food.dish)
  unless dish.errors.any?
    byebug if i == 0
    if i%3 == 0
      url = Faker::LoremFlickr.image(size: "200x200", search_terms: ['food', "#{dish.dish_name}"])
      trim_url = ""
      url.each_char do |ch|
        break if ch == " "
        trim_url << ch
      end
      begin
        file = URI.parse(trim_url)
        image = file.open
        puts(image)
        dish.dish_images.attach(io:  image, filename: 'photo.jpg' )
      rescue StandardError => e

      end
    end

    dishes << dish
  end
end
puts("Total dishes: #{dishes.size}")


# dish = Dish.create(dish_name: 'Kaju', category_id: category_indian.id)
# dish.dish_images.attach(
#   io:  File.open(File.join(Rails.root,'app/assets/images/kaju1.jpeg')),
#   filename: 'photo.jpeg'
# )





# Create Owner
owners = []
owners << Owner.create(name: 'Vinay Sharma', username: 'vs_123', password: 'Dev123', password_confirmation: 'Dev123', email: 'unknownwalahai@gmail.com')
(1..2).each do |i|
  username = Faker::Internet.username(separators: ['_'])
  password = "Dev123"

  owner = Owner.create(name: Faker.name, username: username, email: "unknownwalahai@gmail.com", password: password, password_confirmation: password)
  unless owner.errors.any?
    owners << owner
  end
end
puts("Total owner: #{owners.size}")




# Create Customer
customers = []
customers << Customer.create(name: 'Devendra Patidar', username: 'dp_123', password: 'Dev123', password_confirmation: 'Dev123', email: 'unknownwalahai@gmail.com')
(1..2).each do |i|
  username = Faker::Internet.username(separators: ['_'])
  password = "Dev123"

  customer = Customer.create(name: Faker.name, username: username, email: "unknownwalahai@gmail.com", password: password, password_confirmation: password)
  unless customer.errors.any?
    customers << customer
  end
end
puts("Total customers: #{customers.size}")




restaurants = []
(1..50).each do |i|
  restaurant = Restaurant.create(restaurant_name: Faker::Restaurant.name, address: Faker::Address.street_name, owner: owners.sample, status: ['open', 'close'].sample)
  unless restaurant.errors.any?
    restaurants << restaurant
  end
end
puts("Total restaurants: #{restaurants.size}")




# Create Restaurant Dishes
restaurant_dishes = []
(1..50).each do |i|
  restaurant_dish = RestaurantDish.create(restaurant: restaurants.sample, dish: dishes.sample, price: Faker::Commerce.price(range: 20..200))
  unless restaurant_dish.errors.any?
    restaurant_dishes << restaurant_dish
  end
end
puts("Total restaurant dishes: #{restaurant_dishes.size}")




AdminUser.destroy_all
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

puts
