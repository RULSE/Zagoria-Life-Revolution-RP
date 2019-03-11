class generic_shop_nosell_dialog
{
	idd = 50101;
	movingEnable = true;
	controlsBackground[] = {background,desc_back};	
	objects[] = { };		
	controls[]=
	{
		itemstobuy,
		buyamount,
		buy,
		close,
		desc
	};

	class background: IGUIBack
	{
		idc = 2200;
		x = 0 * GUI_GRID_W + GUI_GRID_X;
		y = 0 * GUI_GRID_H + GUI_GRID_Y;
		w = 20 * GUI_GRID_W;
		h = 26 * GUI_GRID_H;
	};
	class itemstobuy: RscListbox
	{
		idc = 1500;
		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 18 * GUI_GRID_W;
		h = 20 * GUI_GRID_H;
		onLBSelChanged = "ctrlSetText [1000, (_this select 1) call fnc_getItemInfo];ctrlSetText [1001, format ['Цена: %1 CRK', round(((((shop_array select curshop) select 3) select (_this select 1)) select 1)*(1+nds_tax))]];";
	};
	class buyamount: RscEdit
	{
		idc = 1400;
		text = "1";
		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 22 * GUI_GRID_H + GUI_GRID_Y;
		w = 8 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class buy: RscButton
	{
		idc = 1600;
		text = "Купить"; //--- ToDo: Localize;
		x = 9 * GUI_GRID_W + GUI_GRID_X;
		y = 22 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "(lbCurSel 1500) spawn fnc_buyItem;";
	};
	class close: RscButton
	{
		idc = 1602;
		text = "ЗАКРЫТЬ"; //--- ToDo: Localize;
		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 24 * GUI_GRID_H + GUI_GRID_Y;
		w = 18 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class desc_back: IGUIBack
	{
		idc = 2201;
		x = -16 * GUI_GRID_W + GUI_GRID_X;
		y = 0 * GUI_GRID_H + GUI_GRID_Y;
		w = 15 * GUI_GRID_W;
		h = 10 * GUI_GRID_H;
	};
	class desc: RscStructuredText
	{
		idc = 1100;
		text = "Описание предмета"; //--- ToDo: Localize;
		x = -15 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 13 * GUI_GRID_W;
		h = 8 * GUI_GRID_H;
	};


};