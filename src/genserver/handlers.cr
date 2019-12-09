module OTP
  module GenServer
    module Handlers(*T)
      macro included
        init_handlers!

        alias HandlersTypes = Union(*T) 
        alias ChannelType = Tuple(Symbol, OTP::Actor, HandlersTypes)

        @channel = Channel(ChannelType).new
      end

      macro init_handlers!
        def do_cast(m)
          {% for type in T.resolve %}
            if m.is_a? {{ type }}
              return handle_cast(@state, m)
            end
          {% end %}
        end
    
        {% for type in T.resolve %}
          def cast(actor : OTP::Actor, m : {{ type }})
            @channel.send({:cast, actor, m})
          end
        {% end %}
      end
    end
  end
end
