class Category < ActiveRecord::Base
	has_many	:products

	accepts_nested_attributes_for :products
	validates :name, uniqueness: true,presence: true
end
