class itemshop_dialog
{
	idd = 50013;
	movingEnable = true;
	controlsBackground[] = {background};	
	objects[] = { };		
	controls[] = {itemlist, buy, close, iteminfo, cost, money, amount};	
		
	class background: IGUIBack
	{
		idc = 2200;
		x = 6 * GUI_GRID_W + GUI_GRID_X;
		y = 0 * GUI_GRID_H + GUI_GRID_Y;
		w = 28 * GUI_GRID_W;
		h = 25 * GUI_GRID_H;
	};
	class itemlist: RscListbox
	{
		idc = 1500;
		x = 18 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 15 * GUI_GRID_W;
		h = 23 * GUI_GRID_H;
		onLBSelChanged = "ctrlSetText [1000, ((((shop_array select curshop) select 3) select (_this select 1)) select 0) call fnc_getItemInfo];ctrlSetText [1001, format ['Стоимость: %1 CRK', (round(((((shop_array select curshop) select 3) select (_this select 1)) select 1)*(1+nds_tax)))*(parseNumber (ctrlText 1400))]];";
	};
	class iteminfo: RscText
	{
		idc = 1000;
		x = 7 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 15 * GUI_GRID_H;
		style = 16;
	};
	class close: RscButton
	{
		idc = 1600;
		text = "Закрыть"; //--- ToDo: Localize;
		x = 7 * GUI_GRID_W + GUI_GRID_X;
		y = 23 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0";
	};
	class buy: RscButton
	{
		idc = 1601;
		text = "Купить"; //--- ToDo: Localize;
		x = 7 * GUI_GRID_W + GUI_GRID_X;
		y = 21 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "(lbCurSel 1500) execVM 'buyitem.sqf';";
	};
	class amount: RscEdit
	{
		idc = 1400;
		text = "1"; //--- ToDo: Localize;
		x = 7 * GUI_GRID_W + GUI_GRID_X;
		y = 19 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class cost: RscText
	{
		idc = 1001;
		text = "Стоимость:"; //--- ToDo: Localize;
		x = 7 * GUI_GRID_W + GUI_GRID_X;
		y = 16 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class money: RscText
	{
		idc = 1002;
		text = "Наличные:"; //--- ToDo: Localize;
		x = 7 * GUI_GRID_W + GUI_GRID_X;
		y = 17 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};

};