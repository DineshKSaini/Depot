$redis = Redis.new(:host => 'localhost', :port => 6379)
#$redis = Redis::Namespace.new("my_app", :redis => Redis.new)