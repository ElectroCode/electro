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
		User(m.user).notice("VERSION ElectroCode Administration Bot / Version #{$version.join(".")}")
	end
	def replyTime(m) 
		User(m.user).notice("TIME #{Time.now.strftime("%a %b %d %H:%M:%S %Z %Y")}")
	end
	def replyFinger(m) 
		User(m.user).notice("FINGER Ouch! Don't put your finger there!")
	end
	def replySource(m) 
		User(m.user).notice("SOURCE Source: https://github.com/ElectroCode/electro")
	end
	def replyOwner(m)
		User(m.user).notice("OWNER Owner: ZeeNoodleyGamer / Iota")
	def replyPing(m) 
		User(m.user).notice("PING" m.args.join(" ") )
	end
	def replyClientinfo(m) 
		User(m.user).notice("CLIENTINFO VERSION TIME FINGER SOURCE PING CLIENTINFO OWNER")
	end
end