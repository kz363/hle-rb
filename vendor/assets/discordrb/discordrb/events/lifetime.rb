require_relative 'generic'

module Discordrb::Events
  class ReadyEvent; end
  class ReadyEventHandler < TrueEventHandler; end

  class DisconnectEvent; end
  class DisconnectEventHandler < TrueEventHandler; end
end
