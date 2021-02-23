class OrderItemsController < ApplicationController
  before_action :load_order, only: [:create, :show]

  def show
  end

  def create
    @order_item = @order.order_items.find_or_initialize_by(item_id: params[:item_id])

    if @order_item.save
      redirect_to order_path(@order_item.order)
    end
  end

  private

    def load_order
      @order = Order.find_or_initialize_by(id: session[:order_id])

      if @order.new_record?
        @order.save!
        session[:order_id] = @order.id
      end
    end
end
