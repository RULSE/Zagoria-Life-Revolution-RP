
class search_dialog
{
	idd = 50018;
	movingEnable = true;
	controlsBackground[] = {background};	
	objects[] = { };		
	controls[] = {itemlist, close};	

	class background: IGUIBack
	{
		idc = 2200;
		x = 10 * GUI_GRID_W + GUI_GRID_X;
		y = 0 * GUI_GRID_H + GUI_GRID_Y;
		w = 22 * GUI_GRID_W;
		h = 25 * GUI_GRID_H;
	};
	class itemlist: RscListbox
	{
		idc = 1500;
		x = 11 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 20 * GUI_GRID_W;
		h = 21 * GUI_GRID_H;
	};
	class close: RscButton
	{
		idc = 1600;
		text = "Закрыть"; //--- ToDo: Localize;
		x = 16 * GUI_GRID_W + GUI_GRID_X;
		y = 23 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0";
	};

};