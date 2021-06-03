local compe = require("compe")
local Job = require("plenary.job")
local Source = {}
Source.new = function()
  local self = setmetatable({}, {__index = Source})
  return self
end
Source.get_metadata = function(self)
  return {dup = 0, menu = "[look]", priority = 100}
end
Source.determine = function(self, context)
  return compe.helper.determine(context)
end
Source.complete = function(self, context)
  return self:collect((context.context.line):match("%a+$"), context.callback)
end
Source.collect = function(self, substring, callback)
  local results = {}
  do
    local job
    local function _0_(job0, _return)
      local words = job0:result()
      for _, word in ipairs(words) do
        table.insert(results, {word = word})
        callback({incomplete = true, items = results})
      end
      return nil
    end
    job = Job:new({args = {"-f", substring, ((vim.split(vim.o.dictionary, ",", true))[1] or "")}, command = "look", on_exit = _0_})
    job:start()
  end
  return results
end
return compe.register_source("look", Source)
