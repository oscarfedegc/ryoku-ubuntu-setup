from ranger.colorschemes.default import Default
from ranger.gui.color import green, cyan, yellow, red, bold


class Scheme(Default):
    def use(self, context):
        fg, bg, attr = Default.use(self, context)

        if context.directory:
            fg = green
            attr |= bold

        if context.link:
            fg = cyan

        if context.executable and not context.directory:
            fg = green
            attr |= bold

        if context.marked:
            fg = yellow
            attr |= bold

        if context.bad:
            fg = red

        if context.selected:
            attr |= bold

        return fg, bg, attr
