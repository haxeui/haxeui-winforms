package haxe.ui.backend.winforms.behaviours;

import haxe.ui.behaviours.DataBehaviour;

class ControlMin extends DataBehaviour {
    public override function validateData() {
        if (_value == null || _value.isNull == true) {
            return;
        }
        
        if (Std.is(_component.control, cs.system.windows.forms.ProgressBar)) {
            cast(_component.control, cs.system.windows.forms.ProgressBar).Minimum = _value;
        } else if (Std.is(_component.control, cs.system.windows.forms.TrackBar)) {
            cast(_component.control, cs.system.windows.forms.TrackBar).Minimum = _value;
        }
    }
}