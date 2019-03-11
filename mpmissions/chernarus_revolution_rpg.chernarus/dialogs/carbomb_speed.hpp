class carbomb_speed_dialog
{
	idd = 500191;
	movingEnable = true;
	controlsBackground[] = {IGUIBack_2200};	
	objects[] = { };		
	controls[]=
	{
		speed_slider,
		act_speed,
		check_message,
		RscText_1001,
		message_edit,
		close,
		plant_this
	};

	class IGUIBack_2200: IGUIBack
	{
		idc = 2200;
		x = 0 * GUI_GRID_W + GUI_GRID_X;
		y = 5 * GUI_GRID_H + GUI_GRID_Y;
		w = 40 * GUI_GRID_W;
		h = 7 * GUI_GRID_H;
	};
	class speed_slider: RscSlider
	{
		idc = 1900;
		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 6 * GUI_GRID_H + GUI_GRID_Y;
		w = 26 * GUI_GRID_W;
		h = 1.5 * GUI_GRID_H;
		onSliderPosChanged = "[_this select 0, _this select 1, 1900] call fnc_plantCarBomb_speed_menu_slider;";
	};
	class act_speed: RscText
	{
		idc = 1000;
		text = "Скорость активации: 50 км/ч"; //--- ToDo: Localize;
		x = 27.5 * GUI_GRID_W + GUI_GRID_X;
		y = 6 * GUI_GRID_H + GUI_GRID_Y;
		w = 12 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class check_message: RscCheckbox
	{
		idc = 2800;
		text = "Прощальное сообщение"; //--- ToDo: Localize;
		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 8 * GUI_GRID_H + GUI_GRID_Y;
		w = 1.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class RscText_1001: RscText
	{
		idc = 1001;
		text = "Прощальное сообщение"; //--- ToDo: Localize;
		x = 2.5 * GUI_GRID_W + GUI_GRID_X;
		y = 8 * GUI_GRID_H + GUI_GRID_Y;
		w = 9 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class message_edit: RscEdit
	{
		idc = 1400;
		text = "привет"; //--- ToDo: Localize;
		x = 13 * GUI_GRID_W + GUI_GRID_X;
		y = 8 * GUI_GRID_H + GUI_GRID_Y;
		w = 26 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class close: RscButton
	{
		idc = 1600;
		text = "Закрыть"; //--- ToDo: Localize;
		x = 34 * GUI_GRID_W + GUI_GRID_X;
		y = 10 * GUI_GRID_H + GUI_GRID_Y;
		w = 5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0;";
	};
	class plant_this: RscButton
	{
		idc = 1601;
		text = "Установить"; //--- ToDo: Localize;
		x = 28 * GUI_GRID_W + GUI_GRID_X;
		y = 10 * GUI_GRID_H + GUI_GRID_Y;
		w = 5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "[] spawn fnc_plantCarBomb_speed;";
	};


};