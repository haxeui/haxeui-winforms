package haxe.ui.backend.winforms;

import cs.system.windows.forms.Control;

class StyleHelper {
    public static function apply(control:Control, style:String) {
        if (style == null) {
            return;
        }
        
        var styles = style.split(";");
        for (s in styles) {
            s = StringTools.trim(s);
            if (s.length == 0) {
                continue;
            }
            
            var parts = s.split(":");
            var name = StringTools.trim(parts[0]);
            var value = StringTools.trim(parts[1]);
            var resolved = resolveValue(value);
            if (resolved == null) {
                continue;
            }
            
            Reflect.setProperty(control, name, resolved);
        }
    }
    
    private static function resolveValue(v:String):Any {
        if (v == "true" || v == "false") {
            return (v == "true");
        } else {
            var p = v.split(".");
            var n = p.pop();
            v = p.join(".");
            var cls = Type.resolveEnum(v);
            if (cls == null) {
                return null;
            }
            var o = Type.createEnum(cls, n);
            if (o == null) {
                return null;
            }
            return o;
        }
        
        return null;
    }
}