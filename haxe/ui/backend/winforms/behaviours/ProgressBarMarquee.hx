package haxe.ui.backend.winforms.behaviours;

import haxe.ui.behaviours.Behaviour;
import haxe.ui.util.Variant;
import cs.system.windows.forms.ProgressBar;
import cs.system.windows.forms.ProgressBarStyle;

class ProgressBarMarquee extends Behaviour {
    public override function set(value:Variant) {
        if (Std.is(_component.control, ProgressBar)) {
            var p:ProgressBar = cast(_component.control, ProgressBar);
            if (value == true) {
                p.Style = ProgressBarStyle.Marquee;
            } else {
                p.Style = ProgressBarStyle.Continuous;
            }
        }
    }
    
    public override function get():Variant {
        if (Std.is(_component.control, ProgressBar) == false) {
            return false;
        }
        
        var p:ProgressBar = cast(_component.control, ProgressBar);
        return (p.Style == ProgressBarStyle.Marquee);
    }
}