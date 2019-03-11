
class item_menu
{
	idd = 50012;
	movingEnable = true;
	controlsBackground[] = {background};	
	objects[] = { };		
	controls[] = {
		item_list,
		inv_weight,
		item_info,
		drop,
		drop_hidden,
		player_select,
		amount,
		use,
		use_hidden,
		give,
		give_hidden,
		close,
		close_hidden,
		weight,
		amount_current
		
	};	
	
	class background: RscPicture
	{
		idc = 2200;
		x = 0.2525 * safezoneW + safezoneX;
		y = 0.269 * safezoneH + safezoneY;
		w = 0.495 * safezoneW;
		h = 0.506 * safezoneH;
		text="szag_data\pics\dialogs\item_menu\item_menu_background.paa";
	};
	class inv_weight: RscText
	{
		idc = 1003;
		text = "Вес инвентаря:"; //--- ToDo: Localize;
		x = 0.396875 * safezoneW + safezoneX;
		y = 0.291 * safezoneH + safezoneY;
		w = 0.20625 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class item_list: RscListbox
	{
		idc = 1500;
		x = 0.396875 * safezoneW + safezoneX;
		y = 0.335 * safezoneH + safezoneY;
		w = 0.20625 * safezoneW;
		h = 0.418 * safezoneH;
		colorBackground[] = {0,0.3,0.3,0.5};
		onLBSelChanged = "ctrlSetText [1100, (inventory_items select (_this select 1)) call fnc_getItemInfo]; ctrlSetText [1001, format ['Количество: %1', [inventory_amount select (_this select 1)] call fnc_numberToText]]; ctrlSetText [1002, format ['Вес: %1',(inventory_items select (_this select 1)) call fnc_getItemWeight]];";
	};
	class item_info: RscText
	{
		idc = 1100;
		x = 0.613437 * safezoneW + safezoneX;
		y = 0.291 * safezoneH + safezoneY;
		w = 0.12375 * safezoneW;
		h = 0.418 * safezoneH;
		style = 16;
	};
	class drop: RscPicture
	{
		idc = 1600;
		text = "szag_data\pics\dialogs\item_menu\drop_button.paa"; //--- ToDo: Localize;
		x = 0.262812 * safezoneW + safezoneX;
		y = 0.401 * safezoneH + safezoneY;
		w = 0.12375 * safezoneW;
		h = 0.044 * safezoneH;
	};
	class drop_hidden: RscStructuredText
	{
		idc = 221600;
		text = ""; //--- ToDo: Localize;
		x = 0.262812 * safezoneW + safezoneX;
		y = 0.401 * safezoneH + safezoneY;
		w = 0.12375 * safezoneW;
		h = 0.044 * safezoneH;
		onMouseEnter="ctrlSetText [1600, ""szag_data\pics\dialogs\item_menu\drop_button_hover.paa""]; playSound ""button_hover"";";
		onMouseExit="ctrlSetText [1600, ""szag_data\pics\dialogs\item_menu\drop_button.paa""];";
		onMouseButtonDown = "[lbCurSel 1500, parseNumber ctrlText 1400] call fnc_dropItem; closeDialog 0; playSound ""button_click"";";
	};
	class player_select: RscCombo
	{
		idc = 2100;
		x = 0.262812 * safezoneW + safezoneX;
		y = 0.467 * safezoneH + safezoneY;
		w = 0.12375 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class amount: RscEdit
	{
		idc = 1400;
		text = "1"; //--- ToDo: Localize;
		x = 0.262812 * safezoneW + safezoneX;
		y = 0.291 * safezoneH + safezoneY;
		w = 0.12375 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class use: RscPicture
	{
		idc = 1601;
		text = "szag_data\pics\dialogs\item_menu\use_button.paa"; //--- ToDo: Localize;
		x = 0.262812 * safezoneW + safezoneX;
		y = 0.335 * safezoneH + safezoneY;
		w = 0.12375 * safezoneW;
		h = 0.044 * safezoneH;
	};
	class use_hidden: RscStructuredText
	{
		idc = 221601;
		text = ""; //--- ToDo: Localize;
		x = 0.262812 * safezoneW + safezoneX;
		y = 0.335 * safezoneH + safezoneY;
		w = 0.12375 * safezoneW;
		h = 0.044 * safezoneH;
		onMouseEnter="ctrlSetText [1601, ""szag_data\pics\dialogs\item_menu\use_button_hover.paa""]; playSound ""button_hover"";";
		onMouseExit="ctrlSetText [1601, ""szag_data\pics\dialogs\item_menu\use_button.paa""];";
		onMouseButtonDown = "[lbCurSel 1500, parseNumber ctrlText 1400] call fnc_useItem; closeDialog 0; playSound ""button_click"";";
	};
	class give: RscPicture
	{
		idc = 1602;
		text = "szag_data\pics\dialogs\item_menu\give_button.paa"; //--- ToDo: Localize;
		x = 0.262812 * safezoneW + safezoneX;
		y = 0.511 * safezoneH + safezoneY;
		w = 0.12375 * safezoneW;
		h = 0.044 * safezoneH;
	};
	class give_hidden: RscStructuredText
	{
		idc = 1602;
		text = ""; //--- ToDo: Localize;
		x = 0.262812 * safezoneW + safezoneX;
		y = 0.511 * safezoneH + safezoneY;
		w = 0.12375 * safezoneW;
		h = 0.044 * safezoneH;
		onMouseEnter="ctrlSetText [1602, ""szag_data\pics\dialogs\item_menu\give_button_hover.paa""]; playSound ""button_hover"";";
		onMouseExit="ctrlSetText [1602, ""szag_data\pics\dialogs\item_menu\give_button.paa""];";
		onMouseButtonDown = "if ((lbCurSel 1500)>=0) then {[lbText [2100,lbCurSel 2100],inventory_items select (lbCurSel 1500),parseNumber(ctrlText 1400)] call fnc_giveItem;} else {systemChat 'Выберите предмет!';}; playSound ""button_click"";";
	};
	class close: RscPicture
	{
		idc = 1603;
		text = "szag_data\pics\dialogs\item_menu\close_button.paa"; //--- ToDo: Localize;
		x = 0.262812 * safezoneW + safezoneX;
		y = 0.709 * safezoneH + safezoneY;
		w = 0.12375 * safezoneW;
		h = 0.044 * safezoneH;
	};
	class close_hidden: RscStructuredText
	{
		idc = 1603;
		text = ""; //--- ToDo: Localize;
		x = 0.262812 * safezoneW + safezoneX;
		y = 0.709 * safezoneH + safezoneY;
		w = 0.12375 * safezoneW;
		h = 0.044 * safezoneH;
		onMouseEnter="ctrlSetText [1603, ""szag_data\pics\dialogs\item_menu\close_button_hover.paa""]; playSound ""button_hover"";";
		onMouseExit="ctrlSetText [1603, ""szag_data\pics\dialogs\item_menu\close_button.paa""];";
		onMouseButtonDown = "closedialog 0; playSound ""button_click"";";
	};
	class amount_current: RscText
	{
		idc = 1001;
		text = "Количество:"; //--- ToDo: Localize;
		x = 0.613437 * safezoneW + safezoneX;
		y = 0.709 * safezoneH + safezoneY;
		w = 0.12375 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class weight: RscText
	{
		idc = 1002;
		text = "Вес:"; //--- ToDo: Localize;
		x = 0.613437 * safezoneW + safezoneX;
		y = 0.731 * safezoneH + safezoneY;
		w = 0.12375 * safezoneW;
		h = 0.022 * safezoneH;
	};
};
