package haxe.ui.backend.winforms.size;

import haxe.ui.core.Component;
import haxe.ui.layouts.DelegateLayout.DelegateLayoutSize;

class PreferredSize extends DelegateLayoutSize {
    private override function get_width():Float {
        return component.control.PreferredSize.Width;
    }
    
    private override function get_height():Float {
        return component.control.PreferredSize.Height;
    }
}