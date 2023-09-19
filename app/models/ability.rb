class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new  # Guest user

    can [:create, :login, :forgot_password, :reset_password], User

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
    can :read, [Dish, Category, Restaurant, RestaurantDish]
    can :restaurant_dishes, [Restaurant]
  end
end
