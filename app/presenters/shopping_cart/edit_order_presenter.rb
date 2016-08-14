module ShoppingCart
  class EditOrderPresenter < Rectify::Presenter
    attribute :order, Order

    def items
      order.order_items
    end

    def sub_total
      order.sub_total
    end

    def has_items
      count > 0
    end

    def count
      items.count
    end

    def coupon?
      order.coupon
    end

    def discount
      "#{order.coupon.per_cent}%"
    end

    def header
      t(:you_have_n_items_in_order, item: count, items: t(:item).pluralize(count))
    end

    def empty_cart_link
      link_to t(:empty_cart),
              delete_order_items_path,
              method: :delete
    end

    def continue_shopping_link
      link_to t(:continue_shopping), main_app.root_path
    end
  end
end