Loo
===

[![Build Status](https://travis-ci.org/killdream/loo.png)](https://travis-ci.org/killdream/loo)


Like [Boo][], but for Lua. Loo provides the basic prototypical primitives and
combinators so you can structure your programs easily.

[Boo]: http://github.com/killdream/Boo


```lua
local loo = require("loo")

local Animal = loo.Base:derive({ name = 'Unknown' })

function Animal:say(thing)
  return self.name .. ": " .. thing
end

local Cat = Animal:derive()

function Cat:purr(name)
  return "*" .. self.name .. " purrs*"
end

local nyah = Cat:derive({ name = "Nyah" })
nyah:say("Nyan nyan nyan~")
// => Nyah: Nyan nyan nyan~
nyah:purr()
// => *Nyah purrs*
```

### Installing

...


### Testing

Install Busted, then run the specs:

```bash
$ luarocks install busted
$ busted
```

(this assumes you have LuaRocks already installed on your system.)


### Docs & Reference

...


### Licence

MIT/X11.



