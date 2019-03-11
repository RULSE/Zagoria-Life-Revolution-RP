class generic_shop_dialog
{
	idd = 50100;
	movingEnable = true;
	controlsBackground[] = {background};	
	objects[] = { };		
	controls[]=
	{
		itemstobuy,
		itemstosell,
		//buyamount,
		buy,
		buy_hidden,
		sell,
		sell_hidden,
		sellamount,
		close,
		close_hidden,
		desc,
		desc2,
		txt1,
		txt2
	};

	class background: RscPicture
	{
		idc = 2200;
		x = 0.0875 * safezoneW + safezoneX;
		y = 0.203 * safezoneH + safezoneY;
		w = 0.825 * safezoneW;
		h = 0.572 * safezoneH;
		text="szag_data\pics\dialogs\shop\shop_hud_bg5.paa";
	};
	class itemstobuy: RscListbox
	{
		idc = 1500;
		x = 0.0978125 * safezoneW + safezoneX;
		y = 0.247 * safezoneH + safezoneY;
		w = 0.2475 * safezoneW;
		h = 0.506 * safezoneH;
		colorBackground[] = {0,0.3,0.3,0.5};
		
		onLBSelChanged = "[(lbData [1500,(_this select 1)]),(_this select 1)] spawn fnc_shopItemDesc;";//round(((((shop_array select curshop) select 3) select (_this select 1)) select 1)*(1+nds_tax))
	};
	class itemstosell: RscListbox
	{
		idc = 1501;
		x = 0.654688 * safezoneW + safezoneX;
		y = 0.247 * safezoneH + safezoneY;
		w = 0.2475 * safezoneW;
		h = 0.506 * safezoneH;
		colorBackground[] = {0,0.3,0.3,0.5};
	};
	class buy: RscPicture
	{
		idc = 1600;
		text = "szag_data\pics\dialogs\shop\buy_button.paa"; //--- ToDo: Localize;
		x = 0.355625 * safezoneW + safezoneX;
		y = 0.643 * safezoneH + safezoneY;
		w = 0.139219 * safezoneW;
		h = 0.044 * safezoneH;
	};
	class buy_hidden: RscStructuredText
	{
		idc = 221600;
		x = 0.355625 * safezoneW + safezoneX;
		y = 0.643 * safezoneH + safezoneY;
		w = 0.139219 * safezoneW;
		h = 0.044 * safezoneH;
		onMouseEnter="ctrlSetText [1600, ""szag_data\pics\dialogs\shop\buy_button_hover.paa""]; playSound ""button_hover"";";
		onMouseExit="ctrlSetText [1600, ""szag_data\pics\dialogs\shop\buy_button.paa""];";
		onMouseButtonDown = "(lbCurSel 1500) spawn fnc_buyItem; playSound ""button_click"";";
	};
	class sell: RscPicture
	{
		idc = 1601;
		text = "szag_data\pics\dialogs\shop\sell_button.paa"; //--- ToDo: Localize;
		x = 0.505156 * safezoneW + safezoneX;
		y = 0.643 * safezoneH + safezoneY;
		w = 0.139219 * safezoneW;
		h = 0.044 * safezoneH;
	};
	class sell_hidden: RscStructuredText
	{
		idc = 221601;
		text = ""; //--- ToDo: Localize;
		x = 0.505156 * safezoneW + safezoneX;
		y = 0.643 * safezoneH + safezoneY;
		w = 0.139219 * safezoneW;
		h = 0.044 * safezoneH;
		onMouseEnter="ctrlSetText [1601, ""szag_data\pics\dialogs\shop\sell_button_hover.paa""]; playSound ""button_hover"";";
		onMouseExit="ctrlSetText [1601, ""szag_data\pics\dialogs\shop\sell_button.paa""];";
		onMouseButtonDown = "(lbCurSel 1501) spawn fnc_sellItem; playSound ""button_click"";";
	};
	class sellamount: RscEdit
	{
		idc = 1401;
		text = "1";
		x = 0.355625 * safezoneW + safezoneX;
		y = 0.599 * safezoneH + safezoneY;
		w = 0.28875 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class close: RscPicture
	{
		idc = 1602;
		text = "szag_data\pics\dialogs\shop\close_button.paa"; //--- ToDo: Localize;
		x = 0.355625 * safezoneW + safezoneX;
		y = 0.709 * safezoneH + safezoneY;
		w = 0.28875 * safezoneW;
		h = 0.044 * safezoneH;
	};
	class close_hidden: RscStructuredText
	{
		idc = 221602;
		text = ""; //--- ToDo: Localize;
		x = 0.355625 * safezoneW + safezoneX;
		y = 0.709 * safezoneH + safezoneY;
		w = 0.28875 * safezoneW;
		h = 0.044 * safezoneH;
		onMouseEnter="ctrlSetText [1602, ""szag_data\pics\dialogs\shop\close_button_hover.paa""]; playSound ""button_hover"";";
		onMouseExit="ctrlSetText [1602, ""szag_data\pics\dialogs\shop\close_button.paa""];";
		onMouseButtonDown = "closeDialog 0; playSound ""button_click"";";
	};
	/*class desc_back: IGUIBack
	{
		idc = 2201;
		x = -16 * GUI_GRID_W + GUI_GRID_X;
		y = 0 * GUI_GRID_H + GUI_GRID_Y;
		w = 15 * GUI_GRID_W;
		h = 10 * GUI_GRID_H;
	};*/
	class desc: RscStructuredText
	{
		idc = 1100;
		text = ""; //--- ToDo: Localize;
		x = 0.355625 * safezoneW + safezoneX;
		y = 0.247 * safezoneH + safezoneY;
		w = 0.28875 * safezoneW;
		h = 0.242 * safezoneH;
	};
	class desc2: RscStructuredText
	{
		idc = 1101;
		text = ""; //--- ToDo: Localize;
		x = 0.355625 * safezoneW + safezoneX;
		y = 0.511 * safezoneH + safezoneY;
		w = 0.28875 * safezoneW;
		h = 0.066 * safezoneH;
	};
	class txt1: RscStructuredText
	{
		idc = 1102;
		text = "<t color='#00ff00'>Магазин:</t>"; //--- ToDo: Localize;
		x = 0.0978125 * safezoneW + safezoneX;
		y = 0.225 * safezoneH + safezoneY;
		w = 0.2475 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class txt2: RscStructuredText
	{
		idc = 1103;
		text = "<t color='#00ff00'>Ваш инвентарь:</t>"; //--- ToDo: Localize;
		x = 0.654688 * safezoneW + safezoneX;
		y = 0.225 * safezoneH + safezoneY;
		w = 0.2475 * safezoneW;
		h = 0.022 * safezoneH;
	};


};