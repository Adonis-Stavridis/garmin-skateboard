import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Timer;

const UPDATE_TIME = 1000;

class SkateboardApp extends Application.AppBase {

    // Refs
    private var _view;
    private var _stats;

    // Controllers
    private const _scheduler = new Timer.Timer();

    // State
    private var _isStarted = false;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        System.println("> Started application");
        
        _stats = new SkateboardStats();
        
        resetSchedule();
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        System.println("> Stopped application");
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        _view = new SkateboardView();
        return [ _view, new SkateboardDelegate() ];
    }

    function getView() as SkateboardView {
        return _view;
    }

    function resetSchedule() as Void {
        _scheduler.stop();
        _scheduler.start(method(:updateSchedule), UPDATE_TIME, true);
    }

    function updateSchedule() as Void {
        if (_isStarted) {
            _stats.incrementDuration();
        }
        WatchUi.requestUpdate();
    }

    function getStats() as SkateboardStats {
        return _stats;
    }

    function startStopActivity() as Void {
        if (!_isStarted) {
            System.println("> Started activity");
        } else {
            System.println("> Stopped activity");
        }
        _isStarted = !_isStarted;
        resetSchedule();
    }

}

function getApp() as SkateboardApp {
    return Application.getApp() as SkateboardApp;
}

function getView() as SkateboardView {
    return Application.getApp().getView() as SkateboardView;
}

function getStats() as SkateboardStats {
    return Application.getApp().getStats() as SkateboardStats;
}
