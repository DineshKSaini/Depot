require 'rails_helper'
RSpec.describe CategoriesController, :type => :controller do
	 #binding.pry 
	describe "create category" do
		old_cat_count = Category.count
		it "check category creation" do
		#cat= FactoryGirl.create(:categories)
		#
		#binding.pry
		@user = FactoryGirl.create(:user)
		@request.env["devise.mapping"] = Devise.mappings[:users]
		#@user.confirm!
      	sign_in @user
		 post :create, :category =>{name: 'hello011'} 
		 expect(Category.count).to eq(old_cat_count + 1)
		# expect {
  #        post :create, {:category => {name: 'hello1'}}
  #      }.to change(Category, :count).by(1)
  		#get :index, :

		 end
	end
end