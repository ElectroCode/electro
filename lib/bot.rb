####
#
#  ElectroCode Channel Welcomer and AutoAssigner
#
####

class WelcomePlugin
	include Cinch::Plugin
	
	match /join (\S+)/, method: :join
	match /part (\S+)/, method: :part
	
	def join(m, channel)
		bot.join(channel)
	end
	def leave(m, channel)
		bot.join(channel)
	end
end
