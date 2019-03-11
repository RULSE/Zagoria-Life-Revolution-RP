class factorywork_dialog
{
	idd = 50006;
	movingEnable = true;
	controlsBackground[] = {background};	
	objects[] = { };		
	controls[] = {joblist, work, close};	
		
	class background: IGUIBack
	{
		idc = 2200;
		x = 14 * GUI_GRID_W + GUI_GRID_X;
		y = 0 * GUI_GRID_H + GUI_GRID_Y;
		w = 12 * GUI_GRID_W;
		h = 25 * GUI_GRID_H;
	};
	class joblist: RscListbox
	{
		idc = 1500;
		x = 15 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 19 * GUI_GRID_H;
	};
	class work: RscButton
	{
		idc = 1600;
		text = "Работать"; //--- ToDo: Localize;
		x = 15 * GUI_GRID_W + GUI_GRID_X;
		y = 21 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "(lbCurSel 1500) spawn fnc_work;";
	};
	class close: RscButton
	{
		idc = 1601;
		text = "Закрыть"; //--- ToDo: Localize;
		x = 15 * GUI_GRID_W + GUI_GRID_X;
		y = 23 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0;";
	};
	
};