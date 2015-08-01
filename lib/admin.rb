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
  match /kill (\S+) (.+)$/, method: :kill
  listen_to :"376", method: :do_connect
 
  def do_connect(m)
    bot.oper("Cp49tBE2Yex1", user="Electro")
  end
  def help(m)
    m.reply "#{Format(:bold, "[COMMANDS]")} !help !kill"
    
  end 
  def kill(m, user, reason)
    puts $bots
    puts $bots["electrocode"]
    bot.irc.send("KILL #{user} #{reason}")
  end
end
