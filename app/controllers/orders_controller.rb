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
      if params[:user_id].to_i == current_user.id        
        pp params[:user_id]
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
