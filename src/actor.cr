module OTP
  module Actor
    @mutex = Mutex.new
    @links = [] of OTP::Actor

    def spawn
      ::spawn do
        begin 
          start
        rescue ex
          @links.each { |e| spawn { trap(self, ex) } }
        end
        Fiber.yield
      end
    end

    def trap(a : OTP::Actor, ex : Exception)
      puts "exp: #{ex} from actor: #{a.inspect}"
    end

    def add_link(link : OTP::Actor)
      @mutex.synchronize do
        @links << link
      end
    end
  end
end
