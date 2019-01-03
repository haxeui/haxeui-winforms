package haxe.ui.backend;

import haxe.ui.core.Component;
import haxe.ui.events.UIEvent;
import cs.system.windows.forms.Form;

class ScreenBase {
    public function new() {
    }

    public var focus:Component;

    private var _options:Dynamic;
    public var options(get, set):Dynamic;
    private function get_options():Dynamic {
        return _options;
    }
    private function set_options(value:Dynamic):Dynamic {
        _options = value;
        return value;
    }

    public var width(get, null):Float;
    private function get_width():Float {
        return form.ClientSize.Width;
    }

    public var height(get, null):Float;
    private function get_height():Float {
        return form.ClientSize.Height;
    }

    public var dpi(get, null):Float;
    private function get_dpi():Float {
        return 72;
    }

    public var form(get, null):Form;
    private function get_form():Form {
        if (options == null || options.form == null) {
            return null;
        }
        return  options.form;
    }

    public var title(get, set):String;
    private inline function get_title():String {
        return form.Text;
    }
    private inline function set_title(t:String):String {
        return form.Text = t;
    }
    
    private var __topLevelComponents:Array<Component> = new Array<Component>();
    public function addComponent(component:Component) {
        __topLevelComponents.push(component);
        form.Controls.Add(component.control);
        resizeComponent(component);
    }

    public function removeComponent(component:Component) {
        __topLevelComponents.remove(component);
        form.Controls.Remove(component.control);
    }

    private function handleSetComponentIndex(child:Component, index:Int) {
    }

    private function resizeComponent(c:Component) {
        //c.lock();
        var cx:Null<Float> = null;
        var cy:Null<Float> = null;

        if (c.percentWidth > 0) {
            cx = (this.width * c.percentWidth) / 100;
        }
        if (c.percentHeight > 0) {
            cy = (this.height * c.percentHeight) / 100;
        }
        c.resizeComponent(cx, cy);
    }
    
    //***********************************************************************************************************
    // Events
    //***********************************************************************************************************
    private function supportsEvent(type:String):Bool {
        return false;
    }

    private function mapEvent(type:String, listener:UIEvent->Void) {
    }

    private function unmapEvent(type:String, listener:UIEvent->Void) {
    }
}