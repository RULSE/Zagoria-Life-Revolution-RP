
class gangcreate_menu_dialog
{
	idd = 50007;
	movingEnable = true;
	controlsBackground[] = {background};	
	objects[] = { };		
	controls[]=
	{
		gangname,
		close,
		text1,
		creategang
	};

	class background: IGUIBack
	{
		idc = 2200;
		x = 9 * GUI_GRID_W + GUI_GRID_X;
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 22 * GUI_GRID_W;
		h = 7 * GUI_GRID_H;
	};
	class gangname: RscEdit
	{
		idc = 1400;
		x = 10 * GUI_GRID_W + GUI_GRID_X;
		y = 10 * GUI_GRID_H + GUI_GRID_Y;
		w = 20 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class close: RscButton
	{
		idc = 1600;
		text = "Закрыть"; //--- ToDo: Localize;
		x = 20.5 * GUI_GRID_W + GUI_GRID_X;
		y = 14 * GUI_GRID_H + GUI_GRID_Y;
		w = 9.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0;";
	};
	class text1: RscText
	{
		idc = 1000;
		text = "Стоимость создания - 50000 CRK"; //--- ToDo: Localize;
		x = 10 * GUI_GRID_W + GUI_GRID_X;
		y = 12 * GUI_GRID_H + GUI_GRID_Y;
		w = 12 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class creategang: RscButton
	{
		idc = 1601;
		text = "Создать"; //--- ToDo: Localize;
		x = 10 * GUI_GRID_W + GUI_GRID_X;
		y = 14 * GUI_GRID_H + GUI_GRID_Y;
		w = 9.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "[ctrlText 1400] spawn fnc_createGang; closeDialog 0;";
	};


};