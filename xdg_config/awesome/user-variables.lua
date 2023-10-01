local home = os.getenv("HOME")

local _M = {
  modkey = "Mod4",

  editor = os.getenv("EDITOR"),
  browser = os.getenv("BROWSER"),
  launcher = "rofi -show run",
  terminal = os.getenv("TERM"),
  locker = "betterlockscreen",

  in_monitor = "eDP1",
  ex_monitor = "HDMI1",
}

return _M
