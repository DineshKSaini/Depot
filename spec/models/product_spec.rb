require 'rails_helper'
RSpec.describe Product, :type => :model do
	describe 'Product operation' do
		it "create Product " do
		old_count = Product.count
		#@user = FactoryGirl.create(:user)
		#@request.env["devise.mapping"] = Devise.mappings[:users]
		#@user.confirm!
      	#sign_in @user

      	image =File.open("/home/travel/Pictures/41jTo2dSLbL._SX425_.jpg")
      	#binding.pry
      	 FactoryGirl.create(:products , :photo => image)
      	 binding.pry

      	 expect(Product.count).to eq(old_count + 1)
      	end

      	 it "Delete Product " do
      	 old_count = Product.count
      	 #binding.pry
      	 #FactoryGirl.create(:products , :photo => image)
      	 product =Product.find(1)
      	 product.destroy
      	 expect(Product.count).to eq(old_count - 1)
      	end

	end


end
