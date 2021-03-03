class ApplicationController < ActionController::Base

  def load_order
    @order = Order.find_or_initialize_by(id: session[:order_id])
  
    if @order.new_record?
      @order.save!
      session[:order_id] = @order.id
    end
  end

  protected

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to sign_in_path
    end
  end
end
