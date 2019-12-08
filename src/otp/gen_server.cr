require "./genserver/*.cr"

module OTP
  module GenServer
    macro included
      include Actor
    end

    def start
      loop do
        m = @channel.receive
        @state = do_message(m)
      end
    end
  end
end
