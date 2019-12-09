module OTP
  module Actor
    abstract class Message
      abstract def type : Symbol
    end
    
    class ExitMsg < Message
      def type
        :exit
      end
    end

    class CallMsg < Message
      def type
        :call
      end
    end

    class CastMsg < Message
      def type
        :cast
      end
    end
  end
end
