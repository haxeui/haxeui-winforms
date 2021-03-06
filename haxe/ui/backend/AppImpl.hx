package haxe.ui.backend;

import cs.system.drawing.Size;
import cs.system.windows.forms.Application;
import cs.system.windows.forms.Form;

class AppImpl extends AppBase {
    private var _form:Form;
    private var _onEnd:Void->Void;
    
    public function new() {
        Application.EnableVisualStyles();
        Application.SetCompatibleTextRenderingDefault(false);
    }

    private override function build() {
        _form = new Form();
        _form.Text = Toolkit.backendProperties.getProp("haxe.ui.winforms.form.title", "");
    }

    private override function init(onReady:Void->Void, onEnd:Void->Void = null) {
        _onEnd = onEnd;
        
        var formAutoSize = Toolkit.backendProperties.getPropBool("haxe.ui.winforms.form.autosize", true);
        var formWidth:Int = Toolkit.backendProperties.getPropInt("haxe.ui.winforms.form.width", -1);
        var formHeight:Int = Toolkit.backendProperties.getPropInt("haxe.ui.winforms.form.height", -1);
        if (formWidth > 0 && formHeight > 0) {
            formAutoSize = false;
        }
        if (formAutoSize == false) {
            _form.Size = new Size(Std.int(formWidth), Std.int(formHeight));
        } else {
            _form.AutoSize = true;
        }
        
        onReady();
    }

    private override function getToolkitInit():ToolkitOptions {
        return {
            form: _form
        };
    }

    public override function start() {
        Application.Run(_form);
        if (_onEnd != null) {
            _onEnd();
        }
    }
}
