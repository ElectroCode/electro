#!/usr/bin/env ruby
####
## bnc.im administration bot
##
## Copyright (c) 2013 Andrew Northall
##
## MIT License
## See LICENSE file for details.
####

$:.unshift File.dirname(__FILE__)

require 'cinch'
require 'cinch/plugins/identify'
require 'yaml'
require 'lib/oper'
require 'lib/notes'

$config = YAML.load_file("config/config.yml")
$bots = Hash.new
$zncs = Hash.new
$threads = Array.new
$start = Time.now.to_i

# Set up a bot for each server
$config["servers"].each do |name|
  bot = Cinch::Bot.new do
    configure do |c|
      c.nick = $config["bot"]["nick"]
      c.server = $config["bot"]["addr"]
      c.port = $config["bot"]["port"]
      c.ssl.use = true
      c.plugins.plugins = [OperPlugin]
    end
  end
  bot.loggers.clear
  bot.loggers << BNCLogger.new(name, File.open("log/irc.log", "a"))
  bot.loggers << BNCLogger.new(name, STDOUT)
  bot.loggers.level = :error
  if $config["adminnet"] == name
    $adminbot = bot
  end
  $bots[name] = bot
end

$notedb = NoteDB.new($config["notedb"])
$netnotedb = NoteDB.new($config["netnotedb"])

puts "Initialization complete. Connecting to IRC..."

# Start the bots

$bots.each do |key, bot|
  puts "Starting IRC connection for ElectroCode..."
  $threads << Thread.new { bot.start }
end

puts "Connected!"

sleep 5

$threads.each { |t| t.join } # wait for other threads
