####
#
#  ElectroCode Channel Welcomer and AutoAssigner
#
####

class WelcomePlugin
	include Cinch::Plugin
	listen_to :CHANNEL, method: :doWelcome 
	
	def doWelcome(m)
		if m.channel == "#debug"
			if m
				puts m 
				Channel("#Situation_Room").send("A channel #{channel} was registered by #{nick}")
			end
		end
	end
end
