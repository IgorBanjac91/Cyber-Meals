class ApplicationController < ActionController::Base

  def load_order
    @order = Order.find_or_initialize_by(id: session[:order_id])
  
    if @order.new_record?
      @order.save!
      session[:order_id] = @order.id
    end
  end
end
