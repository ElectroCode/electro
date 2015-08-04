####
#
#  ElectroCode Channel Welcomer and AutoAssigner
#
####

class WelcomePlugin
	on :PRIVMSG, /(.*)/i, method: :doWelcome 
	
	def doWelcome(m,bleh)
		if m.channel == "#debug"
			Channel("#Situation_Room").send("A message was sent to #debug")
		end
	end
end
