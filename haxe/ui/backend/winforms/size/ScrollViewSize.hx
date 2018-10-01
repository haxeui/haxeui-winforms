package haxe.ui.backend.winforms.size;

import haxe.ui.layouts.DelegateLayout.DelegateLayoutSize;

class ScrollViewSize extends DelegateLayoutSize {
    private override function get_width():Float {
        var w = component.control.PreferredSize.Width;
        return w;
    }
    
    private override function get_height():Float {
        var h = component.control.PreferredSize.Height;
        return h;
    }

    private override function get_usableWidthModifier():Float {
        var m:Int = 16;
        return m;
    }

    private override function get_usableHeightModifier():Float {
        var m:Int = 16;
        return m;
    }
}