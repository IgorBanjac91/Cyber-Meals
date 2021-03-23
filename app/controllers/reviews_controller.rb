class ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)
    if @review.save
      flash[:notice] = "Review Successfully created"
      redirect_to @review.item
    else
      redirect_to root_path
    end
  end

  protected

    def review_params
      params.require(:review).permit(:title, :body, :rating, :user_id, :item_id)
    end
end
