package haxe.ui.backend.winforms.custom;

import cs.system.windows.forms.ProgressBar;

@:keep
@:nativeGen
@:classCode("protected override System.Windows.Forms.CreateParams CreateParams { get { System.Windows.Forms.CreateParams cp = base.CreateParams; cp.Style |= 0x04; return cp; } }\n\n")
class VerticalProgressBar extends ProgressBar {
}