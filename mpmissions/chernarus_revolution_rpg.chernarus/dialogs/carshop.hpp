class carshop_dialog
{
	idd = 50020;
	movingEnable = true;
	controlsBackground[] = {background};	
	objects[] = { };		
	controls[] = {itemlist, buy, close, vehinfo, price, money};	
	
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
		onLBSelChanged = "ctrlSetText [1000, ((((shop_array select curshop) select 3) select (_this select 1)) select 0) call fnc_getItemInfo];ctrlSetText [1001, format ['Цена: %1 CRK', round(((((shop_array select curshop) select 3) select (_this select 1)) select 1)*(1+nds_tax))]];";
	};
	class buy: RscButton
	{
		idc = 1600;
		text = "Купить"; //--- ToDo: Localize;
		x = 7 * GUI_GRID_W + GUI_GRID_X;
		y = 21 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "(lbCurSel 1500) execVM 'buycar.sqf';";
	};
	class close: RscButton
	{
		idc = 1601;
		text = "Закрыть"; //--- ToDo: Localize;
		x = 7 * GUI_GRID_W + GUI_GRID_X;
		y = 23 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0";
	};
	class vehinfo: RscText
	{
		idc = 1000;
		x = 7 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 17 * GUI_GRID_H;
		style = 16;
	};
	class price: RscText
	{
		idc = 1001;
		text = "Цена:"; //--- ToDo: Localize;
		x = 7 * GUI_GRID_W + GUI_GRID_X;
		y = 18 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class money: RscText
	{
		idc = 1002;
		text = "Наличные:"; //--- ToDo: Localize;
		x = 7 * GUI_GRID_W + GUI_GRID_X;
		y = 19 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};

};