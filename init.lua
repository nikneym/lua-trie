--[[
MIT License

Copyright (c) 2023 nikneym

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

local byte = string.byte

local Trie = {}
Trie.__index = Trie

--- Create a new Trie object
--- @return table
function Trie.new()
  return setmetatable({
    nodes = {}
  }, Trie)
end

--- Add the given string to the tree with optional payload
--- @param word string
--- @param payload any
function Trie:add(word, payload)
  assert(type(word) == "string", "first argument of 'Trie.add' must be a string")

  local current = self
  for i = 1, #word do
    local b = byte(word, i)

    if not current.nodes[b] then
      current.nodes[b] = {
        nodes = {},
        isEnd = false,
      }
    end

    current = current.nodes[b]
  end

  current.isEnd = true
  current.payload = payload or nil
end

--- Deletes the reference of the given string from the tree
--- @param word string
--- @return string | nil
function Trie:undefine(word)
  assert(type(word) == "string", "first argument of 'Trie.undefine' must be a string")

  local current = self
  for i = 1, #word do
    local b = byte(word, i)

    if not current.nodes[b] then
      return "item is not represented in tree"
    end

    current = current.nodes[b]
  end

  current.isEnd = false
  current.payload = nil
  return nil
end

--- Search the given string in the tree
--- @param word string
--- @return boolean
--- @return nil | any
function Trie:find(word)
  assert(type(word) == "string", "first argument of 'Trie.find' must be a string")

  local current = self
  for i = 1, #word do
    local b = byte(word, i)

    if not current.nodes[b] then
      return false, nil
    end

    current = current.nodes[b]
  end

  if current.isEnd then
    return true, current.payload
  end

  return false, nil
end

setmetatable(Trie, { __call = Trie.new })

return Trie
