class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :index]
  before_action :check_ownership, only: [:edit, :show]

  def index
    if params[:status].present?
      if params[:status] == "all"
        @orders = Order.all
      else
        @orders = Order.where(user_id: current_user.id, status: params[:status]) 
      end
    else
      @orders = current_user.orders
    end
  end

  def edit
  end

  def show
    @order = Order.find(params[:id])
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

end
