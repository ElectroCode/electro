####
#
#  ElectroCode Channel Welcomer and AutoAssigner
#
####

class WelcomePlugin
	include Cinch::Plugin
	listen_to :channel, method: :doRegister
	match /join (.*)/, method: :join
	match /part (.*)/, method: :part

	def doRegister(m)
		if m.channel.name == "#debug"
			Channel("#Situation_Room").send("YOU DUN FUCKED UP")
		end
	end
	
	def join(m, channel)
		bot.join(channel)
	end
	def leave(m, channel)
		bot.join(channel)
	end
end
