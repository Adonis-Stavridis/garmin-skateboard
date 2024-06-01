import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Lang;
import Toybox.Timer;

class SkateboardView extends WatchUi.View {

    // Refs
    private const _recording = getRecording();

    // Controllers
    private var _durationElement;
    private var _clockElement;
    
    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));

        _durationElement = View.findDrawableById("Duration");
        _clockElement = View.findDrawableById("Clock");
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        drawDuration();
        drawClock();

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    private function drawDuration() as Void {
        var duration = _recording.getSeconds();
        var minutes = duration / 60;
        var seconds = duration % 60;
        var timeString = Lang.format(
            "$1$:$2$",
            [minutes, seconds.format("%02d")]
        );
        _durationElement.setText(timeString);
    }

    private function drawClock() as Void {
        var clockTime = System.getClockTime();
        var timeString = Lang.format(
            "$1$:$2$",
            [clockTime.hour, clockTime.min.format("%02d")]
        );
        _clockElement.setText(timeString);
    }

}
