####
#
#  ElectroCode Channel Welcomer and AutoAssigner
#
####

class WelcomePlugin
	include Cinch::Plugin
	match /(\S+) \(.*\) REGISTER\: (.*)$/i, react_on: :channel, use_prefix: false, method: :doWelcome 
	
	def doWelcome(m, nick, channel)
		if m.channel == "#debug"
			Channel("#Situation_Room").send("A channel #{channel} was registered by #{nick}")
		end
	end
end
