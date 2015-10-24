# require 'dalli'

# module CacheHelper
# 	def init
# 		config_endpoint = ENV['cache_cfg_endpoint']

# 		# Options for configuring the Dalli::Client
# 		dalli_options = {
# 			:expires_in => 24 * 60 * 60,
# 			:namespace => "smarttools-cache",
# 			:compress => true
# 		}

# 		elasticache = Dalli::ElastiCache.new(config_endpoint, dalli_options)
# 	end
# end