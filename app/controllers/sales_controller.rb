class SalesController < ApplicationController

  def show
    @sale = Sale.find(params[:id])
    @items = @sale.items
    @categories = @sale.categories
  end

  def index 
    @sales = Sale.all
  end

  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(sale_params)
    if @sale.save
      flash[:notice] = "New sale created"
      redirect_to sale_path(@sale)
    else
      render :new
    end
  end

  def destroy
    @sale = Sale.find(params[:id])
    @sale.delete
    redirect_to sales_path
  end


  protected

    def sale_params
      params.require(:sale).permit(:title, :discount, category_ids: [], item_ids: [])
    end
end
