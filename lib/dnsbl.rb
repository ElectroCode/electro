# -*- coding: utf-8 -*-
#
#  Copyright 2015 Ken Iota Spencer <iota@electrocode.net>
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.


##Config
servers = [
    'dnsbl.dronebl.org',
    'dnsbl.proxybl.org',
    'tor.dnsbl.sectoor.de',
    'tor.dan.me.uk',
    'dnsbl.bnc4free.in',
    'dnsbl.jnabl.org',
    'rbl.efnet.org',
    'virbl.dnsbl.bit.nl',
    'dnsbl.ahbl.org',
    'rbl.faynticrbl.org',
    'dnsbl.libirc.so',
    'dnsbl.ipocalypse.net',
    'dnsbl.rizon.net',
    'dnsbl.swiftbl.org'
]


##Imports
require 'socket'
##Code

class DNSBLPlugin
  include Cinch::Plugin
  match "help", method: :help
  match /check (\S+)/, method: :check
  def check_privledges(user)
    if Channel("#debug").opped?(user) or Channel("#Situation_Room").opped?(user)
      return true
    else
      return false
    end
  end

  def check(m, ip)
    if /(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)/ =~ ip
      m.reply "Scanning IP address..."
      splitem = ip.split('.')
      reverseem = "#{splitem[3]}.#{splitem[2]}.#{splitem[1]}.#{splitem[0]}"
      det = 0
      ndet = 0
      zone = []
      servers = [
        'dnsbl.dronebl.org',
        'dnsbl.proxybl.org',
        'tor.dnsbl.sectoor.de',
        'tor.dan.me.uk',
        'dnsbl.bnc4free.in',
        'dnsbl.jnabl.org',
        'rbl.efnet.org',
        'virbl.dnsbl.bit.nl',
        'dnsbl.ahbl.org',
        'rbl.faynticrbl.org',
        'dnsbl.libirc.so',
        'dnsbl.ipocalypse.net',
        'dnsbl.rizon.net',
        'dnsbl.swiftbl.org'
      ]

      servers.each do |server|
        begin
          Socket::gethostbyname(reverseem + "." + server)
          det += 1
          zone << server
        rescue
          ndet += 1
        end
      end
      if det
        m.reply "The IP has been detected 04#{det} times by #{servers.length} BL zones."
        m.reply "Detected BL zones: 04#{zone.join(", ")}"
      else
        m.reply "The IP has not been detected by 09#{servers.length} BL zones."
      end

    else
      m.reply "The IP (#{ip}) is not valid."
    end
  end
end
