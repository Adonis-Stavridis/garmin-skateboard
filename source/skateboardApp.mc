import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Timer;

const UPDATE_TIME = 1000;

class SkateboardApp extends Application.AppBase {

    // Refs
    private var _view;
    private var _recording;

    // Controllers
    private const _scheduler = new Timer.Timer();

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        System.println("> Started application");
        
        _recording = new SkateboardRecording();
        _scheduler.start(method(:updateSchedule), UPDATE_TIME, true);
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
    
    function getRecording() as SkateboardRecording {
        return _recording;
    }

    function updateSchedule() as Void {
        _recording.update();
        WatchUi.requestUpdate();
    }

    function onStartStopSelect() as Void {
        // handle select if in other view
        _recording.startStopRecording();
        WatchUi.requestUpdate();
    }

    function onLapBack() as Boolean {
        if (_recording.isRecording()) {
            _recording.addLap();
            WatchUi.requestUpdate();
            return true;
        }
        if (_recording.hasPendingRecording()) {
            // handle unsaved recording
            System.println("> Has unsaved recording");
            return false;
        }
        return false;
    }

}

function getApp() as SkateboardApp {
    return Application.getApp() as SkateboardApp;
}

function getView() as SkateboardView {
    return Application.getApp().getView() as SkateboardView;
}

function getRecording() as SkateboardRecording {
    return Application.getApp().getRecording() as SkateboardRecording;
}
