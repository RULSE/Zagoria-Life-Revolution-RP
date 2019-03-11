class elections_dialog
{
	idd = 50004;
	movingEnable = true;
	controlsBackground[] = {background};	
	objects[] = { };		
	controls[]=
	{
		playerlist,
		vote,
		close
	};

	class background: IGUIBack
	{
		idc = 2200;
		x = 5 * GUI_GRID_W + GUI_GRID_X;
		y = 0 * GUI_GRID_H + GUI_GRID_Y;
		w = 30 * GUI_GRID_W;
		h = 24 * GUI_GRID_H;
	};
	class playerlist: RscListbox
	{
		idc = 1500;
		x = 6 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 28 * GUI_GRID_W;
		h = 20 * GUI_GRID_H;
	};
	class vote: RscButton
	{
		idc = 1600;
		text = "Голосовать"; //--- ToDo: Localize;
		x = 6 * GUI_GRID_W + GUI_GRID_X;
		y = 22 * GUI_GRID_H + GUI_GRID_Y;
		w = 13.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "[] spawn fnc_voteGovernor;";
	};
	class close: RscButton
	{
		idc = 1601;
		text = "close"; //--- ToDo: Localize;
		x = 20.5 * GUI_GRID_W + GUI_GRID_X;
		y = 22 * GUI_GRID_H + GUI_GRID_Y;
		w = 13.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0;";
	};

};