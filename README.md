# otp.cr

Naive OTP implementation in Crystal.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     otpcr:
       github: Odebe/otp.cr
   ```

2. Run `shards install`

## Usage

```crystal
equire "otpcr/otp"

class MyServ
  include OTP::GenServer(Int32, String, Int32, Bool)
  
  def init(_number)
    0
  end

  def handle(state, m : String)
    puts m + " " + typeof(m).to_s
    
    0
  end

  def handle(state, m : Int32)
    puts m.to_s + " " + typeof(m).to_s

    state + m
  end

  def handle(state, m : Bool)
    puts m.to_s + " " + typeof(m).to_s
    
    state
  end
end

s = MyServ.new(9999)
s.start

puts "init state: #{s.state}"

s.cast(12333)
sleep 1
puts s.state

s.cast(1)
sleep 1
puts s.state

s.cast("123")
sleep 1
puts s.state
```

TODO: Write usage instructions here

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/Odebe/otp.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Odebe](https://github.com/Odebe) - creator and maintainer
