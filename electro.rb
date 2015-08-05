#! /usr/bin/env ruby
####
## ElectroCode administration bot
##
## Copyright (c) 2015 Ken Specer
##
## MIT License
## See LICENSE file for details.
####
$version = [0,0,5]
require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: ARGV[0] [options]"

  opts.on("-v", "--version", "Print Version and exit") do |v|
    puts "Version: #{$version.join(".")} "
	exit 0
  end
end.parse!



###
#	Begin Code
###
$:.unshift File.dirname(__FILE__)

require 'cinch'
require 'cinch/plugins/identify'
require 'yaml'
require 'lib/oper'
require 'lib/logger'
require 'lib/test'


$config = YAML.load_file("config/config.yml")
$bots = Hash.new
$threads = Array.new
$start = Time.now.to_i

# Set up a bot for each server
bot = Cinch::Bot.new do
	configure do |c|
		c.nick = $config["bot"]["nick"]
		c.user = $config["bot"]["user"] 
		c.realname = $config["bot"]["realname"]
		c.server = $config["bot"]["zncaddr"]
		c.port = $config["bot"]["zncport"]
		c.ssl.use = true
		c.sasl.username = $config["bot"]["saslname"]
		c.sasl.password = $config["bot"]["saslpass"]
		c.local_host = $config["bot"]["vhost"]
		c.channels = $config["bot"]["channels"]
		c.plugins.plugins = [Cinch::Plugins::Identify, OperPlugin, TestPlugin]
	end
#  bot.loggers.clear
#  bot.loggers << BNCLogger.new(name, File.open("log/irc.log", "a"))
#  bot.loggers << BNCLogger.new(name, STDOUT)
#  bot.loggers.level = :error

puts "Initialization complete. Connecting to IRC..."
# Start the bots
$bots.each do |key, bot|
  puts "Starting IRC connection"
  $threads << Thread.new { bot.start }
end
puts "Connected!"
sleep 5
$threads.each { |t| t.join } # wait for other threads
