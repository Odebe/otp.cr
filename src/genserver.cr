require "./genserver/handlers.cr"
require "./genserver/state.cr"

module OTP
  module GenServer
    macro included
      include OTP::Actor
    end

    def start
      loop do
        message = @channel.receive
        @state = do_cast(message).not_nil!
      end
    end
  end
end
