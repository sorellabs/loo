--- Module loo
--
-- Base primitives for prototypical OO.
--
--
-- Copyright (c) 2011 Quildreen "Sorella" Motta <quildreen@gmail.com>
--
-- Permission is hereby granted, free of charge, to any person
-- obtaining a copy of this software and associated documentation files
-- (the "Software"), to deal in the Software without restriction,
-- including without limitation the rights to use, copy, modify, merge,
-- publish, distribute, sublicense, and/or sell copies of the Software,
-- and to permit persons to whom the Software is furnished to do so,
-- subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be
-- included in all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-- EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
-- NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
-- LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
-- OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
-- WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


--- -- Core primitives -------------------------------------------------

---- λ extend
-- Extends the target `Table` with the provided `Table`s, using a
-- right-most precedence rule.
--
-- ### See also
--   - `merge` — a pure implementation of `extend`.
--
-- :: a:Table, Table... -> a
local function extend(target, ...)
  local sources = {...}
  for _, source in ipairs(sources) do
    for k, v in pairs(source) do
      target[k] = v
    end
  end
  return target
end


---- λ merge
-- Creates a new `Table` that merges the provided `Table`s, using a
-- right-most precedence rule.
--
-- ### See also
--   - `extend` — the impure implementation of `merge`.
--
-- :: Table... -> Table
local function merge(...)
  return extend({}, ...)
end


---- λ derive
-- Creates a new `Table` inheriting from the given meta-`Table`, and
-- extends the new `Table` with the provided additional sources.
--
-- :: a:Table, Table... -> a <| b
local function derive(proto, ...)
  local meta   = setmetatable({}, proto)
  local result = setmetatable({}, meta)
  meta.__index = proto
  extend(result, ...)
  return result
end


---- λ make
-- Constructs a new `Table` inheriting from the given meta-`Table`, and
-- calls the initialisation function on this new `Table`.
--
-- :: a:Table, b... -> a <| c
local function make(proto, ...)
  local instance = derive(proto)
  if instance._init then instance:_init(...) end
  return instance
end


--- -- Root object -----------------------------------------------------

---- {} Base
local Base = {}

----- λ make
-- :: @self:Table => Table... -> self <| b
function Base:make(...)
  return make(self, ...)
end

----- λ derive
-- :: @self:Table => Table... -> self <| a
function Base:derive(...)
  return derive(self, ...)
end


--- -- Exports ---------------------------------------------------------
return { extend = extend
       ; merge  = merge
       ; derive = derive
       ; make   = make
       ; Base   = Base
       }