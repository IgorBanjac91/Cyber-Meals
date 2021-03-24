class ReviewsController < ApplicationController
  before_action :authenticate_user!


  def create
    @review = Review.new(review_params)
    if @review.save
      flash[:notice] = "Review Successfully created"
      redirect_to @review.item
    else
      redirect_to root_path
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    @review.update(review_params)
    redirect_to @review.item
  end

  protected

    def review_params
      params.require(:review).permit(:title, :body, :rating, :user_id, :item_id)
    end
end
