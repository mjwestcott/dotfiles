from __future__ import (absolute_import, division, print_function)

from ranger.colorschemes.default import Default
from ranger.gui.color import green, red, blue, normal, bold, reverse


class Scheme(Default):
    progress_bar_color = green

    def use(self, context):
        fg, bg, attr = Default.use(self, context)

        if (
            not context.marked
            and not context.link
            and not context.inactive_pane
        ):
            if context.directory:
                fg = blue
            elif context.executable:
                fg = green

            if context.selected:
                attr = reverse
            else:
                attr = normal

        if context.in_titlebar:
            attr = normal

            if context.hostname:
                fg = red if context.bad else green

        return fg, bg, attr
