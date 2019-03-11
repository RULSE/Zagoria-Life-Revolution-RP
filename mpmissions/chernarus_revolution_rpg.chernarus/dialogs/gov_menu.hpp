
class gov_menu_dialog
{
	idd = 50011;
	movingEnable = true;
	controlsBackground[] = {background};	
	objects[] = { };		
	controls[]=
	{
		govtext,
		nds_text,
		inc_text,
		nds_value,
		inc_value,
		nds_number,
		inc_number,
		speedtown_text,
		speednottown_text,
		speedtown_value,
		speednottown_value,
		speedtown_number,
		speednottown_number,
		kazna_text,
		guns_legal,
		guns_combobox,
		close,
		apply
	};

	class background: IGUIBack
	{
		idc = 2200;
		x = 4 * GUI_GRID_W + GUI_GRID_X;
		y = 0 * GUI_GRID_H + GUI_GRID_Y;
		w = 32 * GUI_GRID_W;
		h = 17 * GUI_GRID_H;
	};
	class govtext: RscText
	{
		idc = 1000;
		text = "Южно-Загорская автономия"; //--- ToDo: Localize;
		x = 5 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 28 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class nds_text: RscText
	{
		idc = 1001;
		text = "НДС:"; //--- ToDo: Localize;
		x = 5 * GUI_GRID_W + GUI_GRID_X;
		y = 3 * GUI_GRID_H + GUI_GRID_Y;
		w = 7 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class inc_text: RscText
	{
		idc = 1002;
		text = "Подоходный налог:"; //--- ToDo: Localize;
		x = 5 * GUI_GRID_W + GUI_GRID_X;
		y = 5 * GUI_GRID_H + GUI_GRID_Y;
		w = 7 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class nds_value: RscSlider
	{
		idc = 1100;
		x = 15 * GUI_GRID_W + GUI_GRID_X;
		y = 3 * GUI_GRID_H + GUI_GRID_Y;
		w = 15 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		onSliderPosChanged = "[_this select 0, _this select 1, 1003] call fnc_govMenuSliderChanged;";
	};
	class inc_value: RscSlider
	{
		idc = 1101;
		x = 15 * GUI_GRID_W + GUI_GRID_X;
		y = 5 * GUI_GRID_H + GUI_GRID_Y;
		w = 15 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		onSliderPosChanged = "[_this select 0, _this select 1, 1004] call fnc_govMenuSliderChanged;";
	};
	class nds_number: RscText
	{
		idc = 1003;
		text = "33%"; //--- ToDo: Localize;
		x = 31 * GUI_GRID_W + GUI_GRID_X;
		y = 3 * GUI_GRID_H + GUI_GRID_Y;
		w = 3 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class inc_number: RscText
	{
		idc = 1004;
		text = "33%"; //--- ToDo: Localize;
		x = 31 * GUI_GRID_W + GUI_GRID_X;
		y = 5 * GUI_GRID_H + GUI_GRID_Y;
		w = 3 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class speedtown_text: RscText
	{
		idc = 1005;
		text = "Скорость в городе:"; //--- ToDo: Localize;
		x = 5 * GUI_GRID_W + GUI_GRID_X;
		y = 7 * GUI_GRID_H + GUI_GRID_Y;
		w = 7 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class speednottown_text: RscText
	{
		idc = 1006;
		text = "Скорость за городом"; //--- ToDo: Localize;
		x = 5 * GUI_GRID_W + GUI_GRID_X;
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 8 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class speedtown_value: RscSlider
	{
		idc = 1102;
		x = 15 * GUI_GRID_W + GUI_GRID_X;
		y = 7 * GUI_GRID_H + GUI_GRID_Y;
		w = 15 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		onSliderPosChanged = "[_this select 0, _this select 1, 1007] call fnc_govMenuSliderChanged2;";
	};
	class speednottown_value: RscSlider
	{
		idc = 1103;
		x = 15 * GUI_GRID_W + GUI_GRID_X;
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 15 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		onSliderPosChanged = "[_this select 0, _this select 1, 1008] call fnc_govMenuSliderChanged2;";
	};
	class speedtown_number: RscText
	{
		idc = 1007;
		text = "100 км/ч"; //--- ToDo: Localize;
		x = 31 * GUI_GRID_W + GUI_GRID_X;
		y = 7 * GUI_GRID_H + GUI_GRID_Y;
		w = 4 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class speednottown_number: RscText
	{
		idc = 1008;
		text = "100 км/ч"; //--- ToDo: Localize;
		x = 31 * GUI_GRID_W + GUI_GRID_X;
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 4 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class kazna_text: RscText
	{
		idc = 1009;
		text = "Казна: 1488 CRK"; //--- ToDo: Localize;
		x = 5 * GUI_GRID_W + GUI_GRID_X;
		y = 11 * GUI_GRID_H + GUI_GRID_Y;
		w = 30 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class guns_legal: RscText
	{
		idc = 1010;
		text = "Короткоствольное летальное оружие:"; //--- ToDo: Localize;
		x = 5 * GUI_GRID_W + GUI_GRID_X;
		y = 13 * GUI_GRID_H + GUI_GRID_Y;
		w = 14 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class guns_combobox: RscCombo
	{
		idc = 2100;
		text = ""; //--- ToDo: Localize;
		x = 19 * GUI_GRID_W + GUI_GRID_X;
		y = 13 * GUI_GRID_H + GUI_GRID_Y;
		w = 8 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class close: RscButton
	{
		idc = 1600;
		text = "Закрыть"; //--- ToDo: Localize;
		x = 28 * GUI_GRID_W + GUI_GRID_X;
		y = 15 * GUI_GRID_H + GUI_GRID_Y;
		w = 7 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0;";
	};
	class apply: RscButton
	{
		idc = 1601;
		text = "Применить"; //--- ToDo: Localize;
		x = 20 * GUI_GRID_W + GUI_GRID_X;
		y = 15 * GUI_GRID_H + GUI_GRID_Y;
		w = 7 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "[] spawn fnc_govMenuApply";
	};



};