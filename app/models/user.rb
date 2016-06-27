class User < ActiveRecord::Base
	after_create :set_role
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name,:last_name,:email, :password, :password_confirmation, :remember_me
  validates :first_name, :last_name, presence: true
  has_many :roleusers
  has_many :roles, :through => :roleusers

  def set_role 
    customer_role = Role.find_by_name('customer')
    self.roles << customer_role
  end

  def role?(*roles)
    @role_names ||= self.roles.select(:name).map(&:name)
    (@role_names & roles.map(&:to_s)).present?
  end
end

# select doctorname 
# from doctor_table as d1
# inner join appointment_table as a1  on  d1.docter_id=a1.doctor_id where patient_id=...

