package haxe.ui.backend.winforms.behaviours;

import haxe.ui.behaviours.DataBehaviour;

class SelectedIndex extends DataBehaviour {
    public override function validateData() {
        var cb = cast(_component.control, cs.system.windows.forms.ComboBox);
        cb.SelectedIndex = _value;
    }
}