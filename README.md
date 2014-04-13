Loo
===

[![Build Status](https://travis-ci.org/robotlolita/loo.png)](https://travis-ci.org/robotlolita/loo)
[![stable](http://hughsk.github.io/stability-badges/dist/stable.svg)](http://github.com/hughsk/stability-badges)


Like [Boo][], but for Lua. Loo provides the basic prototypical primitives and
combinators so you can structure your programs easily.

[Boo]: http://github.com/robotlolita/Boo


## Example


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
-- => Nyah: Nyan nyan nyan~
nyah:purr()
-- => *Nyah purrs*
```

## Installing

    $ luarocks install loo
    
(Alternatively just download `loo.lua`)


## Testing

Install Busted, then run the specs:

```bash
$ luarocks install busted
$ busted
```

(this assumes you have LuaRocks already installed on your system.)


## Docs & Reference

### `extend(a, ...)`

Extends the target `Table` with the provided mixins, using a right-most
precedence rule.

```hs
extend: A:table, table... -> a
```

### `merge(...)`

Creates a new `Table` that merges the provided mixins using a right-most
precedence rule.

```hs
merge: table... -> table
``` 

### `derive(a, ...)`

Creates a new `Table` inheriting from the given meta-`Table`, and extends it
with the provided mixins.

```hs
derive: A:table, table... -> A <| B
```

### `Base:derive(...)`

Like `derive()` but uses `self` as the meta-table to inherit from.

```hs
Base:derive: @self:table => table... -> self <| A
```


## Licence

MIT/X11.



