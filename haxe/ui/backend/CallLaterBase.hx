package haxe.ui.backend;

class CallLaterBase {
    public function new(fn:Void->Void) {
        fn();
    }
}
