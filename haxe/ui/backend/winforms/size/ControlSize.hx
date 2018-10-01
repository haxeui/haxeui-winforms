package haxe.ui.backend.winforms.size;

import haxe.ui.layouts.DelegateLayout.DelegateLayoutSize;

class ControlSize extends DelegateLayoutSize {
    private override function get_width():Float {
        return component.control.Size.Width;
    }
    
    private override function get_height():Float {
        return component.control.Size.Height;
    }
}