class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :index]
  before_action :order_again?, only: [:update]
  before_action :check_ownership, only: [:edit, :show]

  def index
    if params[:status].present?
      if params[:status] == "all"
        @orders = Order.where(user: current_user)
      else
        @orders = Order.where(user_id: current_user.id, status: params[:status]) 
      end
    else
      if params[:user_id].to_i == current_user.id        
        @orders = Order.where(user_id: params[:user_id])
      else
        redirect_to root_path
      end
    end
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

end
