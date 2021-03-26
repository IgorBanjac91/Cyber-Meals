# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  after_action :load_new_order, only: [:create]

  def destroy
    super
    session[:order_id] = nil
  end

  protected

  def load_new_order
    order = Order.find_or_initialize_by(status: "new")
    session[:order_id] = order.id
  end

end
