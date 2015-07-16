using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Math as Math;

class WatchFaceView extends Ui.WatchFace {

	var colors = [ Gfx.COLOR_RED, Gfx.COLOR_DK_RED, Gfx.COLOR_ORANGE, Gfx.COLOR_YELLOW, Gfx.COLOR_GREEN,
					Gfx.COLOR_DK_GREEN, Gfx.COLOR_BLUE, Gfx.COLOR_DK_BLUE, Gfx.COLOR_PURPLE, Gfx.COLOR_PINK ];
	var i = 0;

    //! Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This includes
    //! loading resources into memory.
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
        // Get and show the current time
        var clockTime = Sys.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%.2d")]);
        var view = View.findDrawableById("TimeLabel");
        view.setText(timeString);

        var hour = clockTime.hour;
        var min = clockTime.min;
        var sec = clockTime.sec;

        var color = hour.format("%i") + min.format("%i") + sec.format("%i");

        var hex = color.toNumber().toLong();

        var layout = View.findDrawableById("WatchFace");
        view.setColor( colors[i] );
        i++;

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    }

    //! The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    //! Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
