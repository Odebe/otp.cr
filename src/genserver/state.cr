module OTP
  module GenServer
    module State(T)
      module ClassMethods(M)
        def init(state : M)
          new(state)
        end
      end

      macro included
        extend OTP::GenServer::State::ClassMethods(T)
      end

      @state : T
      @init : T

      def initialize(state : T)
        @init = state
        @state = init(state)
      end
    end
  end
end
