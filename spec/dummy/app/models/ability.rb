class Ability
  include CanCan::Ability

  def initialize(user)
    user ? user_abilities : guest_abilities
  end

  def user_abilities
    guest_abilities
    can :read
    can :manage, ShoppingCart::Order
    can :manage, ShoppingCart::OrderItem
    can :manage, User
  end

  def guest_abilities
    can :read, [Book, Magazine]
  end

end
