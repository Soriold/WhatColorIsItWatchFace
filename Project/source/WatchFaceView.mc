using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Math as Math;

class WatchFaceView extends Ui.WatchFace {

	var colors = [
		Gfx.COLOR_RED,
		Gfx.COLOR_DK_RED,
		Gfx.COLOR_ORANGE,
		Gfx.COLOR_YELLOW,
		Gfx.COLOR_GREEN,
		Gfx.COLOR_DK_GREEN,
		Gfx.COLOR_BLUE,
		Gfx.COLOR_DK_BLUE,
		Gfx.COLOR_PURPLE,
		Gfx.COLOR_PINK
	];
	var i = 0;
	var rectangle;

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
    	View.onUpdate(dc);

		dc.setColor(Gfx.COLOR_WHITE, colors[i]);
		dc.clear();
        i++;
        if( i == colors.size )
        {
        	i = 0;
        }

        var clockTime = Sys.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%.2d")]);
        var view = View.findDrawableById("TimeLabel");
        view.setText(timeString);
		dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2 - 15, Gfx.FONT_LARGE, timeString, Gfx.TEXT_JUSTIFY_CENTER);
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
