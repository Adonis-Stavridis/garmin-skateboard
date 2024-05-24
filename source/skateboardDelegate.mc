import Toybox.Lang;
import Toybox.WatchUi;

class skateboardDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new skateboardMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}