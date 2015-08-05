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
		Channel(channel).join
	end
	def part(m, channel)
		Channel(channel).part
	end
end
