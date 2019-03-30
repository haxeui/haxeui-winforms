package haxe.ui.backend;

import cs.system.windows.forms.Form;
import haxe.ui.core.Component;
import haxe.ui.events.UIEvent;

class ScreenImpl extends ScreenBase {
    public function new() {
    }
    
    private override function get_width():Float {
        return form.ClientSize.Width;
    }

    private override function get_height():Float {
        return form.ClientSize.Height;
    }

    public var form(get, null):Form;
    private function get_form():Form {
        if (options == null || options.form == null) {
            return null;
        }
        return  options.form;
    }

    private override function get_title():String {
        return form.Text;
    }
    private override function set_title(t:String):String {
        return form.Text = t;
    }
    
    private var __topLevelComponents:Array<Component> = new Array<Component>();
    public override function addComponent(component:Component) {
        __topLevelComponents.push(component);
        form.Controls.Add(component.control);
        resizeComponent(component);
    }

    public override function removeComponent(component:Component) {
        __topLevelComponents.remove(component);
        form.Controls.Remove(component.control);
    }

    private override function handleSetComponentIndex(child:Component, index:Int) {
    }

    private override function resizeComponent(c:Component) {
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
    private override function supportsEvent(type:String):Bool {
        return false;
    }

    private override function mapEvent(type:String, listener:UIEvent->Void) {
    }

    private override function unmapEvent(type:String, listener:UIEvent->Void) {
    }
}