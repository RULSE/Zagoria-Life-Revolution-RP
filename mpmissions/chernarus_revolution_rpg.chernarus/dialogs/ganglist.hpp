
class ganglist_menu_dialog
{
	idd = 50008;
	movingEnable = true;
	controlsBackground[] = {background};	
	objects[] = { };		
	controls[]=
	{
		ganglist,
		close,
		creategang,
		joingang
		
	};

	class background: IGUIBack
	{
		idc = 2200;
		x = 0 * GUI_GRID_W + GUI_GRID_X;
		y = 0 * GUI_GRID_H + GUI_GRID_Y;
		w = 40 * GUI_GRID_W;
		h = 25 * GUI_GRID_H;
	};
	class ganglist: RscListbox
	{
		idc = 1500;
		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 21 * GUI_GRID_W;
		h = 23 * GUI_GRID_H;
	};
	class close: RscButton
	{
		idc = 1600;
		text = "Закрыть"; //--- ToDo: Localize;
		x = 23 * GUI_GRID_W + GUI_GRID_X;
		y = 23 * GUI_GRID_H + GUI_GRID_Y;
		w = 16 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0;";
	};
	class creategang: RscButton
	{
		idc = 1601;
		text = "Создать банду"; //--- ToDo: Localize;
		x = 23 * GUI_GRID_W + GUI_GRID_X;
		y = 3 * GUI_GRID_H + GUI_GRID_Y;
		w = 16 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0; createDialog ""gangcreate_menu_dialog"";";
	};
	class joingang: RscButton
	{
		idc = 1602;
		text = "Вступить"; //--- ToDo: Localize;
		x = 23 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 16 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "[] spawn fnc_joinGang;";
	};

};