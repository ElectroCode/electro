####
#
#  ElectroCode Channel Welcomer and AutoAssigner
#
####

class WelcomePlugin
	include Cinch::Plugin
	match /(.*)/, react_to: :PRIVMSG, method: :doWelcome 
	
	def doWelcome(m,bleh)
		if m.channel == "#debug"
			Channel("#Situation_Room").send("A message was sent to #debug")
		end
	end
end
