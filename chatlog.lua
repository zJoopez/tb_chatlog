local hookname = "chatlog"
local filePath = "../data/script/chatlog.txt"
-- filePath = "../data/script/log/chatlog.txt"

remove_hooks(hookname)
local file = Files.Open(filePath, FILES_MODE_WRITE)

local function custom_echo(msg, color)
    if color < 10 then color = "0" .. color end
    echo("^" .. COLORS.BLOSSOM .. "[ReplayFocus] ^" .. color .. msg)
end

local function kys()
    file:close()
    remove_hooks(hookname)
    custom_echo("chat logging stopped", COLORS.VIOLET)
end

add_hook("console", hookname, function(event)
    file = Files.Open(filePath, FILES_MODE_APPEND)
    local timestamp = os.date("%Y-%m-%d %H:%M:%S")
    file:writeLine("[" .. timestamp .. "] " .. tostring(event))
    file:close()
end)

add_hook("command", hookname, function(event)
    if event == "kys" then
        kys()
    elseif event == "ping" then
        custom_echo("pong", COLORS.VIOLET)
    end
end)

if not file then
    custom_echo("failed to open file", COLORS.RED)
    kys()
    return
else
    custom_echo("chat logging started", COLORS.VIOLET)
    custom_echo("/kys to kill script", COLORS.VIOLET)
    custom_echo("/ping to check if alive", COLORS.VIOLET)
end
file:close()
