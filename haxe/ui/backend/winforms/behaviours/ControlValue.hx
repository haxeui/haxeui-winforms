package haxe.ui.backend.winforms.behaviours;

import haxe.ui.core.DataBehaviour;
import haxe.ui.util.Variant;

class ControlValue extends DataBehaviour {
    public override function validateData() {
        if (_value == null || _value.isNull == true) {
            return;
        }
        
        if (Std.is(_component.control, cs.system.windows.forms.ProgressBar)) {
            cast(_component.control, cs.system.windows.forms.ProgressBar).Value = _value;
        } else if (Std.is(_component.control, cs.system.windows.forms.TrackBar)) {
            cast(_component.control, cs.system.windows.forms.TrackBar).Value = _value;
        }
    }
    
    public override function get():Variant {
        var v:Variant = null;
        if (Std.is(_component.control, cs.system.windows.forms.ProgressBar)) {
            v = cast(_component.control, cs.system.windows.forms.ProgressBar).Value;
        } else if (Std.is(_component.control, cs.system.windows.forms.TrackBar)) {
            v = cast(_component.control, cs.system.windows.forms.TrackBar).Value;
        }
        return v;
    }
}