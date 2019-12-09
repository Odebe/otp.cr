module OTP
  module GenServer
    module Handlers(*T)
      macro included
        init_handlers!

        alias HandlersTypes = Union(*T) 

        @channel = Channel(HandlersTypes).new
      end

      macro init_handlers!
        def do_cast(m)
          {% for type in T.resolve %}
            if m.is_a? {{ type }}
              return handle(@state, m)
            end
          {% end %}
        end
    
        {% for type in T.resolve %}
          def cast(m : {{ type }})
            @channel.send(m)
          end
        {% end %}
      end
    end
  end
end
