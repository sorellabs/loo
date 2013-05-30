package = "Loo"
version = "1.0.0"
source = {
  url = "http://github.com/killdream/loo.git",
  tag = "v1.0.0"
}
description = {
  summary = "Primitives for dealing with prototypical inheritance using Lua metatables", 
  detailed = [[
                 Loo provides core prototypical object orientation
                 primitives to use in your Lua programs.
             ]],
  homepage = "http://github.com/killdream/loo",
  license = "MIT/X11"
}
dependencies = {
   "lua >= 5.1"
}
build = {
   type = "builtin",
   modules = {
      loo = "loo.lua"
   }
}
