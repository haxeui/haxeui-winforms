package haxe.ui.backend;

import cs.system.drawing.Color;
import cs.system.drawing.Font;
import cs.system.drawing.Image;
import cs.system.drawing.Point;
import cs.system.drawing.Size;
import cs.system.io.MemoryStream;
import cs.system.windows.forms.Control;
import cs.system.windows.forms.ImageList;
import cs.system.windows.forms.Panel;
import haxe.ui.backend.winforms.StyleHelper;
import haxe.ui.containers.Box;
import haxe.ui.core.Component;
import haxe.ui.core.ImageDisplay;
import haxe.ui.core.MouseEvent;
import haxe.ui.core.TextDisplay;
import haxe.ui.core.TextInput;
import haxe.ui.core.UIEvent;
import haxe.ui.styles.Style;
import haxe.ui.util.Rectangle;

class ComponentBase {
    private var _eventMap:Map<String, UIEvent->Void> = new Map<String, UIEvent->Void>();

    public var control:Control;
    
    public function new() {
    }

    public function handleCreate(native:Bool) {
        var className:String = Type.getClassName(Type.getClass(this));
        var nativeComponentClass:String = Toolkit.nativeConfig.query('component[id=${className}].@class', 'System.Windows.Forms.Panel', null);
        
        var style:String = Toolkit.nativeConfig.query('component[id=${className}].@style', null, null);
        control = Type.createInstance(Type.resolveClass(nativeComponentClass), []);
        StyleHelper.apply(control, style);
        if (Std.is(control, cs.system.windows.forms.TabControl)) {
            var tabControl = cast(control, cs.system.windows.forms.TabControl);
            tabControl.Padding = new Point(6, 5);
            //tabControl.SizeMode = cs.system.windows.forms.TabSizeMode.Fixed;
        } else if (Std.is(this, haxe.ui.containers.ScrollView)) {
            cast(control, cs.system.windows.forms.Panel).AutoScroll = true;
        }
    }

    private function handlePosition(left:Null<Float>, top:Null<Float>, style:Style) {
        if (control == null) {
            return;
        }
        
        control.Location = new Point(Std.int(left), Std.int(top));
    }

    private function handleSize(width:Null<Float>, height:Null<Float>, style:Style) {
        if (control == null) {
            return;
        }
        
        if (Std.is(control, cs.system.windows.forms.Label) && cast(this, Component).autoWidth == false) { // TODO: not ideal
            control.MaximumSize = new cs.system.drawing.Size(Std.int(width), 0);
            control.AutoSize = true;
            cast(this, Component).invalidateComponentLayout();
        }
        
        control.Size = new Size(Std.int(width), Std.int(height));
    }

    private function handleReady() {
        if (Std.is(control, cs.system.windows.forms.TrackBar)) { // super crappy hack, trackbars _always_ have a grey background... if you can believe that! 
            var parent = findParent(cs.system.windows.forms.TabControl);
            if (parent != null) {
                control.BackColor = Color.White;
            }
        }
    }

    private function handleClipRect(value:Rectangle) {
    }

    public function handlePreReposition() {
    }

    public function handlePostReposition() {
    }

    private function handleVisibility(show:Bool) {
    }

    //***********************************************************************************************************
    // Text related
    //***********************************************************************************************************
    private var _textDisplay:TextDisplay;
    public function createTextDisplay(text:String = null):TextDisplay {
        if (_textDisplay == null) {
            _textDisplay = new TextDisplay();
        }
        if (text != null) {
            _textDisplay.text = text;
        }
        return _textDisplay;
    }

    public function getTextDisplay():TextDisplay {
        return createTextDisplay();
    }

    public function hasTextDisplay():Bool {
        return (_textDisplay != null);
    }

    private var _textInput:TextInput;
    public function createTextInput(text:String = null):TextInput {
        if (_textInput == null) {
            _textInput = new TextInput();
        }
        if (text != null) {
            _textInput.text = text;
        }
        return _textInput;
    }

    public function getTextInput():TextInput {
        return createTextInput();
    }

    public function hasTextInput():Bool {
        return (_textInput != null);
    }

    //***********************************************************************************************************
    // Image related
    //***********************************************************************************************************
    private var _imageDisplay:ImageDisplay;
    public function createImageDisplay():ImageDisplay {
        if (_imageDisplay == null) {
            _imageDisplay = new ImageDisplay();
        }
        return _imageDisplay;
    }

    public function getImageDisplay():ImageDisplay {
        return createImageDisplay();
    }

    public function hasImageDisplay():Bool {
        return (_imageDisplay != null);
    }

    public function removeImageDisplay() {
        if (_imageDisplay != null) {
            _imageDisplay = null;
        }
    }

    //***********************************************************************************************************
    // Display tree
    //***********************************************************************************************************
    private function handleSetComponentIndex(child:Component, index:Int) {

    }

