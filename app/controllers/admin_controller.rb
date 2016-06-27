class AdminController < ApplicationController
  #load_and_authorize_resource
  #before_filter(:only => [:index]) { authorize! if cannot? :read, :admin }
  before_filter :is_user_admin 

  def index
    if !params[:searchuser].blank?
      #binding.pry
      @users = User.find(:all, :conditions => ['first_name LIKE ?', "%#{params[:searchuser]}%"])
      respond_to do |format|
        #format.html # index.html.erb
        format.js{}
        format.json { render json: @users.to_json }
      end
    else
  	@total_orders = Order.count
    @roles = Role.all
    end
  	
  	#@users = User.all
  end

  def assign_role
    #binding.pry
  	User.find(params[:userid]).roles << Role.find(params[:role_id])
    flash[:notice] = 'assigned successfully'
  	redirect_to {admin_url }
    #  format.json { render json: @product }

  end

end
