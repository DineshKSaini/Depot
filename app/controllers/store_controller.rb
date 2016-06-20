class StoreController < ApplicationController
	skip_before_filter :authorize
  def index
  	#binding.pry
    @products = Product.order(:title)
    @cart = current_cart

  end

end
