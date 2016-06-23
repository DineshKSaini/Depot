class Role < ActiveRecord::Base
	has_many :roleusers
	has_many :users, :through => :roleusers
	
	def getrole
		@roles = Role.all
		return @roles
	end

end
