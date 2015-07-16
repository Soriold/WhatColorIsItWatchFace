using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Math as Math;

class WatchFaceView extends Ui.WatchFace {

	var i = 0;
	var rectangle;
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
    	i++;
    	View.onUpdate(dc);

		dc.setColor(Gfx.COLOR_WHITE, colors[i]);
		dc.clear();
        
        if( i == colors.size() )
        {
        	i = 0;
        }

		// Puts the current time on the screen
        var clockTime = Sys.getClockTime();
        var hour = clockTime.hour;
        if (hour > 12)
        {
        	hour -= 12;
        }
        var timeString = Lang.format("$1$:$2$", [hour, clockTime.min.format("%.2d")]);
        
        // Step counter code
        var numSteps = ActivityMonitor.getInfo().steps;
        var stepGoal = ActivityMonitor.getInfo().stepGoal;
        var percentOfGoal = numSteps / stepGoal * 100;
        var stepBarHeight = 10;
        
        percentOfGoal = percentOfGoal.toString();
		numSteps = numSteps.toString();
        System.println(percentOfGoal);
        
        //dc.getHeight() - stepBarHeight

		dc.setColor(Gfx.COLOR_WHITE, colors[i]);
		dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Gfx.FONT_NUMBER_HOT, timeString, Gfx.TEXT_JUSTIFY_CENTER);
    	dc.drawText(dc.getWidth() / 2, 5, Gfx.FONT_NUMBER_HOT, numSteps, Gfx.TEXT_JUSTIFY_CENTER);
    	
    	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_WHITE);
    	// Docs are wrong, this uses background color
    	dc.fillRectangle(dc.getWidth() / 2, dc.getHeight() / 2, 100, 20); 
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
