require "./genserver/handlers.cr"
require "./genserver/state.cr"

module OTP
  module GenServer
    macro included
      include OTP::Actor
    end

    def start
      loop do
        m = @channel.receive
        @state = do_message(m).not_nil!
      end
    end
  end
end
