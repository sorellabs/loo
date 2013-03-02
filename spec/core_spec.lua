local loo = require("../loo")

describe("{} boo", function()

  describe("extend", function()
    it("- Should modify the first argument", function()
      local x = {}
      loo.extend(x, { a = 1 })
      assert.equal(x.a, 1)
    end)

    it("- Should use right-most precedence", function()
      local x = { a = 1 }
      loo.extend(x, {b=1}, {a=2}, {c=3,b=3})
      assert.equal(x.a, 2)
      assert.equal(x.b, 3)
      assert.equal(x.c, 3)
    end)
  end)

  describe("merge", function()
    it("- Should merge all tables in one table", function()
      local x = { a = 1 }
      local y = { b = 2 }
      local z = { a = 3 }
      local a = loo.merge(x, y, z)
      assert.equal(a.a, 3)
      assert.equal(a.b, 2)
    end)
    it("- Should not modify any tables", function()
      local x = { a = 1 }
      local y = { b = 2 }
      local z = { a = 3 }
      local a = loo.merge(x, y, z)
      assert.equal(x.a, 1)
      assert.equal(y.b, 2)
      assert.equal(z.a, 3)
    end)
  end)

  describe("derive", function()
    it("- Should make a new table inheriting from proto", function()
      local foo = { a = 1 }
      local bar = loo.derive(foo, { b = 2 })
      assert.equal(bar.b, 2)
      assert.equal(bar.a, 1)
    end)

    it("- Should extend the table with the given mixins", function()
      local foo = { a = 1 }
      local bar = loo.derive(foo, {b=2}, {c=3}, {a=4})
      assert.falsy(foo.b)
      assert.falsy(foo.c)
      assert.equal(foo.a, 1)
      assert.equal(bar.a, 4)
      assert.equal(bar.b, 2)
      assert.equal(bar.c, 3)
    end)
  end)

  describe("make", function()
    it("- Should clone the table", function()
      local a = { a = 1 }
      local b = loo.make(a)
      assert.is_not.equal(a, b)
      assert.equal(b.a, 1)
    end)

    it("- Should apply the `_init` method if present", function()
      local a = { _init = function(self, n) self.a = n end }
      local b = loo.make(a, 3)
      assert.equal(b.a, 3)
    end)
  end)

  describe("{} Base", function()
    describe("make", function()
      it("- Should behave as `make`, but with auto-self", function()
        local a = loo.Base:derive({ _init = function(self,n) self.a = n end })
        local b = a:make(3)
        assert.equal(b.a, 3)
      end)
    end)

    describe("derive", function()
      it("- Should behave as `derive`, but with auto-self", function()
        local a = loo.Base:derive({ a = 2 })
        local b = a:derive({ b = 3 }, { c = 4 })
        assert.equal(b.a, 2)
        assert.equal(b.b, 3)
        assert.equal(b.c, 4)
      end)
    end)
  end)
      
end)