class ApplicationController < ActionController::Base
  protect_from_forgery
  #before_action :authenticate_login!
  before_filter :authenticate_user!
  #before_filter :authorize

  private
    def current_cart
      begin
        Cart.find(session[:cart_id])
      rescue ActiveRecord::RecordNotFound
        cart = Cart.create
        session[:cart_id] = cart.id
        cart
      end
    end
  protected
    def authorize  
      redirect_to login_url, notice: "Please log in" unless User.find_by_id(session[:user_id])
    end
end

