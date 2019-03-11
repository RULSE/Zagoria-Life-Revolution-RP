
class char_roll_dialog
{
	idd = 1488228;
	movingEnable = true;
	controlsBackground[] = {IGUIBack_2200};	
	objects[] = { };		
	controls[]=
	{
		nattext,
		religiontext,
		textdrugs,
		skilltext,
		textshooting,
		battletext,
		lockpicktext,
		engtext,
		strengthtext,
		staminatext,
		shootingvalue,
		battlevalue,
		lockpickvalue,
		engvalue,
		strengthvalue,
		staminavalue,
		shootingnumber,
		battlenumber,
		lockpicknumber,
		engnumber,
		strengthnumber,
		staminanumber,
		startbutton,
		nationalityselect,
		religionselect
	};

	class IGUIBack_2200: IGUIBack
	{
		idc = 2200;
		x = 0 * GUI_GRID_W + GUI_GRID_X;
		y = 0 * GUI_GRID_H + GUI_GRID_Y;
		w = 40 * GUI_GRID_W;
		h = 25 * GUI_GRID_H;
	};
	class nattext: RscText
	{
		idc = 1000;
		text = "Национальность:"; //--- ToDo: Localize;
		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 7 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class religiontext: RscText
	{
		idc = 1001;
		text = "Вероисповедание:"; //--- ToDo: Localize;
		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 3 * GUI_GRID_H + GUI_GRID_Y;
		w = 7 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class textdrugs: RscText
	{
		idc = 1002;
		text = "Зависимость от веществ: нет."; //--- ToDo: Localize;
		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 5 * GUI_GRID_H + GUI_GRID_Y;
		w = 38 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class skilltext: RscText
	{
		idc = 1003;
		text = "Доступно очков для распределения: 100"; //--- ToDo: Localize;
		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 7 * GUI_GRID_H + GUI_GRID_Y;
		w = 38 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class textshooting: RscText
	{
		idc = 1004;
		text = "Стрельба:"; //--- ToDo: Localize;
		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 7 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class battletext: RscText
	{
		idc = 1005;
		text = "Боевой опыт:"; //--- ToDo: Localize;
		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 11 * GUI_GRID_H + GUI_GRID_Y;
		w = 7 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class lockpicktext: RscText
	{
		idc = 1006;
		text = "Отмычка:"; //--- ToDo: Localize;
		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 13 * GUI_GRID_H + GUI_GRID_Y;
		w = 7 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class engtext: RscText
	{
		idc = 1007;
		text = "Инженер: "; //--- ToDo: Localize;
		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 15 * GUI_GRID_H + GUI_GRID_Y;
		w = 7 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class strengthtext: RscText
	{
		idc = 1008;
		text = "Сила: "; //--- ToDo: Localize;
		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 17 * GUI_GRID_H + GUI_GRID_Y;
		w = 7 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class staminatext: RscText
	{
		idc = 1009;
		text = "Выносливость: "; //--- ToDo: Localize;
		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 19 * GUI_GRID_H + GUI_GRID_Y;
		w = 7 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class shootingvalue: RscSlider
	{
		idc = 1100;
		x = 8 * GUI_GRID_W + GUI_GRID_X;
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 26 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		style = 1024;
		onSliderPosChanged = "[_this select 0, _this select 1, 1010] call fnc_skillValueChanged;";
	};
	class battlevalue: RscSlider
	{
		idc = 1101;
		x = 8 * GUI_GRID_W + GUI_GRID_X;
		y = 11 * GUI_GRID_H + GUI_GRID_Y;
		w = 26 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		style = 1024;
		onSliderPosChanged = "[_this select 0, _this select 1, 1011] call fnc_skillValueChanged;";
	};
	class lockpickvalue: RscSlider
	{
		idc = 1102;
		x = 8 * GUI_GRID_W + GUI_GRID_X;
		y = 13 * GUI_GRID_H + GUI_GRID_Y;
		w = 26 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		style = 1024;
		onSliderPosChanged = "[_this select 0, _this select 1, 1012] call fnc_skillValueChanged;";
	};
	class engvalue: RscSlider
	{
		idc = 1103;
		x = 8 * GUI_GRID_W + GUI_GRID_X;
		y = 15 * GUI_GRID_H + GUI_GRID_Y;
		w = 26 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		style = 1024;
		onSliderPosChanged = "[_this select 0, _this select 1, 1013] call fnc_skillValueChanged;";
	};
	class strengthvalue: RscSlider
	{
		idc = 1104;
		x = 8 * GUI_GRID_W + GUI_GRID_X;
		y = 17 * GUI_GRID_H + GUI_GRID_Y;
		w = 26 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		style = 1024;
		onSliderPosChanged = "[_this select 0, _this select 1, 1014] call fnc_skillValueChanged;";
	};
	class staminavalue: RscSlider
	{
		idc = 1105;
		x = 8 * GUI_GRID_W + GUI_GRID_X;
		y = 19 * GUI_GRID_H + GUI_GRID_Y;
		w = 26 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		style = 1024;
		onSliderPosChanged = "[_this select 0, _this select 1, 1015] call fnc_skillValueChanged;";
	};
	class shootingnumber: RscText
	{
		idc = 1010;
		text = "0"; //--- ToDo: Localize;
		x = 35 * GUI_GRID_W + GUI_GRID_X;
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 3 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class battlenumber: RscText
	{
		idc = 1011;
		text = "0"; //--- ToDo: Localize;
		x = 35 * GUI_GRID_W + GUI_GRID_X;
		y = 11 * GUI_GRID_H + GUI_GRID_Y;
		w = 3 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class lockpicknumber: RscText
	{
		idc = 1012;
		text = "0"; //--- ToDo: Localize;
		x = 35 * GUI_GRID_W + GUI_GRID_X;
		y = 13 * GUI_GRID_H + GUI_GRID_Y;
		w = 3 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class engnumber: RscText
	{
		idc = 1013;
		text = "0"; //--- ToDo: Localize;
		x = 35 * GUI_GRID_W + GUI_GRID_X;
		y = 15 * GUI_GRID_H + GUI_GRID_Y;
		w = 3 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class strengthnumber: RscText
	{
		idc = 1014;
		text = "0"; //--- ToDo: Localize;
		x = 35 * GUI_GRID_W + GUI_GRID_X;
		y = 17 * GUI_GRID_H + GUI_GRID_Y;
		w = 3 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class staminanumber: RscText
	{
		idc = 1015;
		text = "0"; //--- ToDo: Localize;
		x = 35 * GUI_GRID_W + GUI_GRID_X;
		y = 19 * GUI_GRID_H + GUI_GRID_Y;
		w = 3 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class startbutton: RscButton
	{
		idc = 1600;
		text = "START"; //--- ToDo: Localize;
		x = 29 * GUI_GRID_W + GUI_GRID_X;
		y = 21 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 3 * GUI_GRID_H;
		action = "[] spawn fnc_characterRolled";
	};
	class nationalityselect: RscCombo
	{
		idc = 2100;
		x = 9 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		onLBSelChanged = "_this spawn fnc_charNatChanged;";
	};
	class religionselect: RscCombo
	{
		idc = 2101;
		x = 9 * GUI_GRID_W + GUI_GRID_X;
		y = 3 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT END
	////////////////////////////////////////////////////////


};