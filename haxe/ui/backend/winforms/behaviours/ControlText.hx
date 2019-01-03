package haxe.ui.backend.winforms.behaviours;

import haxe.ui.behaviours.DataBehaviour;

class ControlText extends DataBehaviour {
    public override function validateData() {
        var text:String = _value;
        text = StringTools.replace(text, "\\n", "\r\n");
        _component.control.Text = text;
    }
}
