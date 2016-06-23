class AdminController < ApplicationController
  #load_and_authorize_resource
  #before_filter(:only => [:index]) { authorize! if cannot? :read, :admin }
  before_filter :is_user_admin

  def index
  	@total_orders = Order.count
  	@roles = Role.all
  	@users = User.all
  end

  def assign_role
  	User.find(params[:user_id]).roles << Role.find(params[:role_id])
  	redirect_to {admin_url , notice = "assigned successfully"}
    #  format.json { render json: @product }

  end

end
