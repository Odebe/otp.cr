module OTP
  module Actor
    def spawn
      ::spawn { start }
    end
  end
end
