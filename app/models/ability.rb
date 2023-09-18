class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # User, Owner, Customer, Category, Restaurant, Dish, RestaurantDish, Cart, CartItem, Order, OrderItem

    can :read, [Dish, Category, Restaurant, RestaurantDish]
    can :restaurant_dishes, [Restaurant]
    if user.type == 'Owner'
      can :manage, Restaurant
      can :manage, Dish
      can :manage, RestaurantDish
    elsif user.type == 'Customer'
      can :manage, Cart
      can :manage, Order
      can :manage, CartItem
      can :manage, OrderItem
    end

    return unless user.type == 'Owner' or user.type == 'Customer'

    can :manage, [User]
  end
end
