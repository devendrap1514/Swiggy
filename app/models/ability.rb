class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new  # Guest user

    can [:create, :destroy, :send_mail, :set_password], UserAuthentication
    can [:create], User

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
    can :category_dishes, Category
    can :read, [Dish, Category, Restaurant, RestaurantDish]
    can :restaurant_dishes, [Restaurant]
  end
end
