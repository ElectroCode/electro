####
## bnc.im administration bot
##
## Copyright (c) 2013, 2014 Andrew Northall
##
## MIT License
## See LICENSE file for details.
####


require 'socket'
require 'openssl'
require 'timeout'

class Numeric
  def duration
    secs  = self.to_int
    mins  = secs / 60
    hours = mins / 60
    days  = hours / 24

    if days > 0
      "#{days} day#{'s' unless days == 1} and #{hours % 24} hour#{'s' unless (hours % 24) == 1}"
    elsif hours > 0
      "#{hours} hour#{'s' unless (hours % 24) == 1} and #{mins % 60} minute#{'s' unless (mins % 60) == 1}"
    elsif mins > 0
      "#{mins} minute#{'s' unless (mins % 60) == 1} and #{secs % 60} second#{'s' unless (secs % 60) == 1}"
    elsif secs >= 0
      "#{secs} second#{'s' unless (secs % 60) == 1}"
    end
  end
end

class AdminPlugin
  include Cinch::Plugin
  match "help", method: :help
  
  def help(m)
    return unless command_allowed(m)
    m.reply "#{Format(:bold, "[REQUESTS]")} !unconfirmed | !pending | !reqinfo <id> | !requser <name> | !delete <id> | !reject <id> [reason] | !fverify <id> | !approve <id> <interface> [network name] [irc server] [irc port]"
    m.reply "#{Format(:bold, "[REPORTS]")} !reports | !clear <reportid> [message] | !reportid <id>"
    m.reply "#{Format(:bold, "[USERS]")} ![dis]connect <server> <user> <networK> | !addnet <server> <username> <netname> <addr> <port> | !delnet <server> <username> <netname> | !blocked | ![un]block <server> <user>"
    m.reply "#{Format(:bold, "[MANAGEMENT]")} !net <network> | !cp <server> <command> | !sbroadcast <server> <text> | !broadcast <text> | !kick <user> <reason> | !ban <mask> | !unban <mask> | !topic <topic>"
    m.reply "#{Format(:bold, "[ZNC DATA]")} !find <user regexp> | !findnet <regexp> | !netcount <regexp> | !stats | !update | !data | !offline | !networks [num]"
    m.reply "#{Format(:bold, "[MISC]")} !todo | !crawl <server> <port> | !servers | !seeip <interface> | !seeinterface <ip> | !genpass <len>" 
    m.reply "#{Format(:bold, "[NOTES]")} !note | !note list <category> | !note add <category> | !note del <category> | !note add <category> <item> | !note del <category> <num> | !netnote <netname> [newnote]" 
    
  end