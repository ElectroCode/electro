require 'time'

class CTCPPlugin
	include Cinch::Plugin
	
	ctcp :version
    ctcp :time
	ctcp :finger
    ctcp :ping
	ctcp :owner
    ctcp :source
    ctcp :clientinfo
    def ctcp_version(m)
		m.ctcp_reply "ElectroCode Administration Bot / Version #{$version.join(".")}" if reply_to_ctcp?(:version)
	end

	def ctcp_time(m)
		m.ctcp_reply Time.now.strftime("%a %b %d %H:%M:%S %Z %Y") if reply_to_ctcp?(:time)
	end
	def ctcp_finger(m)
		m.ctcp_reply "Ouch! Don't put your finger there!" if reply_to_ctcp?(:finger)
	end
	def ctcp_ping(m)
		m.ctcp_reply m.ctcp_args.join(" ") if reply_to_ctcp?(:ping)
	end
    def ctcp_source(m)
	m.ctcp_reply "https://github.com/ElectroCode/electro" if reply_to_ctcp?(:source)
	end
	def ctcp_clientinfo(m)
		m.ctcp_reply "VERSION TIME FINGER SOURCE PING CLIENTINFO OWNER" if reply_to_ctcp?(:clientinfo)
	end
	def reply_to_ctcp?(command)
		commands = config[:commands]
		commands.nil? || commands.include?(command)
	end
end