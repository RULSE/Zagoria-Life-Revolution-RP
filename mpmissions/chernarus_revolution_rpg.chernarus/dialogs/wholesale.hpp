class wholesale_dialog
{
	idd = 50019;
	movingEnable = true;
	controlsBackground[] = {background};	
	objects[] = { };		
	controls[] = {itemlist, sell, close, result, amount};	
	
	class background: IGUIBack
	{
		idc = 2200;
		x = 14 * GUI_GRID_W + GUI_GRID_X;
		y = 0 * GUI_GRID_H + GUI_GRID_Y;
		w = 12 * GUI_GRID_W;
		h = 25 * GUI_GRID_H;
	};
	class itemlist: RscListbox
	{
		idc = 1500;
		x = 15 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 15 * GUI_GRID_H;
		onLBSelChanged = "ctrlSetText [1000, format ['Цена продажи: %1 CRK', (_this select 1) call fnc_getPrice]];";
	};
	class close: RscButton
	{
		idc = 1600;
		text = "Закрыть"; //--- ToDo: Localize;
		x = 15 * GUI_GRID_W + GUI_GRID_X;
		y = 23 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0";
	};
	class sell: RscButton
	{
		idc = 1601;
		text = "Продать"; //--- ToDo: Localize;
		x = 15 * GUI_GRID_W + GUI_GRID_X;
		y = 21 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "[lbCurSel 1500, parseNumber (ctrlText 1400)] execVM 'sellitem.sqf'; closeDialog 0;";
	};
	class amount: RscEdit
	{
		idc = 1400;
		text = "1"; //--- ToDo: Localize;
		x = 15 * GUI_GRID_W + GUI_GRID_X;
		y = 19 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class result: RscText
	{
		idc = 1000;
		text = "Цена продажи:"; //--- ToDo: Localize;
		x = 15 * GUI_GRID_W + GUI_GRID_X;
		y = 17 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};

};