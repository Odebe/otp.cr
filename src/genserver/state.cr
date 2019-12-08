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

      def initialize(@state : T)
      end
    end
  end
end
