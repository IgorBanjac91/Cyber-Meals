module ApplicationHelper

  def current_order
    Order.find_or_create_by(id: session[:order_id])
  end

end
