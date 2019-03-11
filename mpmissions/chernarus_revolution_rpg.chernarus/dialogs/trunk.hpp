class trunk_dialog
{
	idd = 50021;
	movingEnable = true;
	controlsBackground[] = {background};	
	objects[] = { };		
	controls[] = {
		trunklist,
		itemlist,
		close,
		close_hidden,
		amount,
		trunkmass,
		take,
		take_hidden,
		put,
		put_hidden,
		inventorytext
	};	
	
	class background: RscPicture
	{
		idc = 2200;
		text = "szag_data\pics\dialogs\trunk\trunk_background.paa";
		x = 0.17 * safezoneW + safezoneX;
		y = 0.225 * safezoneH + safezoneY;
		w = 0.66 * safezoneW;
		h = 0.55 * safezoneH;
	};
	class trunklist: RscListbox
	{
		idc = 1500;
		x = 0.180312 * safezoneW + safezoneX;
		y = 0.269 * safezoneH + safezoneY;
		w = 0.2475 * safezoneW;
		h = 0.484 * safezoneH;
		colorBackground[] = {0,0.3,0.3,0.5};
	};
	class itemlist: RscListbox
	{
		idc = 1501;
		x = 0.572187 * safezoneW + safezoneX;
		y = 0.269 * safezoneH + safezoneY;
		w = 0.2475 * safezoneW;
		h = 0.484 * safezoneH;
		colorBackground[] = {0,0.3,0.3,0.5};
	};
	class close: RscPicture
	{
		idc = 1600;
		text = "szag_data\pics\dialogs\trunk\close_button.paa"; //--- ToDo: Localize;
		x = 0.438125 * safezoneW + safezoneX;
		y = 0.709 * safezoneH + safezoneY;
		w = 0.12375 * safezoneW;
		h = 0.044 * safezoneH;
	};
	class close_hidden: RscStructuredText
	{
		idc = 221600;
		text = ""; //--- ToDo: Localize;
		x = 0.438125 * safezoneW + safezoneX;
		y = 0.709 * safezoneH + safezoneY;
		w = 0.12375 * safezoneW;
		h = 0.044 * safezoneH;
		onMouseEnter="ctrlSetText [1600, ""szag_data\pics\dialogs\trunk\close_button_hover.paa""]; playSound ""button_hover"";";
		onMouseExit="ctrlSetText [1600, ""szag_data\pics\dialogs\trunk\close_button.paa""];";
		onMouseButtonDown = "closeDialog 0; playSound ""button_click"";";
	};
	class amount: RscEdit
	{
		idc = 1400;
		text = "1"; //--- ToDo: Localize;
		x = 0.438125 * safezoneW + safezoneX;
		y = 0.533 * safezoneH + safezoneY;
		w = 0.12375 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class trunkmass: RscText
	{
		idc = 1000;
		text = "Вес груза:"; //--- ToDo: Localize;
		x = 0.180312 * safezoneW + safezoneX;
		y = 0.247 * safezoneH + safezoneY;
		w = 0.2475 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class take: RscPicture
	{
		idc = 1601;
		text = "szag_data\pics\dialogs\trunk\takefromtrunk_button.paa"; //--- ToDo: Localize;
		x = 0.438125 * safezoneW + safezoneX;
		y = 0.577 * safezoneH + safezoneY;
		w = 0.12375 * safezoneW;
		h = 0.044 * safezoneH;
	};
	class take_hidden: RscStructuredText
	{
		idc = 221601;
		text = ""; //--- ToDo: Localize;
		x = 0.438125 * safezoneW + safezoneX;
		y = 0.577 * safezoneH + safezoneY;
		w = 0.12375 * safezoneW;
		h = 0.044 * safezoneH;
		onMouseEnter="ctrlSetText [1601, ""szag_data\pics\dialogs\trunk\takefromtrunk_button_hover.paa""]; playSound ""button_hover"";";
		onMouseExit="ctrlSetText [1601, ""szag_data\pics\dialogs\trunk\takefromtrunk_button.paa""];";
		onMouseButtonDown = "if ((lbCurSel 1500)<0) exitWith {}; [curveh,(curveh getVariable 'trunkitems') select (lbCurSel 1500),parseNumber (ctrlText 1400)] call fnc_takeItemFromTrunk; closeDialog 0; playSound ""button_click"";";
	};
	class put: RscPicture
	{
		idc = 1602;
		text = "szag_data\pics\dialogs\trunk\puttotrunk_button.paa"; //--- ToDo: Localize;
		x = 0.438125 * safezoneW + safezoneX;
		y = 0.643 * safezoneH + safezoneY;
		w = 0.12375 * safezoneW;
		h = 0.044 * safezoneH;
	};
	class put_hidden: RscStructuredText
	{
		idc = 221602;
		text = ""; //--- ToDo: Localize;
		x = 0.438125 * safezoneW + safezoneX;
		y = 0.643 * safezoneH + safezoneY;
		w = 0.12375 * safezoneW;
		h = 0.044 * safezoneH;
		onMouseEnter="ctrlSetText [1602, ""szag_data\pics\dialogs\trunk\puttotrunk_button_hover.paa""]; playSound ""button_hover"";";
		onMouseExit="ctrlSetText [1602, ""szag_data\pics\dialogs\trunk\puttotrunk_button.paa""];";
		onMouseButtonDown = "if ((lbCurSel 1501)<0) exitWith {}; [curveh,inventory_items select (lbCurSel 1501),parseNumber (ctrlText 1400)] call fnc_putItemToTrunk; closeDialog 0; playSound ""button_click"";";
	};
	class inventorytext: RscText
	{
		idc = 1001;
		text = "Инвентарь"; //--- ToDo: Localize;
		x = 0.572187 * safezoneW + safezoneX;
		y = 0.247 * safezoneH + safezoneY;
		w = 0.2475 * safezoneW;
		h = 0.022 * safezoneH;
	};

};