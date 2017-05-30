class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
    @product = Product.find_by_friendly_id!(params[:product_id])
    @review = Review.new
    @review_pic = @review.review_pics.build

  end

  def create
    @product = Product.find_by_friendly_id!(params[:product_id])
    @review = Review.new(review_params)
    @review.product = @product
    @review.user = current_user

    if @review.save
      if params[:review_pics] != nil
        params[:review_pics]['avatar'].each do |a|
          @review_pic = @review.review_pics.create(:avatar => a)
        end

      end
      redirect_to product_path(@product)
    else
      render :new

    end

  end

  private

  def review_params
    params.require(:review).permit(:content, :rate)

  end
end
