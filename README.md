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
mount ShoppingCart::Engine => '/cart', as: 'cart'
```
to your `config/routes.rb`.

Copy migrations to your application
```ruby
rake shopping_cart:install:migrations
rake db:migrate
```

Use `shopping_cart` prefix before all shopping_cart paths
```ruby
  = link_to shopping_cart.orders_path
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

ShoppingCart now has four steps

- Address
- Delivery
- Payment
- Confirm

### Views

If you want to edit views, just copy them with command
```ruby
rails generate shopping_cart:cart_views
```
It will generate all views to `app/views/shopping_cart/order_items` and `app/views/shopping_cart/orders` folders.
Also it generates `app/helpers/shopping_cart/customers_helper.rb`.

### Controllers
If you want to redefine controller's actions, you just need to copy them
```ruby
rails generate shopping_cart:cart_controllers
```
It will generate `app/controllers/shopping_cart/order_items_controller.rb`, `app/controllers/shopping_cart/orders_controller.rb`.

### Forms, Commands and Presenters

ShoppingCart uses Rectify gem to separate business logic from controllers. If you want to change this logic, you have to generate part you need.

#### Forms

For generating `Rectify forms` you need to execute next line

```ruby
rails generate shopping_cart:cart_forms
```

#### Commands

For generating `Rectify commands` you need to execute next line

```ruby
rails generate shopping_cart:cart_commands
```

#### Presenters

For generating `Rectify presenter` you need to execute next line

```ruby
rails generate shopping_cart:cart_presenters
```


### Customizing Steps

##### Create model

If you want to add custom step you have to generate a new model for step

```ruby
rails generate model ShoppingCart::MyStep
```

Generate `ShoppingCart` models 

```ruby
rails generate shopping_cart:cart_models
```

```ruby
rails generate migration AddMyStepReferenceToOrder
```

Add code to migration

```ruby
  def change
    add_reference :shopping_cart_orders, :my_step, index: true
  end
```

Add following code to `ShoppingCart::Order` model
   
```ruby
  belongs_to :my_step, class_name: 'ShoppingCart::MyStep'
```

##### Create controller and routes

Create module for custom step. And define two actions. `my_step_edit` for editing and `my_step` submitting data.
  
```ruby
module ShoppingCart
  module MyStepsController
    def my_step_edit

    end

    def my_step

    end
  end
end
```

Add routes for `MyStepsController`. Add follow code to `config/routes.rb`


```ruby
resources :orders, module: :shopping_cart, only: [] do
    member do
      get 'my_step', action: 'my_step_edit'
      post 'my_step', action: 'my_step'
    end
  end
```

Now you have controller and routes. 

##### Creating views and presenters

Generate `ShoppingCart` views and presenters
 
```ruby
  rails generate shopping_cart:cart_views
  rails generate shopping_cart:cart_presenters
```

To add step you need to add next code to `app/views/shopping_cart/orders/_header.html.haml`

```ruby
  = @presenter.checkout_title(main_app.my_step_order_path, :my_step)
```

Also you have to create `my_step?` method and edit `confirm?` method to `app/presenters/checkout_presenter.rb`.

```ruby
    # Name of methos should be similar to second argument of `checkout_title(main_app.my_step_order_path, :my_step)`
    def my_step?
      order.my_step
    end
    
    def confirm?
      address? && delivery? && payment? && my_step? 
    end
```

Add localization for your step to `config/locales/en.yml`

```ruby
  my_step: 'MY STEP'
```

Now you need to define your controllers. `app/controllers/shopping_cart/orders_controller.rb` contains `order_addresses, delivery, payment` methods. Choose method after which you want to put your step. You need to change the following code. 

```ruby
  Command.call(form) do
    on(:ok) { redirect_to next_step_path }
    on(:invalid) { redirect_to current_step_path }
  end
```
To
```ruby
    Command.call(form) do
      on(:ok) { redirect_to main_app.my_step_order_path }
      on(:invalid) { redirect_to current_step_path }
    end
```

You can find out the steps path after executing `rake routes`

Than you need to create `app/views/shopping_cart/orders/my_step_edit.html.haml`, the name of view must be similar to `my_step_controller.rb` method `my_step_edit`.
You can create your own presenter for your controller. Read `Rectify` documentation about it https://github.com/andypike/rectify

##### Presenter example
Create presenter at `app/presenters/shopping_cart/my_step_presenter.rb`
```ruby
module ShoppingCart
  class MyStepPresenter < Rectify::Presenter
    attribute :order, ShoppingCart::Order
    attribute :my_step, ShoppingCart::MyStep
  end
end
```

Add following code to your `my_step_edit` action in controller. Do not call your presenter `@presenter`, it's reserved by `ShoppingCart::OrdersController`. 
```ruby
module ShoppingCart::MySteps
  def my_step_edit
    my_step = @order.my_step || ShoppingCart::MyStep.new
    @my_step_presenter = ShoppingCart::MyStepPresenter.new(order: @order,
                                                           my_step: my_step)
                             .attach_controller(self)
  end
end
```

##### View example
 
Add following code to `app/views/shopping_cart/orders/my_step_edit.html.haml` to render steps. 
```ruby
     - content_for :checkout do
       = render 'header'
```

Add form for `MyStep` model to `app/views/shopping_cart/orders/my_step_edit.html.haml`. For example model has only `name` column.
Also you have access to `_order_summary.html.haml` template.

```ruby
    %h4= t(:my_step)
    = form_for @my_step_presenter.my_step, { url: main_app.my_step_order_path, method: :post } do |f|
      = f.text_field :name, placeholder: t(:name)
      = render 'order_summary'
      = f.submit t(:save_and_continue)
```
 
##### Forms and commands

Create `app/forms/shopping_cart/my_step_form.rb`
 
```ruby
    module ShoppingCart
      class MyStepForm < Rectify::Form
        attribute :name, String
        attribute :order, ShoppingCart::Order
    
        validates :name, presence: true
      end
    end
```

Create command `app/commands/shopping_cart/my_step_form.rb`.

```ruby
module ShoppingCart
  class AddMyStep < ShoppingCart::BaseCommand
    def name
      :add_my_step
    end

    private

    def add_my_step
      attr = attr_except(:order)
      order.my_step = MyStep.create(attr)
      order.save
    end
  end
end
```

Method `name` must contain symbol of business logic method. Use `attr_except(:attr)` method to exclude odd attributes from form.

Now specify `my_step` action 

```ruby
  def my_step
    form = ShoppingCart::MyStepForm.from_params(params)
    form.order = @order
    ShoppingCart::AddMyStep.call(form) do
      on(:ok) { redirect_to next_step_path }
      on(:invalid) { redirect_to main_app.my_step_order_path }
    end
  end
```

And finally create template `app/views/shopping_cart/orders/_confirm_my_step.html.haml` for your step to render it on confirm page

```ruby
.confirm-inner
  %h4= t(:my_step)
  %p= @confirm_presenter.order.my_step.name
```

In order not to break `Law of Demeter`, create `my_step_name` method in `app/presenters/confirm_presenter.rb`
  
```ruby
    def my_step_name
      order.my_step.name
    end
```  

Now view looks better.

```ruby
.confirm-inner
  %h4= t(:my_step)
  %p= @confirm_presenter.my_step_name
``` 

Add following code to `app/views/shopping_cart/orders/_conform_body.html.html`, between steps you defined.
 
```ruby
  =render 'confirm_my_step'
``` 

Congratulation, now you have your own step in `ShoppingCart` :). 




