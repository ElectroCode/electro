####
#
#  ElectroCode Channel Welcomer and AutoAssigner
#
####

class WelcomePlugin
	include Cinch::Plugin
	
	match /join (.*)/, method: :join
	match /part (.*)/, method: :part
	
	def join(m, channel)
		bot.join(channel)
	end
	def leave(m, channel)
		bot.join(channel)
	end
end
