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
        case { message[0] }
        when {:call}
          nil
        when {:cast}
          result = do_cast(message[2]).not_nil!
          if result[0] == :reply
          # {:reply, state + 1, self, state + 123}
            message[1].cast(result[2].not_nil!, result[3].not_nil!,)
            @state = result[1]
          else
            # {:noreply, state, nil, nil}
            @state = result[1]
          end
        when {:exit}
          nil
        end
      end
    end
  end
end
