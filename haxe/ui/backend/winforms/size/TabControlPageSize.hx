package haxe.ui.backend.winforms.size;

import haxe.ui.layouts.DelegateLayout.DelegateLayoutSize;

class TabControlPageSize extends DelegateLayoutSize {
    private override function get_width():Float {
        return component.control.PreferredSize.Width;
    }
    
    private override function get_height():Float {
        return component.control.PreferredSize.Height;
    }

    private override function get_usableWidthModifier():Float {
        var m:Int = 8;
        return m;
    }

    private override function get_usableHeightModifier():Float {
        var m:Int = 32; // TODO: magic number
        return m;
    }
}