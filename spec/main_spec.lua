local Trie = require "init"

describe("Main test", function()
  it(function()
    local items = Trie.new()

    for _, v in ipairs {
      "aragorn",
      "aragon",
      "aralon",
      "argon",
      "eragon",
      "oregon",
      "oregano",
      "oreo",
    } do items:add(v) end

    local isFound, payload = items:find "ara"

    assert.falsy(isFound)
    assert.falsy(payload)

    isFound, payload = items:find "oregon"

    assert.truthy(isFound)
    assert.falsy(payload)
  end)
end)
