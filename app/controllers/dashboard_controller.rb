class DashboardController < ApplicationController

  def index
    if params[:status].present?
      pp "come on"
      @orders = Order.where(status: params[:status] )
    else
      @orders = Order.all
    end
  end

  def show
  end
end
