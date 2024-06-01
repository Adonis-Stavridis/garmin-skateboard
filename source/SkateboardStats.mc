import Toybox.Lang;

class SkateboardStats {

	// State
	private var _duration = 0;

	function initialize() {}

	function getDuration() as Number {
		return _duration;
	}

	function incrementDuration() as Void {
		_duration++;
	}

}
