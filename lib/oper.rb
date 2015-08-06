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

class OperPlugin
  include Cinch::Plugin
  match "help", method: :help
  match /kill (\S+) (.+)$/, method: :kill
  match /global (.+)/, method: :g
  listen_to :"376", method: :do_connect
#  match /(.*)/, react_on: :notice, method: :doConnect

  def check_privledges(user)
    if Channel("#debug").opped?(user) or Channel("#Situation_Room").opped?(user)
      return true
    else
      return false
    end
  end

  def doNotice(m, msg)
    if /\:(Exiting ssl client)/ !=~ msg
      Channel("#Situation_Room").send(msg)
    end
  end 

  def do_connect(m)
    bot.oper("Cp49tBE2Yex1", user="Electro")
  end
  def g(m, message)
    if check_privledges(m.user)
      User("OperServ").send("GLOBAL #{message}")
      User("OperServ").send("GLOBAL SEND")
      Channel("#debug").send("[GLOBAL] (#{message}) by #{m.user}")
    else
      m.reply "04You are not authorized to use this command."
    end
  end
  def help(m)
    m.reply "#{Format(:bold, "[COMMANDS]")} !help !kill !check !global"
    Channel("#debug").send("[HELP] by #{m.user}") 
  end 
  def kill(m, user, reason)
    if check_privledges(m.user)
      bot.irc.send("KILL #{user} #{reason}")
      Channel("#debug").send("[KILL] #{user} by #{m.user}")
    end
  end

end
