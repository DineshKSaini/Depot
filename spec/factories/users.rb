FactoryGirl.define do
 
	factory :user, class: User do
		first_name 'Dinesh'
		last_name 'Saini'
		email 'dsaini11@gmail.com'
		password "12345678"
		password_confirmation "12345678"
		# after :create do |user|
	 #      user_role = Role.find_by_name("customer")
	      
	 #      if user_role.present?
	 #        user.roles << user_role
	 #      else
	 #        user.roles << FactoryGirl.create(:role_customer)
	 #      end
		# end	
	end	

	# factory :admin, class: User do 
	# 	sequence(:name) { |n| "Admin #{n}" }
	# 	sequence(:email) { |n| "admin_#{n}@example.com" }
	# 	password "123456"
	# 	password_confirmation "123456"
	# 	subscribed "1"

	# 	after :create do |r|
 #      if Role.find_by_name('traveller').present?
 #        r.roles.delete(Role.find_by_name('traveller'))
 #      end
 #    	admin_role = Role.find_by_name("admin")
 #      if admin_role.present?
 #        r.roles << admin_role
 #      else
 #        r.roles << FactoryGirl.create(:role_admin)
 #      end
 #  	end
	# end
end