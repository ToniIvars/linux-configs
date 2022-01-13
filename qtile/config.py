from typing import List

from libqtile import bar, layout, widget, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.widget import base

import subprocess, os, json

mod = "mod4"
terminal = 'kitty'
wallpaper = 'nebula'

dmenu_command = 'dmenu_run -p "Launch:" -nf "#ffffff" -sf "#ffffff" -nb "#49557D" -sb "#7b8cac" -h 26'

keys = [
    # Shortcuts
    Key([mod], "d", lazy.spawn(dmenu_command)),
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

    # Move windows
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows
    Key([mod, "control"], "Left", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "Right", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"], "Down", lazy.layout.grow_down(),
        desc="Grow window down"),
    Key([mod, "control"], "Up", lazy.layout.grow_up(), desc="Grow window up"),

    # Grow windows in the monadtall layout
    Key([mod, "control"], "Up", lazy.layout.grow(),
        desc="Grow window to the left"),
    Key([mod, "control"], "Down", lazy.layout.shrink(),
        desc="Grow window to the right"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "F4", lazy.window.kill(), desc="Kill focused window"),

    # Shutdown and restart
    Key([mod, "shift"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    Key([mod, "control"], "q", lazy.spawn('shutdown now')),
    Key([mod, "control"], "r", lazy.spawn('shutdown -r now')),
    Key([mod, "control"], "s", lazy.spawn('systemctl suspend'))
]

# The icons from Nerd Fonts
groups = [Group('', layout='columns')] + [Group(i, layout='monadtall') for i in ""]

for int_key, i in enumerate(groups, start=1):
    keys.extend([
        # mod + letter of group => switch to group
        Key([mod], str(int_key), lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),

        # mod1 + shift + letter of group => switch to & move focused window to group
        Key([mod, "shift"], str(int_key), lazy.window.togroup(i.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(i.name)),
    ])

# Set the colour theme depending on the wallpaper name
with open(os.path.expanduser('~/.config/qtile/colours.json'), 'r') as f:
    colours = json.load(f)[wallpaper]

layouts = [
    layout.MonadTall(margin=2, single_border_width=0,
                     border_focus=colours["bluetooth"], border_normal=colours["clock"]),
    layout.Columns(margin=2, border_focus=colours["bluetooth"], border_focus_stack=colours["bluetooth"],
                   border_normal=colours["clock"], border_normal_stack=colours["clock"], grow_amount=5),
    layout.Max()
]

# Custom widgets
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
            connected = subprocess.check_output('nmcli -g name c show --active'.split()).decode()
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

class Brightness(base.InLoopPollText):
    def __init__(self, **config):
        base.InLoopPollText.__init__(self, "", **config)
        self.update_interval = 0.2

    def poll(self):
        current = float(subprocess.check_output(['light', '-G']).decode())
        return f' {round(current, -1):.0f}%'

# Widgets defaults
widget_defaults = dict(
    font='SauceCodePro Nerd Font Mono Semibold',
    fontsize=18,
    padding=6,
    foreground=colours["white"],
)
extension_defaults = widget_defaults.copy()

# Definition of screen and widgets
ssid_widget = SSID(mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(f'{terminal} -e nmtui'.split())}, background=colours["wifi"])

bluetooth_widget = Bluetooth(mouse_callbacks={'Button1': lambda: qtile.cmd_spawn('blueman-manager'.split())},
                   max_chars=14, background=colours["bluetooth"])

brightness_widget = Brightness(background=colours["volume"])

left_sep = lambda fg, bg: widget.TextBox(text='', foreground=fg, background=bg, fontsize=56, padding=-11) 

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayoutIcon(background=colours["grey"], custom_icon_paths=[os.path.expanduser('~/.config/qtile/layout-icons')], scale=0.75),

                widget.GroupBox(disable_drag=True, fontsize=22, highlight_method='line', highlight_color=colours["gb_highlight"],
                                this_current_screen_border=colours["gb_cs_border"], inactive=colours["gb_inactive"]),

                widget.WindowName(parse_text=lambda t: t.split(' - ')[-1] if 'Firefox' in t else t),

                left_sep(colours["white"], colours["second_sep"]),
                widget.CheckUpdates(
                    display_format = ' {updates}',
                    no_update_string = ' 0',
                    distro= 'Arch',
                    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(f'{terminal} -e sudo pacman -Su --noconfirm'.split())},
                    restart_indicator = 'ﰇ',
                    colour_have_updates = colours["red"], colour_no_updates = colours["black"], background=colours["white"]
                ),

                left_sep(colours["bluetooth"], colours["white"]),
                bluetooth_widget,

                left_sep(colours["wifi"], colours["bluetooth"]),
                ssid_widget,

                left_sep(colours["volume"], colours["wifi"]),
                widget.Volume(
                    fmt = '墳 {}', background=colours["volume"],
                    get_volume_command = 'amixer -D pulse get Master'.split(),
                    mute_command = 'amixer -q -D pulse set Master toggle',
                    volume_down_command = 'amixer -q -D pulse set Master 5%-',
                    volume_up_command = 'amixer -q -D pulse set Master 5%+'
                ),
                brightness_widget,

                left_sep(colours["clock"], colours["volume"]),
                widget.Clock(format=' %H:%M %d-%m-%Y', background=colours["clock"]),

                left_sep(colours["grey"], colours["clock"]),
                widget.Battery(charge_char='', full_char='', update_interval=30, discharge_char='', format='{char} {percent:2.0%}',
                               low_foreground=colours["red"], background=colours["grey"], notify_below=10),
            ],
            24,
            background='ffffff.0' # Only to set background opacity to 0%
        ),
    ),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

# floating_layout = layout.Floating(float_rules=[
#     # Run the utility of `xprop` to see the wm class and name of an X client.
#     *layout.Floating.default_float_rules,
#     Match(wm_class='confirmreset'),  # gitk
#     Match(wm_class='makebranch'),  # gitk
#     Match(wm_class='maketag'),  # gitk
#     Match(wm_class='ssh-askpass'),  # ssh-askpass
#     Match(title='branchdialog'),  # gitk
#     Match(title='pinentry'),  # GPG key password entry
# ])

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

auto_minimize = True

# wmname = "LG3D"

commands = [
    'setxkbmap es', # Change keyboard layout
    f'feh --bg-fill ~/.config/qtile/wallpapers/{wallpaper}.jpg', # Set the wallpaper
    'picom --config ~/.config/picom/picom.conf -b', # Starts picom
]

for c in commands:
    os.system(c)
