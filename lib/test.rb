####
#
#  ElectroCode Channel Welcomer and AutoAssigner
#
####

class TestPlugin
	include Cinch::Plugin
	match /(\S+).* REGISTER: (\S+)/, use_prefix: false, method: :doRegister
	match /join (.*)/, method: :join
	match /part (.*)/, method: :part

	def check_privledges(user)
		if Channel("#debug").opped?(user) or Channel("#Situation_Room").opped?(user)
			return true
		else
			return false
		end
	end
  
	def doRegister(m, nick, channel)
		if m.channel.name == "#debug"
			default_bot = $config["bot"]["default-bot"]
			User("OperServ").send("OVERRIDE #{nick} BotServ ASSIGN #{channel} #{default_bot}")
			Channel(channel).send("Welcome to ElectroCode #{nick}")
			Channel(channel).send("Please enjoy your stay!")
			Channel("#Situation_Room").send("03[REGISTER] #{nick} => #{channel}")
		end
	end
	
	def join(m, channel)
		if check_privledges(m.user)
			bot.join(channel)
		end
	end
	def part(m, channel)
		if check_privledges(m.user)
			bot.part(channel)
		end
	end
end
