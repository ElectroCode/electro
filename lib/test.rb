####
#
#  ElectroCode Channel Welcomer and AutoAssigner
#
####

class TestPlugin
	include Cinch::Plugin
	match /(\S+) (\S+) REGISTER: (\S+)/, use_prefix: false, method: :doRegister
	match /Channels\s+: ([0]) founder/,use_prefix: false, method: :doCheck
	match /join (.*)/, method: :join
	match /part (.*)/, method: :part

	def check_privledges(user)
		if Channel("#debug").opped?(user) or Channel("#Situation_Room").opped?(user)
			return true
		else
			return false
		end
	end
	def doCheck(m, channum)
		channum.to_i!
		if channum > 0
			notnew = 1
		end
	end
	def doRegister(m, nick, nick2, channel)
		User("NickServ").send("INFO #{nick}")
		if notnew != 1
			nick2 = nick2.tr('()', '')
			channel = channel.tr('', '')
			if m.channel.name == "#debug"
				default_bot = $config["bot"]["default-bot"]
				Channel("#Situation_Room").send("03[REGISTER] #{nick} => #{channel}")
				User("OperServ").send("OVERRIDE #{nick2} BotServ ASSIGN #{channel} #{default_bot}")
				bot.join(channel)
				Channel(channel).send("Welcome to ElectroCode #{nick} (#{nick2}),  Please enjoy your stay!")
				Channel(channel).send("I also assigned you a bot to start off! His name is Bots as you can see.")
				Channel(channel).send("If you need help with him, try going through /cs help")
				Channel(channel).send("If that doesn't work, then join #help and see if one of our users can help you!")
			end
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
