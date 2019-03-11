class paintjob_dialog
{
	idd = 50016;
	movingEnable = true;
	controlsBackground[] = {background};	
	objects[] = { };		
	controls[]=
	{
		paintlist,
		paint,
		close
	};

	class background: IGUIBack
	{
		idc = 2200;
		x = 5 * GUI_GRID_W + GUI_GRID_X;
		y = 0 * GUI_GRID_H + GUI_GRID_Y;
		w = 30 * GUI_GRID_W;
		h = 25 * GUI_GRID_H;
	};
	class paintlist: RscListbox
	{
		idc = 1500;
		x = 6 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 28 * GUI_GRID_W;
		h = 21 * GUI_GRID_H;
	};
	class paint: RscButton
	{
		idc = 1600;
		text = "Paint it"; //--- ToDo: Localize;
		x = 6 * GUI_GRID_W + GUI_GRID_X;
		y = 23 * GUI_GRID_H + GUI_GRID_Y;
		w = 13.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "[] spawn fnc_paintJobDoIt;";
	};
	class close: RscButton
	{
		idc = 1601;
		text = "Close"; //--- ToDo: Localize;
		x = 20.5 * GUI_GRID_W + GUI_GRID_X;
		y = 23 * GUI_GRID_H + GUI_GRID_Y;
		w = 13.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0;";
	};



};