    private function handleAddComponent(child:Component):Component {
        if (Std.is(this.control, cs.system.windows.forms.TabControl)) {
            var tabControl = cast(this.control, cs.system.windows.forms.TabControl);
            
            var page = new cs.system.windows.forms.TabPage();
            page.Text = child.text;
            page.UseVisualStyleBackColor = true;
            
            if (Std.is(child, Box)) {
                var box = cast(child, Box);
                box.addClass("tabview-content");
                if (box.icon != null) {
                    if (tabControl.ImageList == null) {
                        tabControl.ImageList = new ImageList();
                    }
                    var bytes = Resource.getBytes(box.icon);
                    var stream = new MemoryStream(bytes.getData());
                    var image = Image.FromStream(stream);
                    tabControl.ImageList.Images.Add(box.icon, image);
                    page.ImageIndex = tabControl.ImageList.Images.Count - 1;
                }
            }
            
            page.Controls.Add(child.control);
            tabControl.TabPages.Add(page);
        } else {
            control.Controls.Add(child.control);
        }
        return child;
    }

    private function handleAddComponentAt(child:Component, index:Int):Component {
        return child;
    }
    
    private function handleRemoveComponent(child:Component, dispose:Bool = true):Component {
        control.Controls.Remove(child.control);
        return child;
    }
    
    private function handleRemoveComponentAt(index:Int, dispose:Bool = true):Component {
        return null;
    }

    private function applyStyle(style:Style) {
        if (control == null) {
            return;
        }
        
        if (style.backgroundColor != null) {
            var c:haxe.ui.util.Color = style.backgroundColor;
            control.BackColor = Color.FromArgb(c.r, c.g, c.b);
        }
        
        if (style.color != null) {
            var c:haxe.ui.util.Color = style.color;
            control.ForeColor = Color.FromArgb(c.r, c.g, c.b);
        }
        
        if (style.iconPosition != null && Std.is(control, cs.system.windows.forms.Button)) {
            var button = cast(control, cs.system.windows.forms.Button);
            switch (style.iconPosition) {
                case "top":
                    button.TextImageRelation = cs.system.windows.forms.TextImageRelation.ImageAboveText;
                case "left":
                    button.TextImageRelation = cs.system.windows.forms.TextImageRelation.ImageBeforeText;
                case "bottom":
                    button.TextImageRelation = cs.system.windows.forms.TextImageRelation.TextAboveImage;
                case "right":
                    button.TextImageRelation = cs.system.windows.forms.TextImageRelation.TextBeforeImage;
                case _:
                    button.TextImageRelation = cs.system.windows.forms.TextImageRelation.ImageBeforeText;
            }
        }
        
        if (style.fontSize != null) {
            var fontSize = style.fontSize;
            var font = new Font(control.Font.FontFamily, fontSize);
            control.Font = font;
        }
        
        if (Std.is(control, Panel) && style.borderLeftSize != null && style.borderLeftSize > 0) {
            //cast(control, Panel).BorderStyle = BorderStyle.Fixed3D;
        }
    }

    //***********************************************************************************************************
    // Events
    //***********************************************************************************************************
    private function mapEvent(type:String, listener:UIEvent->Void) {
        switch (type) {
            case MouseEvent.CLICK:
                if (_eventMap.exists(type) == false) {
                    _eventMap.set(type, listener);
                    control.add_Click(___onClick);
                }
                
            case UIEvent.CHANGE:
                if (_eventMap.exists(type) == false) {
                    _eventMap.set(type, listener);
                    if (Std.is(control, cs.system.windows.forms.TrackBar)) {
                        cast(control, cs.system.windows.forms.TrackBar).add_ValueChanged(___onChange);
                    } else if (Std.is(control, cs.system.windows.forms.CheckBox)) {
                        cast(control, cs.system.windows.forms.CheckBox).add_CheckedChanged(___onChange);
                    }
                }
                
        }
    }

    private function unmapEvent(type:String, listener:UIEvent->Void) {
        switch (type) {
            case MouseEvent.CLICK:
                _eventMap.remove(type);
                control.remove_Click(___onClick);
                
            case UIEvent.CHANGE:
                _eventMap.remove(type);
                if (Std.is(control, cs.system.windows.forms.TrackBar)) {
                    cast(control, cs.system.windows.forms.TrackBar).remove_ValueChanged(___onChange);
                }
        }
    }
    
    private function ___onClick(sender:Dynamic, e:cs.system.EventArgs) {
        var fn:UIEvent->Void = _eventMap.get(MouseEvent.CLICK);
        if (fn != null) {
            fn(new MouseEvent(MouseEvent.CLICK));
        }
    }
    
    private function ___onChange(sender:Dynamic, e:cs.system.EventArgs) {
        var fn:UIEvent->Void = _eventMap.get(UIEvent.CHANGE);
        if (fn != null) {
            fn(new UIEvent(UIEvent.CHANGE));
        }
    }
    
    //***********************************************************************************************************
    // Helpers
    //***********************************************************************************************************
     private function findParent(cls:Class<Control>):Control {
        var r:Control = null;
        var p:Control = control.Parent;
        while (p != null) {
            if (Std.is(p, cls)) {
                r = p;
                break;
            }
            p = p.Parent;
        }
        return r;
    }
}