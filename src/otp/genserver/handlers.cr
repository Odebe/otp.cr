module OTP
  module GenServer
    module Handlers(*T)
      macro included
        init_handlers!

        @channel = Channel(Union(*T)).new  
      end

      macro init_handlers!
        def do_message(m : Union(*T))
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
