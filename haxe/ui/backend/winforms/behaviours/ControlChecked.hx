package haxe.ui.backend.winforms.behaviours;

import haxe.ui.behaviours.Behaviour;
import haxe.ui.util.Variant;

class ControlChecked extends Behaviour {
    public override function set(value:Variant) {
        if (value == null || value.isNull == true) {
            return;
        }
        
        if (Std.is(_component.control, cs.system.windows.forms.CheckBox)) {
            cast(_component.control, cs.system.windows.forms.CheckBox).Checked = value;
        } else if (Std.is(_component.control, cs.system.windows.forms.RadioButton)) {
            cast(_component.control, cs.system.windows.forms.RadioButton).Checked = value;
        }
    }

    public override function get():Variant {
        var v:Variant = null;
        if (Std.is(_component.control, cs.system.windows.forms.CheckBox)) {
            v = cast(_component.control, cs.system.windows.forms.CheckBox).Checked;
        } else if (Std.is(_component.control, cs.system.windows.forms.RadioButton)) {
            v = cast(_component.control, cs.system.windows.forms.RadioButton).Checked;
        }
        return v;
    }
}