class DashboardController < ApplicationController

  def items 
    @items = Item.all.includes(:categories)
  end

  def index
    @orders = Order.filter(params)
    @status_names = (Order.distinct.pluck(:status) - ["new"]).map { |status| [status.capitalize, status] }
    @statuses = Order.select(:status).distinct.where.not(status: "new")
  end

  def show
    @order = Order.find(params[:id])
  end
end
