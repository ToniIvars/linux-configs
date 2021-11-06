# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from typing import List  # noqa: F401

from libqtile import bar, layout, widget, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.widget import base

import subprocess, os

mod = "mod4"
terminal = 'alacritty'

keys = [
    # Shortcuts
    Key([mod], "d", lazy.spawn("dmenu_run -p 'Launch: '")),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "b", lazy.spawn('firefox')),
    Key([mod], "v", lazy.spawn('code')),
    Key([mod], "t", lazy.spawn('thunar')),

    # Volume configuration
    Key([], "XF86AudioRaiseVolume", lazy.spawn('amixer -q -D pulse set Master 5%+')),
    Key([], "XF86AudioLowerVolume", lazy.spawn('amixer -q -D pulse set Master 5%-')),
    Key([], "XF86AudioMute", lazy.spawn('amixer -q -D pulse set Master toggle')),

    # Brightness configuration
    Key([], "XF86MonBrightnessUp", lazy.spawn('light -A 10')),
    Key([], "XF86MonBrightnessDown", lazy.spawn('light -U 10')),

    # Switch between windows
    Key([mod], "Left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "Right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "Down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "Up", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(),
        desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "Left", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "Right", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"], "Down", lazy.layout.grow_down(),
        desc="Grow window down"),
    Key([mod, "control"], "Up", lazy.layout.grow_up(), desc="Grow window up"),

    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "F4", lazy.window.kill(), desc="Kill focused window"),
    Key(["mod1"], "F4", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "shift"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"),

    # Shutdown and restart
    Key([mod, "control"], "q", lazy.spawn('shutdown now')),
    Key([mod, "control"], "r", lazy.spawn('shutdown -r now')),
    Key([mod, "control"], "s", lazy.spawn('systemctl suspend'))
]

# The icons are icons from Nerd Fonts
groups = [Group(i, layout='monadtall') for i in ""]

for int_key, i in enumerate(groups, start=1):
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], str(int_key), lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], str(int_key), lazy.window.togroup(i.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(i.name)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
        #     desc="move focused window to group {}".format(i.name)),
    ])

layouts = [
    layout.MonadTall(margin=2, single_border_width=0),
    layout.Bsp(margin=2),
    # layout.Columns(margin=2),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Matrix(margin=2),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font='SauceCodePro Nerd Font Mono Semibold',
    fontsize=18,
    padding=6,
)
extension_defaults = widget_defaults.copy()

class SSID(base.InLoopPollText):
    def __init__(self, name_display=12, **config):
        base.InLoopPollText.__init__(self, "", **config)
        self.update_interval = 5

        self.name_display = name_display
    
    def ssid_format(self, ssid):
        if len(ssid) <= self.name_display:
            return ssid

        else:
            return f'{ssid[:5]}  {ssid[-5:]}'
    
    def poll(self):
        try:
            connected = subprocess.check_output(f'iwgetid -r'.split()).decode()
            return '直 ' + self.ssid_format(connected.strip())

        except:
            return '直 Dis'

class Bluetooth(base.InLoopPollText):
    def __init__(self, **config):
        base.InLoopPollText.__init__(self, "", **config)
        self.update_interval = 5

    def poll(self):
        macs = [x.split()[1] for x in subprocess.check_output(['bluetoothctl', 'devices']).decode().splitlines()]

        for mac in macs:
            output = subprocess.check_output(['bluetoothctl', 'info', mac]).decode().splitlines()
            device = ' '.join(output[1].strip().split()[1:])
            connected = True if output[8].strip().split()[-1] == 'yes' else False

            if connected:
                return f' {device}'

        else:
            return ' Dis'

colours = {
    'red': 'ff0000',
    'green': '00cc00',
    'blue': '0099ff',
    'light_blue': '99e6ff',
    'light_green': '60daae'
}

ssid_widget = SSID(mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(f'{terminal} -e nmtui'.split())}, foreground=colours["light_blue"])

bluetooth_widget = Bluetooth(mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(f'{terminal} -e bluetooth_config'.split())}, max_chars=14, foreground=colours["blue"])

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(disable_drag=True, fontsize=22),
                widget.Prompt(),
                widget.WindowName(parse_text=lambda t: t.split(' - ')[-1] if 'Firefox' in t else t),
                widget.CheckUpdates(
                    display_format = ' Updates: {updates}',
                    no_update_string = ' Up to date',
                    custom_command = 'apt list --upgradable', custom_command_modify = lambda x: x-1,
                    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(f'{terminal} -e sudo apt upgrade'.split())},
                    restart_indicator = 'ﰇ',
                    colour_have_updates = colours["red"], colour_no_updates = colours["green"]
                ),
                widget.Sep(),
                bluetooth_widget,
                widget.Sep(),
                ssid_widget,
                widget.Sep(),
                widget.Volume(
                    fmt = '墳 {}', foreground=colours["light_green"],
                    get_volume_command = 'amixer -D pulse get Master'.split(),
                    mute_command = 'amixer -q -D pulse set Master toggle',
                    volume_down_command = 'amixer -q -D pulse set Master 5%-',
                    volume_up_command = 'amixer -q -D pulse set Master 5%+'
                ),
                widget.Sep(),
                widget.Clock(format='%H:%M %d-%m-%Y'),
                widget.Sep(),
                widget.Battery(charge_char='', full_char='', update_interval=30, discharge_char='', format='{char} {percent:2.0%}', low_foreground=colours["red"]),
                widget.Notify(),
            ],
            24,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
# wmname = "LG3D"

commands = [
    'setxkbmap es', # Change keyboard layout
    'feh --bg-fill ~/.config/qtile/wallpaper.jpg', # Set the wallpaper
    'picom --config ~/.config/picom.conf -b', # Starts picom
    'system_updater &',
]

for c in commands:
    os.system(c)