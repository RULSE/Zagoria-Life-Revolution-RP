class garage_dialog
{
	idd = 50010;
	movingEnable = true;
	controlsBackground[] = {background};	
	objects[] = { };		
	controls[] = {close, retrieve, garage_list, items_list, info};	
		
	class background: IGUIBack
	{
		idc = 2200;
		x = 9 * GUI_GRID_W + GUI_GRID_X;
		y = 0 * GUI_GRID_H + GUI_GRID_Y;
		w = 23 * GUI_GRID_W;
		h = 25 * GUI_GRID_H;
	};
	class close: RscButton
	{
		idc = 1600;
		text = "Закрыть"; //--- ToDo: Localize;
		x = 10 * GUI_GRID_W + GUI_GRID_X;
		y = 23 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0";
	};
	class retrieve: RscButton
	{
		idc = 1601;
		text = "Взять из гаража"; //--- ToDo: Localize;
		x = 21 * GUI_GRID_W + GUI_GRID_X;
		y = 23 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "(lbCurSel 1500) spawn fnc_retrieveVehicle; closeDialog 0;";
	};
	class garage_list: RscListbox
	{
		idc = 1500;
		x = 10 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 21 * GUI_GRID_H;
		onLBSelChanged = "lbClear 1501; ctrlSetText [1000, format ['Регистрационный номер - %1.',((garage_array select (_this select 1)) select 1)]]; {lbAdd [1501, format ['%1 %2шт.',((((garage_array select (_this select 1)) select 5) select 0) select _forEachIndex) call fnc_getItemName,[((((garage_array select (_this select 1)) select 5) select 1) select _forEachIndex)] call fnc_numberToText]];} foreach (((garage_array select (_this select 1)) select 5) select 0);";
	};
	class items_list: RscListbox
	{
		idc = 1501;
		x = 21 * GUI_GRID_W + GUI_GRID_X;
		y = 12 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 10 * GUI_GRID_H;
	};
	class info: RscText
	{
		idc = 1000;
		x = 21 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 10 * GUI_GRID_H;
		style = 16;
	};

};