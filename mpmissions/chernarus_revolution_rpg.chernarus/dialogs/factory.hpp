class factory_dialog
{
	idd = 50022;
	movingEnable = true;
	controlsBackground[] = {background};	
	objects[] = { };		
	controls[] = {
		production_list,
		amount,
		close,
		close_hidden,
		produce,
		produce_hidden,
		storage_text,
		inventory,
		storage,
		inventory_text,
		production_text,
		take,
		take_hidden,
		put,
		put_hidden,
		resources_needed,
		wh_text,
		produce_n_sell,
		produce_n_sell_hidden
	};	
	
	class background: RscPicture
	{
		idc = 2200;
		x = 0.12875 * safezoneW + safezoneX;
		y = 0.159 * safezoneH + safezoneY;
		w = 0.7425 * safezoneW;
		h = 0.66 * safezoneH;
		text = "szag_data\pics\dialogs\factory\factory_background.paa";
	};
	class production_list: RscListbox
	{
		idc = 1500;
		x = 0.139062 * safezoneW + safezoneX;
		y = 0.203 * safezoneH + safezoneY;
		w = 0.2475 * safezoneW;
		h = 0.594 * safezoneH;
		colorBackground[] = {0,0.3,0.3,0.5};
		onLBSelChanged = "_arr = (((factories_array select curfac) select 4) select (_this select 1)) call fnc_getItemResources; _need = ''; {_need = _need + format ['%2x%1 ',(_x select 0) call fnc_getItemName,_x select 1]} foreach _arr;_minimum = 1;{_newminimum = 0; if ((_x select 1) < 1) then {_newminimum = 1/(_x select 1)};if (_newminimum>_minimum) then {_minimum=_newminimum};} foreach _arr; ctrlSetText [1003, format ['Для производства требуется %1 %2ч/ч. Минимальная партия - %3 шт.', _need, (((factories_array select curfac) select 4) select (_this select 1)) call fnc_getItemWH, _minimum]];";
	};
	class amount: RscEdit
	{
		idc = 1400;
		text = "1"; //--- ToDo: Localize;
		x = 0.396875 * safezoneW + safezoneX;
		y = 0.445 * safezoneH + safezoneY;
		w = 0.20625 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class close: RscPicture
	{
		idc = 1600;
		text = "szag_data\pics\dialogs\factory\close_button.paa"; //--- ToDo: Localize;
		x = 0.396875 * safezoneW + safezoneX;
		y = 0.753 * safezoneH + safezoneY;
		w = 0.20625 * safezoneW;
		h = 0.044 * safezoneH;
	};
	class close_hidden: RscStructuredText
	{
		idc = 221600;
		text = ""; //--- ToDo: Localize;
		x = 0.396875 * safezoneW + safezoneX;
		y = 0.753 * safezoneH + safezoneY;
		w = 0.20625 * safezoneW;
		h = 0.044 * safezoneH;
		onMouseEnter="ctrlSetText [1600, ""szag_data\pics\dialogs\factory\close_button_hover.paa""]; playSound ""button_hover"";";
		onMouseExit="ctrlSetText [1600, ""szag_data\pics\dialogs\factory\close_button.paa""];";
		onMouseButtonDown = "closeDialog 0; playSound ""button_click"";";
	};
	class produce: RscPicture
	{
		idc = 1601;
		text = "szag_data\pics\dialogs\factory\produce_button.paa"; //--- ToDo: Localize;
		x = 0.396875 * safezoneW + safezoneX;
		y = 0.489 * safezoneH + safezoneY;
		w = 0.20625 * safezoneW;
		h = 0.044 * safezoneH;
	};
	class produce_hidden: RscStructuredText
	{
		idc = 221601;
		text = ""; //--- ToDo: Localize;
		x = 0.396875 * safezoneW + safezoneX;
		y = 0.489 * safezoneH + safezoneY;
		w = 0.20625 * safezoneW;
		h = 0.044 * safezoneH;
		onMouseEnter="ctrlSetText [1601, ""szag_data\pics\dialogs\factory\produce_button_hover.paa""]; playSound ""button_hover"";";
		onMouseExit="ctrlSetText [1601, ""szag_data\pics\dialogs\factory\produce_button.paa""];";
		onMouseButtonDown = "[(((factories_array select curfac) select 4) select (lbCurSel 1500)), parseNumber (ctrlText 1400)] call fnc_produceFactoryItem; closeDialog 0; playSound ""button_click"";";
	};
	class produce_n_sell: RscPicture
	{
		idc = 1488;
		text = "szag_data\pics\dialogs\factory\produce_sell_button.paa"; //--- ToDo: Localize;
		x = 0.396875 * safezoneW + safezoneX;
		y = 0.555 * safezoneH + safezoneY;
		w = 0.20625 * safezoneW;
		h = 0.044 * safezoneH;
	};
	class produce_n_sell_hidden: RscStructuredText
	{
		idc = 221488;
		text = ""; //--- ToDo: Localize;
		x = 0.396875 * safezoneW + safezoneX;
		y = 0.555 * safezoneH + safezoneY;
		w = 0.20625 * safezoneW;
		h = 0.044 * safezoneH;
		onMouseEnter="ctrlSetText [1488, ""szag_data\pics\dialogs\factory\produce_sell_button_hover.paa""]; playSound ""button_hover"";";
		onMouseExit="ctrlSetText [1488, ""szag_data\pics\dialogs\factory\produce_sell_button.paa""];";
		onMouseButtonDown = "[((my_factories_stock select (my_factories find (factoryclass_array select curfac))) select (lbCurSel 1501)) select 0, parseNumber (ctrlText 1400)] call fnc_produceFactoryItemSell; closeDialog 0; playSound ""button_click"";";
	};
	class storage_text: RscText
	{
		idc = 1000;
		text = "Склад:"; //--- ToDo: Localize;
		x = 0.613437 * safezoneW + safezoneX;
		y = 0.489 * safezoneH + safezoneY;
		w = 0.2475 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class storage: RscListbox
	{
		idc = 1501;
		x = 0.613437 * safezoneW + safezoneX;
		y = 0.511 * safezoneH + safezoneY;
		w = 0.2475 * safezoneW;
		h = 0.286 * safezoneH;
		colorBackground[] = {0,0.3,0.3,0.5};
	};
	class inventory: RscListbox
	{
		idc = 1502;
		x = 0.613437 * safezoneW + safezoneX;
		y = 0.203 * safezoneH + safezoneY;
		w = 0.2475 * safezoneW;
		h = 0.286 * safezoneH;
		colorBackground[] = {0,0.3,0.3,0.5};
	};
	class inventory_text: RscText
	{
		idc = 1001;
		text = "Инвентарь:"; //--- ToDo: Localize;
		x = 0.613437 * safezoneW + safezoneX;
		y = 0.181 * safezoneH + safezoneY;
		w = 0.2475 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class production_text: RscText
	{
		idc = 1002;
		text = "Производство:"; //--- ToDo: Localize;
		x = 0.139062 * safezoneW + safezoneX;
		y = 0.181 * safezoneH + safezoneY;
		w = 0.2475 * safezoneW;
		h = 0.022 * safezoneH;
	};
	class take: RscPicture
	{
		idc = 1602;
		text = "szag_data\pics\dialogs\factory\take_from_factory_button.paa"; //--- ToDo: Localize;
		x = 0.396875 * safezoneW + safezoneX;
		y = 0.687 * safezoneH + safezoneY;
		w = 0.20625 * safezoneW;
		h = 0.044 * safezoneH;
	};
	class take_hidden: RscStructuredText
	{
		idc = 221602;
		text = ""; //--- ToDo: Localize;
		x = 0.396875 * safezoneW + safezoneX;
		y = 0.687 * safezoneH + safezoneY;
		w = 0.20625 * safezoneW;
		h = 0.044 * safezoneH;
		onMouseEnter="ctrlSetText [1602, ""szag_data\pics\dialogs\factory\take_from_factory_button_hover.paa""]; playSound ""button_hover"";";
		onMouseExit="ctrlSetText [1602, ""szag_data\pics\dialogs\factory\take_from_factory_button.paa""];";
		onMouseButtonDown = "[((my_factories_stock select (my_factories find (factoryclass_array select curfac))) select (lbCurSel 1501)) select 0, parseNumber (ctrlText 1400)] call fnc_takeFromFactory; closeDialog 0; playSound ""button_click"";";
	};
	class put: RscPicture
	{
		idc = 1603;
		text = "szag_data\pics\dialogs\factory\put_to_factory_button.paa"; //--- ToDo: Localize;
		x = 0.396875 * safezoneW + safezoneX;
		y = 0.621 * safezoneH + safezoneY;
		w = 0.20625 * safezoneW;
		h = 0.044 * safezoneH;
	};
	class put_hidden: RscStructuredText
	{
		idc = 221603;
		text = ""; //--- ToDo: Localize;
		x = 0.396875 * safezoneW + safezoneX;
		y = 0.621 * safezoneH + safezoneY;
		w = 0.20625 * safezoneW;
		h = 0.044 * safezoneH;
		onMouseEnter="ctrlSetText [1603, ""szag_data\pics\dialogs\factory\put_to_factory_button_hover.paa""]; playSound ""button_hover"";";
		onMouseExit="ctrlSetText [1603, ""szag_data\pics\dialogs\factory\put_to_factory_button.paa""];";
		onMouseButtonDown = "[inventory_items select (lbCurSel 1502), parseNumber (ctrlText 1400)] call fnc_putToFactory; closeDialog 0; playSound ""button_click"";";
	};
	class resources_needed: RscText
	{
		idc = 1003;
		x = 0.396875 * safezoneW + safezoneX;
		y = 0.203 * safezoneH + safezoneY;
		w = 0.20625 * safezoneW;
		h = 0.198 * safezoneH;
		style = 16;
	};
	class wh_text: RscText
	{
		idc = 1004;
		text = "Человек/час:"; //--- ToDo: Localize;
		x = 0.396875 * safezoneW + safezoneX;
		y = 0.401 * safezoneH + safezoneY;
		w = 0.20625 * safezoneW;
		h = 0.022 * safezoneH;
	};
	
};