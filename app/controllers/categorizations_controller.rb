class CategorizationsController < ApplicationController

  def create

  end

  def destroy
    @categorization = Categorization.find(params[:id])
    @item = @categorization.item
    if @categorization.delete
      redirect_to item_path(@item)
    end
  end
end
