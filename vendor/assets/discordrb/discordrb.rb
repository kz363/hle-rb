require_relative 'discordrb/version'
require_relative 'discordrb/bot'
require_relative 'discordrb/commands/command_bot'

# All discordrb functionality, to be extended by other files
module Discordrb
  Thread.current[:discordrb_name] = 'main'
end
