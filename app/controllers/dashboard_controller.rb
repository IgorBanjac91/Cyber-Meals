class DashboardController < ApplicationController

  def index
    if params[:status].present?
      @orders = Order.where(status: params[:status] )
    else
      @orders = Order.all
    end
  end

  def show
    @order = Order.find(params[:id])
  end
end
