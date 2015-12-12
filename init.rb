$LOAD_PATH << ".vendor/assets/discordrb/discordrb"
require_relative 'vendor/assets/discordrb/discordrb'

$bot = Discordrb::Bot.new ENV['DISCORD_EMAIL'], ENV['DISCORD_PASSWORD']

require './scripts/help'
require './scripts/kane'
require './scripts/reddit'
require './scripts/youtube'

require 'pry'
require 'pry-byebug'

$bot.run
