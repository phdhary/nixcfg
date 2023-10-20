#!/bin/bash

super + alt + {c,r}
	i3-msg {reload,restart}

super + q
  i3-msg kill

super + g
	i3-msg gaps inner all set {0,10}

super + {t, shift + space,m}
	i3-msg {split toggle,floating toggle,fullscreen toggle}

super + {w,e,s}
	i3-msg  layout {tabbed,toggle split,stacked}

super + {_,shift +} minus
  i3-msg {scratchpad show,move scratchpad}

# focus/swap {{{

# focus the node in the given direction
super + {_,shift + }{h,j,k,l}
	i3-msg {focus,move} {left,down,up,right}

# focus the next/previous window in the current desktop
super + {_,shift + }c
	i3-msg focus mode_toggle

# focus the next/previous desktop in the current monitor
super + bracket{left,right}
	i3-msg workspace {prev,next}

# focus or send to the given desktop
super + {_,shift + }{1-9,0}
	i3-msg {workspace,move container to workspace} {1-9,10}

# }}}

# resize {{{

# expand a window by moving one of its side outward
super + alt + {h,j,k,l}
  i3-msg resize grow {left,down,up,right} 3 px or 3 ppt

# contract a window by moving one of its side inward
super + alt + shift + {h,j,k,l}
  i3-msg resize shrink {right,up,down,left} 3 px or 3 ppt

# balance node
# super + b
#   i3-msg node @/ -B

# }}}

# vim: foldmethod=marker foldlevel=0
