using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Math as Math;
using Toybox.ActivityMonitor as AM;

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
	var smilies = new[6];

    //! Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));

        smilies[0] = Ui.loadResource(Rez.Drawables.level_0);
        smilies[1] = Ui.loadResource(Rez.Drawables.level_1);
        smilies[2] = Ui.loadResource(Rez.Drawables.level_2);
        smilies[3] = Ui.loadResource(Rez.Drawables.level_3);
        smilies[4] = Ui.loadResource(Rez.Drawables.level_4);
        smilies[5] = Ui.loadResource(Rez.Drawables.level_5);
    }

    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This includes
    //! loading resources into memory.
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc)
    {
    	View.onUpdate(dc);

		dc.setColor(Gfx.COLOR_WHITE, colors[i]);
		dc.clear();

        var clockTime = Sys.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%.2d")]);
        var view = View.findDrawableById("TimeLabel");
        view.setText(timeString);
		dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2 - 20, Gfx.FONT_NUMBER_HOT, timeString, Gfx.TEXT_JUSTIFY_CENTER);

		var info = AM.getInfo();
		var level = info.moveBarLevel;
		var width = (dc.getWidth() - 20) / 7;

		if( level == 0 )
		{
			dc.setColor(colors[i], colors[i]);
			dc.fillCircle( (width*5) + 53, 20, 20 );
			dc.drawBitmap( (width*5) + 38, 5, smilies[0]);
		}
		if( level > 0 )
		{
			dc.setColor(colors[i], colors[i]);
			dc.fillCircle( (width*5) + 53, 20, 20 );
			dc.drawBitmap( (width*5) + 38, 5, smilies[1]);
			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_WHITE);
			dc.fillRectangle(10, 15, width, 10);
		}
		if( level > 1 )
		{
			dc.setColor(colors[i], colors[i]);
			dc.fillCircle( (width*5) + 53, 20, 20 );
			dc.drawBitmap( (width*5) + 38, 5, smilies[2]);
			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_WHITE);
			dc.fillRectangle(10 + width + 5, 15, width, 10);
		}
		if( level > 2 )
		{
			dc.setColor(colors[i], colors[i]);
			dc.fillCircle( (width*5) + 53, 20, 20 );
			dc.drawBitmap( (width*5) + 38, 5, smilies[3]);
			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_WHITE);
			dc.fillRectangle(10 + (2*width) + 10, 15, width, 10);
		}
		if( level > 3 )
		{
			dc.setColor(colors[i], colors[i]);
			dc.fillCircle( (width*5) + 53, 20, 20 );
			dc.drawBitmap( (width*5) + 38, 5, smilies[4]);
			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_WHITE);
			dc.fillRectangle(10 + (3*width) + 15, 15, width, 10);
		}
		if( level > 4 )
		{
			dc.setColor(colors[i], colors[i]);
			dc.fillCircle( (width*5) + 53, 20, 20 );
			dc.drawBitmap( (width*5) + 38, 5, smilies[5]);
			dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_WHITE);
			dc.fillRectangle(10 + (4*width) + 20, 15, width, 10);
		}

		dc.setColor(Gfx.COLOR_BLACK, colors[i]);
		dc.drawRectangle(10, 15, width, 10);
		dc.drawRectangle(10 + width + 5, 15, width, 10);
		dc.drawRectangle(10 + (2*width) + 10, 15, width, 10);
		dc.drawRectangle(10 + (3*width) + 15, 15, width, 10);
		dc.drawRectangle(10 + (4*width) + 20, 15, width, 10);

		// Step counter code
        var numSteps = AM.getInfo().steps.toDouble();
        var stepGoal = AM.getInfo().stepGoal.toDouble();
        var percentOfGoal = numSteps / stepGoal;
        if( numSteps > stepGoal )
        {
        	percentOfGoal = 1;
        }
        var stepBarHeight = 10;

		numSteps = numSteps.format("%i");

        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_WHITE);
    	// Docs are wrong, this uses background color
		dc.fillRectangle( 5, dc.getHeight() - 25, dc.getWidth() * percentOfGoal - 10, 20);

		dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    	dc.drawText(dc.getWidth() / 2, dc.getHeight() - 25, Gfx.FONT_SMALL, numSteps, Gfx.TEXT_JUSTIFY_CENTER);
    	dc.drawRectangle( 5, dc.getHeight() - 25, dc.getWidth() - 10, 20);

		i++;
        if( i == colors.size() )
        {
        	i = 0;
        }
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
