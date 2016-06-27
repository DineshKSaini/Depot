FactoryGirl.define do
  
  factory :role_admin, class: Role do
  	name "admin"
  end

  
  factory :role_customer, class: Role do
    name "customer"
  end
end
