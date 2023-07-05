local awful = require("awful")

local function execute_once(command)
  awful.spawn.with_shell("pgrep -u $USER -x " .. command .. " || " .. command)
end


local function execute_commands(commands)
  for _,command in ipairs(commands) do
    execute_once(command)
  end
end

local executer = {}

executer.execute_commands = execute_commands

return executer
