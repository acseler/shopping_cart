module ApplicationHelper
  def basket_items(order)
    return empty_cart if order.nil?
    not_empty_cart(order)
  end

  def shop_active
    path = request.env['PATH_INFO']
    active_class(path) unless root_or_user_path(path)
  end

  def active_class(path)
    current_page?(path) ? 'active' : ''
  end

  private

  def root_or_user_path(path)
    path == main_app.root_path || path.match(/user/)
  end

  def items(count)
    count == 0 ? t(:empty) : count
  end

  def empty_cart
    "#{t(:cart)}: #{t(:empty)}"
  end

  def not_empty_cart(order)
    item_count = order.order_items.count
    "#{t(:cart)}: (#{items(item_count)})" +
        "#{ order.sub_total unless item_count == 0 }"
  end
end
