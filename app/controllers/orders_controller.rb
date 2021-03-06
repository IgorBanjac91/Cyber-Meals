class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :index]
  before_action :order_again?, only: [:update]
  before_action :check_ownership, only: [:edit, :show]
  before_action :find_suggested, only: [:show]
  before_action :find_pupular, only: [:show]

  def index
    @orders = Order.search(params)
  end

  def edit
  end

  def show
    @order = Order.find(params[:id])
    @last_order_completed = Order.where(status: "completed", user: current_user).order(created_at: :desc).first
  end

  def update 
    @order = Order.find(params[:id])
    time_preparation = @order.time_preparation
    if params[:commit] = "Submit Order"
      @order.update(status: "ordered", preparation_time: time_preparation)
      session[:order_id] = nil
      redirect_to order_path(@order)
    else
      flash[:alert] = "Unpermittted action"
      redirect_to root_path
    end
  end

  def change_status
    @order = Order.find(params[:id])
    @order.update_attribute(:status, params[:status])
    redirect_to dashboard_path
  end
  
  protected
  
  def check_ownership
    @order = Order.find(params[:id])
    if @order.user 
      if @order.user != current_user
        redirect_to root_path
      end
    end
  end

  def order_again? 
    @order = Order.find(params[:id])
    if params[:last_order_id]
      last_order = Order.find(params[:last_order_id])
      @order.order_items.delete_all
      last_order.order_items.each do |order_item|
        @order.order_items << order_item.dup
      end
      redirect_to order_path(@order)
    end
  end

  # finds two most common items taken with each item adde to the order

  def find_suggested 
    @suggested_items = []
    load_order
    @order.ordered_items.each do |item|
      orders_ids = item.order_ids
      items = Item.joins(:order_items).where(order_items: {order_id: orders_ids } ).where.not(title: item.title)
      titles = items.group(:title).count.sort_by { |k, v| -v }
      @suggested_items << Item.with_title([titles[0][0], titles[1][0]])
    end
    @suggested_items = @suggested_items.flatten.uniq
  end

  def find_pupular
    if OrderItem.any?
      group = OrderItem.group(:item_id).count.sort_by { |k, v| -v }
      itme_ids = [group[0][0], group[1][0], group[2][0]]
      @popular_items = Item.find(itme_ids)
    end
  end
end
