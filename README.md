# ShoppingCart

[![Build Status](https://travis-ci.org/acseler/shopping_cart.svg?branch=master)](https://travis-ci.org/acseler/shopping_cart)
[![Code Climate](https://codeclimate.com/github/acseler/shopping_cart/badges/gpa.svg)](https://codeclimate.com/github/acseler/shopping_cart)
[![Test Coverage](https://codeclimate.com/github/acseler/shopping_cart/badges/coverage.svg)](https://codeclimate.com/github/acseler/shopping_cart/coverage)

### Integration
Add `= stylesheet_link_tag 'shopping_cart/application'` and `= yield :checkout` to your `layouts/application.html`.
Add to your `layouts/application.html` to display messages
```ruby
- flash.each do |message_type, message|
  .alert{ class: "alert-#{message_type}" }
    - if message.respond_to? :each
      = message.join(', ')
    - else
      = message
```
Add
```ruby
mount ShoppingCart::Engine => '/cart'
```
to your `config/routes.rb`.

Copy migrations to your application
```ruby
rake shopping_cart:install:migrations
rake db:migrate
```

Use `shopping_cart` prefix before all shopping_cart paths
```ruby
  = link_to
```

Add `assign_order` method to your ApplicationController
```ruby
class ApplicationController < ActionController::Base
  assign_order
end
```
It assigns global order for your application and shopping_cart.

Add `acts_as_product` method to your product model, to specify it.
```ruby
class Car < ActiveRecord::Base
  acts_as_product
end

class Sword < ActiveRecord::Base
  acts_as_product
end
```

Add `acts_as_customer` method to your user model.
```ruby
class User < ActiveRecord::Base
  acts_as_customer
end
```
It adds `orders_in_progress`, `orders_in_queue`, `orders_in_delivery`, `orders_delivered` method to user model.

You have to seed `ShoppingCart::County`, `ShoppingCart::Delivery`
 and `ShoppingCart::Coupon` tables
```ruby
[
    {company: 'New post', option: 'Ground', price: 1.5},
    {company: 'FeedEx', option: 'Two Day', price: 3},
    {company: 'DSL', option: 'One Day', price: 5}
].each do |delivery|
    ShoppingCart::Delivery.create(delivery)
end

Coupon.create(per_cent: 5, code: 'qwerty')

COUNTRIES ||= ['Botswana', 'Congo']
COUNTRIES.each do |country|
  Country.create(name: country)
end
```

### Views

If you want to edit views, just copy them with command
```ruby
rails generate shopping_cart:cart_views
```
It will generate all views to `app/views/shopping_cart/order_items` and `app/views/shopping_cart/orders` folders.
Also it generates `app/helpers/shopping_cart/customers_helper.rb` and all presenters in `app/presenters/shopping_cart`.

### Controllers
If you want to redefine controller's actions, you just need to copy them
```ruby
rails generate shopping_cart:cart_controllers
```
It will generate `app/controllers/shopping_cart/order_items_controller.rb`, `app/controllers/shopping_cart/orders_controller.rb`, all commands(Rectify gem) in `app/commands/shopping_cart` and all forms(Rectify gem) in `app/forms/shopping_cart`.

