require 'time'

class CTCPPlugin
	include Cinch::Plugin
	match /VERSION/, react_on: :private, method: :replyVersion
	match /TIME/, react_on: :private, method: :replyTime
	match /FINGER/, react_on: :private, method: :replyFinger
	match /SOURCE/, react_on: :private, method: :replySource
	match /PING/, react_on: :private, method: :replyPing
	match /OWNER/, react_on: :private, method: :replyOwner
	match /CLIENTINFO/, react_on: :private, method: :replyClientinfo

	
	def replyVersion(m) 
		User(m.user).notice("\u0001VERSION\u0001ElectroCode Administration Bot / Version #{$version.join(".")}")
	end
	def replyTime(m) 
		User(m.user).notice("\u0001TIME\u0001#{Time.now.strftime("%a %b %d %H:%M:%S %Z %Y")}")
	end
	def replyFinger(m) 
		User(m.user).notice("\u0001FINGER\u0001Ouch! Don't put your finger there!")
	end
	def replySource(m) 
		User(m.user).notice("\u0001SOURCE\u0001Source: https://github.com/ElectroCode/electro")
	end
	def replyOwner(m)
		User(m.user).notice("\u0001OWNER\u0001Owner: ZeeNoodleyGamer / Iota")
	end
	def replyPing(m) 
		User(m.user).notice("\u0001PING\u0001" + m.args.join(" "))
	end
	def replyClientinfo(m) 
		User(m.user).notice("\u0001CLIENTINFO\u0001 VERSION TIME FINGER SOURCE PING CLIENTINFO OWNER")
	end
end