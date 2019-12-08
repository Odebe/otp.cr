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
require "otpcr/otp"

class MyServer
  include OTP::GenServer
  include OTP::GenServer::State(Int32)
  include OTP::GenServer::Handlers(Int32, Symbol, Bool)

  def handle(state, m : Int32)
    puts "It's #{typeof(m)}, and equal #{m}"

    m + 123 # new state
  end

  def handle(state, m : Symbol)
    puts "It's #{typeof(m)}, and equal #{m.inspect}"

    1 # new state
  end

  def handle(state, m : Bool)
    puts "It's #{typeof(m)}, and equal #{m.inspect}"

    0 # new state
  end
end

s = MyServer.init(123)
s.spawn

s.cast(1)
sleep 2

s.cast(:a)
sleep 2

s.cast(true)
sleep 2
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
