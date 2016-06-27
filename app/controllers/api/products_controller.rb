class Api::ProductsController < ProductsController
skip_before_filter :authenticate_user! ,only: [:product_details,:update,:destroy]

  def product_details
  	product = Product.find(params[:id])
    binding.pry
  	
  	render :json => product, :status => :ok
  	
  end

end