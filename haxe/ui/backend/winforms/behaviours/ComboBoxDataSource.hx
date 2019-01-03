package haxe.ui.backend.winforms.behaviours;

import haxe.ui.behaviours.DataBehaviour;
import haxe.ui.components.DropDown;
import haxe.ui.data.DataSource;

class ComboBoxDataSource extends DataBehaviour {
    public override function validateData() {
        var cb = cast(_component.control, cs.system.windows.forms.ComboBox);
        
        cb.Items.Clear();
        
        if (_value.isNull) {
            return;
        }
        
        var ds:DataSource<Dynamic> = _value;
        for (n in 0...ds.size) {
            var item = ds.get(n);
            if (item.value != null) {
                cb.Items.Add(item.value);
            } else {
                cb.Items.Add(Std.string(item));
            }
        }

        var dropDown:DropDown = cast(_component, DropDown);
        cb.SelectedIndex = dropDown.selectedIndex;
    }
}