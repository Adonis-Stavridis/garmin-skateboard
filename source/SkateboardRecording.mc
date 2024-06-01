import Toybox.Lang;
import Toybox.Attention;
import Toybox.ActivityRecording;
import Toybox.System;

class SkateboardRecording {

    // Controllers
    private var _session;

    // State
    private var _seconds = 0;
    private var _hasPendingRecording = false;

    function initialize() {
        _session = ActivityRecording.createSession({
            :name => "Skateboard",
            :sport => Activity.SPORT_GENERIC, 
        });
    }

    function startStopRecording() as Void {
        if (!_session.isRecording()) {
            System.println("> Start recording");
            _session.start();
            Attention.playTone(Attention.TONE_START);
            _hasPendingRecording = true;
        } else {
            System.println("> Stop recording");
            _session.stop();
            Attention.playTone(Attention.TONE_STOP);
        }
    }

    function addLap() as Void {
        System.println("> Add lap");
        _session.addLap();
    }

    function update() as Void {
        if (!_session.isRecording()) {
            return;
        }

        _seconds++;
    }

    function saveRecording() as Void {
        _session.save();
        _hasPendingRecording = false;
    }

    function isRecording() as Boolean {
        return _session.isRecording();
    }
    
    function hasPendingRecording() as Boolean {
        return _hasPendingRecording;
    }

    function getSeconds() as Number {
        return _seconds;
    }
}
