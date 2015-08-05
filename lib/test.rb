####
#
#  ElectroCode Channel Welcomer and AutoAssigner
#
####

class TestPlugin
	include Cinch::Plugin
	listen_to :channel, method: :doRegister
	match /join (.*)/, method: :join
	match /part (.*)/, method: :part

	def check_privledges(user)
		if Channel("#debug").opped?(user) or Channel("#Situation_Room").opped?(user)
			return true
		else
			return false
		end
	end
  
	def doRegister(m)
		if m.channel.name == "#debug"
			Channel("#Situation_Room").send("YOU DUN FUCKED UP")
		end
	end
	
	def join(m, channel)
		bot.join(channel)
	end
	def part(m, channel)
		bot.join(channel)
	end
end
