class carbomb_remote_pult
{
	idd = 500192;
	movingEnable = true;
	controlsBackground[] = {IGUIBack_2200};	
	objects[] = { };		
	controls[]=
	{
		my_edit,
		RscText_1000,
		close,
		explode
	};

	class IGUIBack_2200: IGUIBack
	{
		idc = 2200;
		x = 11 * GUI_GRID_W + GUI_GRID_X;
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 18 * GUI_GRID_W;
		h = 5 * GUI_GRID_H;
	};
	class my_edit: RscEdit
	{
		idc = 1400;
		x = 18 * GUI_GRID_W + GUI_GRID_X;
		y = 10 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class RscText_1000: RscText
	{
		idc = 1000;
		text = "Введите код:"; //--- ToDo: Localize;
		x = 12 * GUI_GRID_W + GUI_GRID_X;
		y = 10 * GUI_GRID_H + GUI_GRID_Y;
		w = 5.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class close: RscButton
	{
		idc = 1600;
		text = "Закрыть"; //--- ToDo: Localize;
		x = 12 * GUI_GRID_W + GUI_GRID_X;
		y = 12 * GUI_GRID_H + GUI_GRID_Y;
		w = 7.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0;";
	};
	class explode: RscButton
	{
		idc = 1601;
		text = "Подтвердить"; //--- ToDo: Localize;
		x = 20.5 * GUI_GRID_W + GUI_GRID_X;
		y = 12 * GUI_GRID_H + GUI_GRID_Y;
		w = 7.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "[] spawn fnc_plantCarBomb_remote_explode_mepls";
	};



};