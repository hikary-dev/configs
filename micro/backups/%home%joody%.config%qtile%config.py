## ИМПОРТ БИБЛИОТЕК ----------------------------------------------------------------
import os
import subprocess

from libqtile import hook

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal


## АВТОЗАПУСК ----------------------------------------------------------------------
@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([home])


## СДЕЛАТЬ ДИАЛОГОВЫЕ ОКНА ПЛАВАЮЩИМИ ----------------------------------------------
@hook.subscribe.client_new
def floating_dialogs(window):
    dialog = window.window.get_wm_type() == 'dialog'
    transient = window.window.get_wm_transient_for()
    if dialog or transient:
        window.floating = True


## КЛАВИША МОДИФИКАТОР -------------------------------------------------------------
mod = "mod4"


## ХОТКЕИ --------------------------------------------------------------------------
keys = [
    # Управление фокусом
    Key([mod], "left", lazy.layout.left(), desc="Move focus to left"), # Фокус влево
    Key([mod], "right", lazy.layout.right(), desc="Move focus to right"), # Фокус вправо
    Key([mod], "down", lazy.layout.down(), desc="Move focus down"), # Фокус вниз
    Key([mod], "up", lazy.layout.up(), desc="Move focus up"), # Фокус вверх
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"), # Переключить фокус

    # Перемещение окон
    Key([mod, "shift"], "left", lazy.layout.shuffle_left(), desc="Move window to the left"), # Переместить окно влево
    Key([mod, "shift"], "right", lazy.layout.shuffle_right(), desc="Move window to the right"), # Переместить окно вправо
    Key([mod, "shift"], "down", lazy.layout.shuffle_down(), desc="Move window down"), # Переместить окно вниз
    Key([mod, "shift"], "up", lazy.layout.shuffle_up(), desc="Move window up"), # Переместить окно вверх

    # Изменение размера окна
    Key([mod, "control"], "left", lazy.layout.grow_left(), desc="Grow window to the left"), # Увеличить окно влево
    Key([mod, "control"], "right", lazy.layout.grow_right(), desc="Grow window to the right"), # Увеличить окно вправо
    Key([mod, "control"], "down", lazy.layout.grow_down(), desc="Grow window down"), # Увеличить окно вниз
    Key([mod, "control"], "up", lazy.layout.grow_up(), desc="Grow window up"), # Увеличить окно вверх
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"), # Вернуть все взад
    
    # Запуск приложений
    Key([mod], "Return", lazy.spawn("alacritty")),
    #Key([mod], "f", lazy.spawn("firefox --wayland")), # Это для вайланда
    
    # Переключение между макетами
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    # Закрыть окно
    Key([mod], "c", lazy.window.kill(), desc="Kill focused window"),
    # Перезагрузить конфиг
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    # Выйти из Qtile
    # Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Выполнить команды (типо встроенное dmenu)
    Key([mod], "d", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

	# Раскладка клавиатуры
    # Key([mod], "]", lazy.widget["keyboardlayout"].next_keyboard(), desc="Next keyboard layout."),

    # Яхз что за это, типо все окна на месте одного окна отображаются.
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    # Key(
    # [mod, "l"],
    # "Return",
    # lazy.layout.toggle_split(),
    # desc="Toggle between split and unsplit sides of stack",
    # ),
]


## ПЕРЕКЛЮЧЕНИЕ ВОРКСПЕЙСОВ И ПЕРЕМЕЩЕНИЕ ОКОН ПО НИМ ------------------------------
groups = [Group(i) for i in "123456789"] # Имена воркспейсов
groups = [
    Group("1", label = "1", matches=[Match(wm_class="vivaldi-stable")]),
    Group("2", label = "2", matches=[Match(wm_class="jetbrains-pycharm")]),
    Group("3", label = "3", matches=[Match(wm_class="TelegramDesktop")]),
    Group("4", label = "4", matches=[Match(wm_class="discord")]),
    Group("5", label = "5"),
    Group("6", label = "6", matches=[Match(wm_class="blueberry.py")]),
    Group("7", label = "7"),
    Group("8", label = "8"),
    Group("9", label = "9"),
]                                                        
screens = [
    Screen(top=bar.Bar(widget.GroupBox(visible_groups=['1', '2',])))
    Screen(top=bar.Bar(widget.GroupBox(visible_groups=['4', '5', '6', '7'])))
    Screen(top=bar.Bar(widget.GroupBox(visible_groups=['8', '9', '0'])))
]
for i in groups:
    keys.extend(
        [
            # mod + номер вокспейса = переход на этот воркспейс
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod + shift + номер воркспейса = перенос окна на этот воркспейс
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
        ]
    )



## МАКЕТЫ (в скобках прописываются параметры, толщина бордера, цвета...) -----------
layouts = [
    # layout.Columns(),
    # layout.Max(), # Фуллскрин
    # layout.Stack(num_stacks=2), #Какая то фигня
    layout.Bsp(border_focus = "#f9f9f9", border_normal = "#263238", border_width=1, margin = 10), # Как в bspwm
    # layout.Matrix(), # В 2 колонки
    # layout.MonadTall(), # Как в dwm
    # layout.MonadWide(), # Как в dwm только по горизонтали
    # layout.RatioTile(), # Окна мазайкой 3х3, 4х4 ...
    # layout.Tile(), # Как в dwm
    # layout.TreeTab(), # Вертикальный монокль с заголовками
    # layout.VerticalTile(), # Окна открываются вертикально
    # layout.Zoomy(), # Как в dwm ток мастер окно большое
]


## ОБЩИЕ ПАРАМЕТРЫ ВИДЖЕТОВ НА ПАНЕЛИ ----------------------------------------------
widget_defaults = dict(
    font="JetBrainsMono",
    fontsize=12,
    padding=8,
)
extension_defaults = widget_defaults.copy()


## ВИДЖЕТЫ НА ПАНЕЛИ И ИХ ПАРАМЕТРЫ ------------------------------------------------
screens = [
    Screen(
        bottom=bar.Bar( # Расположение бара
            [
                #widget.CurrentLayout(), # Текущий макет
                widget.GroupBox(borderwidth=1, # Толщина рамки
                    highlight_method='block', # Метод выделения активного воркспейса
                    block_highlight_text_color='#263238',# Цвет текста активного воркспейса
                    this_current_screen_border="#f9f9f9", # Цвет фона активного воркспейса
                    rounded=True,
                    ), # Иконки воркспейсов
                widget.Prompt(), # Виджет выполнения команд
                widget.WindowName(max_chars=30),# Имя окна
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },               
                    name_transform=lambda name: name.upper(),
                ),

                widget.OpenWeather(location='Novosibirsk', format=' {main_temp}°', app_key="e434b5435a979de6e155570590bee89b",),
                widget.Spacer(length=10), # Виджет пробела
                
                widget.CheckUpdates(distro='Arch',
                display_format='UPDATES  {updates}',
                no_update_string='UPDATES  0'), # Виджет обновлений пакетов
                widget.Spacer(length=20), # Виджет пробела
                
                widget.TextBox(text="", padding=0),
                widget.PulseVolume(padding=5), # Виджет громкости пульсы
                widget.Spacer(length=10), # Виджет пробела

                widget.KeyboardLayout(configured_keyboards=['us', 'ru'],
                                    update_interval=1),
                
                widget.LaunchBar(progs=[('', 'scrot -d 3',)], icon_size='15px'),
                widget.Spacer(length=10), # Виджет пробела
                
                widget.Systray(), # Трэй, не работает в вялом, нужно будет юзать widget.StatusNotifier
                widget.Spacer(length=25), # Виджет пробела
                
                widget.Clock(format="%Y-%m-%d %a   %H:%M %p", padding=10), # Время и дата
                widget.Spacer(length=10), # Виджет пробела
                
                widget.QuickExit(default_text=''), # Кнопка выключения
            ],
            24, # Высота панели
            border_width=[5, 50, 5, 50],  # Толщина рамок панели
            border_color=["263238", "263238", "263238", "263238"],  # Цвет рамок панели
            margin=5, # Гапсы бара
            background="#263238" # Цвет фона панели
            #opacity=0,5 # Прозрачность бара
        ),
    ),
]


## МЫШЬ ----------------------------------------------------------------------------
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]


## НАСТРОЙКА ВМ --------------------------------------------------------------------

# Яхз
dgroups_key_binder = None

# На каком воркспейсе что открывается
dgroups_app_rules = []  # type: list

# Фокус следует за курсором
follow_mouse_focus = True

# Переносить окно на передний план при нажатии на него
bring_front_click = False

# Перемещать курсор в центр окна
cursor_warp = True

# Правила для плавающих окон
floating_layout = layout.Floating(
        border_width=0,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(wm_class="telegram-desktop"),
        Match(wm_class="imv"),
        Match(wm_class="mpv"),
        Match(wm_class="blueberry.py"),
        Match(wm_class="pavucontrol"),
        Match(wm_class="wireguird"),
        # Match(wm_class="firefox"),
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
       
# Автофулскрин
auto_fullscreen = True

# Фокусировка на запущенном окне
focus_on_window_activation = "smart"

# Перестраивать эраны при реконфигурировании
reconfigure_screens = False

# Минимизировать приложения или нет, яхз что то для геймеров
auto_minimize = True

# Устройства вывода для вялого
wl_input_rules = None

# Яхз, трогать не надо со слов разрабов
wmname = "LG3D"
