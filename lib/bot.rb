####
#
#  ElectroCode Channel Welcomer and AutoAssigner
#
####

class WelcomePlugin
	include Cinch::Plugin
	listen_to :PRIVMSG, use_prefix: false, method: :doWelcome 
	
	def doWelcome(m,bleh)
		if m.channel == "#debug"
			Channel("#Situation_Room").send("A message was sent to #debug")
		end
	end
end
