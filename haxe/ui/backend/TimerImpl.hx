package haxe.ui.backend;

import cs.system.windows.forms.Timer;
import cs.system.EventHandler;
import cs.system.EventArgs;

class TimerImpl {
    private var _timer:Timer;
    private var _callback:Void->Void;

    public function new(delay:Int, callback:Void->Void) {
        _callback = callback;
        _timer = new Timer();
        _timer.add_Tick(new EventHandler(onTimerTick));
        _timer.Interval = delay * 1000;
        _timer.Start();
    }

    private function onTimerTick(sender:Dynamic, e:EventArgs) {
        if (_callback != null) {
            _callback();
        }
        stop();
    }
    
    public function stop() {
        if (_timer != null) {
            _timer.Stop();
            _timer.remove_Tick(new EventHandler(onTimerTick));
            _timer = null;
        }
    }
}
