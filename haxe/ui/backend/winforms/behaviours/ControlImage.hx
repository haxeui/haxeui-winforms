package haxe.ui.backend.winforms.behaviours;

import haxe.ui.core.DataBehaviour;
import haxe.ui.util.ImageLoader;

class ControlImage extends DataBehaviour {
    public override function validateData() {
        var imageLoader:ImageLoader = new ImageLoader(_value);
        imageLoader.load(function(imageInfo) {
            if (imageInfo != null) {
                if (Std.is(_component.control, cs.system.windows.forms.Button)) {
                    cast(_component.control, cs.system.windows.forms.Button).Image = imageInfo.data;
                } else  if (Std.is(_component.control, cs.system.windows.forms.PictureBox)) {
                    cast(_component.control, cs.system.windows.forms.PictureBox).Image = imageInfo.data;
                }
            }
        });
    }
}