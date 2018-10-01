package haxe.ui.backend.winforms.behaviours;

import haxe.ui.core.DataBehaviour;

class ControlMax extends DataBehaviour {
    public override function validateData() {
        if (_value == null || _value.isNull == true) {
            return;
        }
        
        if (Std.is(_component.control, cs.system.windows.forms.ProgressBar)) {
            cast(_component.control, cs.system.windows.forms.ProgressBar).Maximum = _value;
        } else if (Std.is(_component.control, cs.system.windows.forms.TrackBar)) {
            cast(_component.control, cs.system.windows.forms.TrackBar).Maximum = _value;
        }
    }
}