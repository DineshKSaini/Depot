class ApplicationController < ActionController::Base
  protect_from_forgery
  #before_action :authenticate_login!
  before_filter :authenticate_user!
  #before_filter :is_user_admin
    #require 'cancan'
  rescue_from CanCan::AccessDenied do |exception|
  #flash[:error] = "Access denied."
  redirect_to '/'
  end

  def is_user_admin
    if current_user.present? && !current_user.role?(:admin) 
     redirect_to '/'
   end
  end

  def is_user_customer?
    current_user.present? && current_user.role?(:customer) ? true : false
  end

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
  # protected

  #   def configure_permitted_parameters
  #       devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name,:last_name, :email, :password) }
  #       #devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :is_female, :date_of_birth) }
  #   end
end

