module ApplicationHelper

  def current_order
    Order.find(session[:order_id])
  end
end
