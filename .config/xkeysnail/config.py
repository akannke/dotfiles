import re

from xkeysnail.key import Key
from xkeysnail.transform import K, define_keymap, define_multipurpose_modmap

# define_multipurpose_modmap({
#     Key.HENKAN: [Key.HENKAN, Key.RIGHT_ALT],
#     Key.MUHENKAN: [Key.MUHENKAN, Key.LEFT_ALT],
# })

# Emacs-like keybindings in non-Emacs applications
define_keymap(lambda wm_class: wm_class not in ("Emacs", "URxvt", "Gnome-terminal"), {
    K("C-h"): K("backspace"),
    K("C-d"): K("delete"),
    K("C-m"): K("enter")
})

# define_keymap(lambda wm_class: wm_class != "Gnome-terminal", {
#     K("C-right_brace"): K("esc")
# })
