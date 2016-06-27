require 'rails_helper'
RSpec.describe ProductsController, :type => :controller do
	describe "Product operation" do
		it "product creation" do
		old_count = Product.count
		@user = FactoryGirl.create(:user)
		@request.env["devise.mapping"] = Devise.mappings[:users]
		#@user.confirm!
      	sign_in @user
      	image =File.open("/home/travel/Pictures/41jTo2dSLbL._SX425_.jpg")
      	 FactoryGirl.create(:product ,:photo => image)
      	 expect(Product.count).to eq(old_count + 1)
		end
	end
end