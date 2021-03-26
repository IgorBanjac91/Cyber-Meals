module OrdersHelper

  def current_order
    if Order.exists?(session[:order_id])
      return Order.find(session[:order_id])
    else
      return Order.create(user: current_user, status: "new")
    end
  end
end