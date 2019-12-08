module OTP
  module GenServer(M, *T)
    macro included
      include OTP::Actor
      init_state! M
      init_handlers!  
    end
  
    @channel = Channel(Union(*T)).new
  
    macro init_state!(type)
      @state : {{ type }}
      @init : {{ type }}
  
      property :state
  
      def initialize(@state : {{ type }})
        @init = @state
        @state = init(@state)
      end
    end
  
    macro init_handlers!
      def call(m)
        {% for type in T.resolve %}
          if m.is_a? {{ type }}
            return handle(@state, m)
          end
        {% end %}
        raise "123"
      end
  
      {% for type in T.resolve %}
        def cast(m : {{ type }})
          @channel.send(m)
        end
      {% end %}
    end

    def start
      spawn do
        loop do
          m = @channel.receive
          @state = call(m)
        end
      end
    end
    
  end
end
