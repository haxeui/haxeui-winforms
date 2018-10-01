package haxe.ui.backend.winforms.behaviours;

import haxe.ui.core.DataBehaviour;

class ControlText extends DataBehaviour {
    public override function validateData() {
        trace("setting to: " + _value);
        _component.control.Text = _value;
        //_component.invalidateLayout();
    }
}
