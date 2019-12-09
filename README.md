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

  def init(params)
    params
  end

  def foo(m : Symbol, actor : OTP::Actor)
    actor.cast(self, m)
  end

  def handle_cast(state, m : Int32)
    puts "It's #{typeof(m)}, and equal #{m}"

    {:noreply, state + 1, nil, nil}
  end

  def handle_cast(state, m : Symbol)
    puts "It's #{typeof(m)}, and equal #{m.inspect}"

    {:reply, state, self, 1}
  end

  def handle_cast(state, m : Bool)
    puts "It's #{typeof(m)}, and equal #{m.inspect}"

    {:noreply, state, nil, nil}
  end
end

s = MyServer.new(123)
s.spawn

ss = MyServer.new(1)
ss.spawn

# s.add_link(ss)
s.foo(:lololol, ss)

Fiber.yield
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
