require 'open-uri'
require 'rake'
namespace :User do

	task :firstname => :environment do
		#user = User.find(:first , :order => 'RAND()')
	puts "User name: #{pick(User).first_name}"
	end

	task :lastname => :environment do
		#user = User.find(:first , :order => 'RAND()')
	puts "User name: #{pick(User).last_name}"
	end
	desc "Display User Fisrt and Last name"
	task :all => [:firstname , :lastname] do
	end

	def pick(model_class)
    model_class.find(:first, :order => 'RAND()')
  end
end

namespace :Product do
	task :create => :environment do
		image = File.open("/home/travel/Pictures/Screenshot from 2016-06-08 16:11:41.png")
		Product.create( title:'Rake' , description: 'Insert product using rake task' ,price: '1' ,photo: image )
	end

	task :update,[:pro_id] => :environment do |t, args|
		@product = Product.find(args[:pro_id])
		@product.update_attributes( title:'Rake1' , description: 'Insert product using rake task')
		
	end

	task :delete,[:pro_id] => :environment do |t, args|
		binding.pry
		@product = Product.find(args[:pro_id])
		@product.destroy
	end
end

task :my_task, [:arg1, :arg2] do |t, args|
  puts "Args were: #{args}"
end