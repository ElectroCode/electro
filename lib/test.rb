####
#
#  ElectroCode Channel Welcomer and AutoAssigner
#
####

class TestPlugin
	include Cinch::Plugin
	match /(\S+) (\S+) REGISTER: (\S+)/, use_prefix: false, method: :doRegister
	match /Channels\s+: ([0-9]+) founder/,use_prefix: false, method: :doCheck
	match /join (.*)/, method: :join
	match /part (.*)/, method: :part
	
	def debuglog(message)
		Channel("#debug").send(message)
	end
	def sitlog(message)
		Channel("#Situation_Room").send(message)
	end
	def check_privledges(user)
		if Channel("#debug").opped?(user) or Channel("#Situation_Room").opped?(user)
			return true
		else
			return false
		end
	end
	def doCheck(m, channum)
		puts channum
		channum.to_i!
		if channum == 0
			new = 1
		end
	end
	def doRegister(m, nick, nick2, channel)
		User("NickServ").send("INFO #{nick}")
		if $new == 1
			nick2 = nick2.tr('()', '')
			channel = channel.tr('', '')
			if m.channel.name == "#debug"
				default_bot = $config["bot"]["default-bot"]
				sitlog("[03REGISTER] #{nick} => #{channel}")
				User("OperServ").send("OVERRIDE #{nick2} BotServ ASSIGN #{channel} #{default_bot}")
				bot.join(channel)
				Channel(channel).send("Welcome to ElectroCode #{nick} (#{nick2}),  Please enjoy your stay!")
				Channel(channel).send("I also assigned you a bot to start off! His name is Bots as you can see.")
				Channel(channel).send("If you need help with him, try going through /cs help")
				Channel(channel).send("If that doesn't work, then join #help and see if one of our users can help you!")
			end
		else
			sitlog("[04NO WELCOME] => #{nick} #{nick2} / var channum > 0")
			debuglog("[04NO WELCOME] => #{nick} #{nick2} / var channum > 0")
		end
	end
	
	def join(m, channel)
		if check_privledges(m.user)
			sitlog("03[JOIN] #{channel} by #{m.user}")
			bot.join(channel)
		end
	end
	def part(m, channel, reason=nil)
		if check_privledges(m.user)
			reason = bot.name if reason = nil
			sitlog("03[JOIN] #{channel} by #{m.user} Reason: #{reason}")
			bot.part(channel)
		end
	end
end
