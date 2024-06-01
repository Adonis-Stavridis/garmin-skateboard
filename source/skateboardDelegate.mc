import Toybox.Lang;
import Toybox.WatchUi;

class SkateboardDelegate extends WatchUi.BehaviorDelegate {

    // Refs
    private const _app = getApp();

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelect() as Boolean {
        _app.startStopActivity();
        return true;
    }

}
