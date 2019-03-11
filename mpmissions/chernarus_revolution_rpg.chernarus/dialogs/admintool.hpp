class admintool_dialog
{
	idd = 228322;
	movingEnable = true;
	controlsBackground[] = {IGUIBack_2200};	
	objects[] = { };		
	controls[]=
	{
		close,
		teleportation,
		addmoney,
		money_edit,
		adddeposit,
		rpp_edit,
		set_rpp,
		set_stress,
		stress_edit
	};
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT START (by Bowman, v1.063, #Cafiwo)
	////////////////////////////////////////////////////////

	class IGUIBack_2200: IGUIBack
	{
		idc = 2200;
		x = 0 * GUI_GRID_W + GUI_GRID_X;
		y = 0 * GUI_GRID_H + GUI_GRID_Y;
		w = 40 * GUI_GRID_W;
		h = 25 * GUI_GRID_H;
	};
	class close: RscButton
	{
		idc = 1600;
		text = "Close"; //--- ToDo: Localize;
		x = 33 * GUI_GRID_W + GUI_GRID_X;
		y = 22 * GUI_GRID_H + GUI_GRID_Y;
		w = 6 * GUI_GRID_W;
		h = 2 * GUI_GRID_H;
		action = "closeDialog 0;";
	};
	class teleportation: RscButton
	{
		idc = 1601;
		text = "Teleport"; //--- ToDo: Localize;
		x = 33 * GUI_GRID_W + GUI_GRID_X;
		y = 19 * GUI_GRID_H + GUI_GRID_Y;
		w = 6 * GUI_GRID_W;
		h = 2 * GUI_GRID_H;
		action = "[] spawn fnc_adminTeleport;";
	};
	class addmoney: RscButton
	{
		idc = 1602;
		text = "Добавить наличные"; //--- ToDo: Localize;
		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 3 * GUI_GRID_H + GUI_GRID_Y;
		w = 11 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "[] spawn fnc_adminAddNalik;";
	};
	class money_edit: RscEdit
	{
		idc = 1400;
		text = "10000"; //--- ToDo: Localize;
		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 11 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class adddeposit: RscButton
	{
		idc = 1603;
		text = "Добавить в банк"; //--- ToDo: Localize;
		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 5 * GUI_GRID_H + GUI_GRID_Y;
		w = 11 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "[] spawn fnc_adminAddBank;";
	};
	class rpp_edit: RscEdit
	{
		idc = 1401;
		text = "1000"; //--- ToDo: Localize;
		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 7 * GUI_GRID_H + GUI_GRID_Y;
		w = 11 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class set_rpp: RscButton
	{
		idc = 1604;
		text = "Установить RPP"; //--- ToDo: Localize;
		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 11 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "roleplay_pts = parseNumber (ctrlText 1401);";
	};
	class set_stress: RscButton
	{
		idc = 1605;
		text = "Установить усталость"; //--- ToDo: Localize;
		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 13 * GUI_GRID_H + GUI_GRID_Y;
		w = 11 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "stress_value = parseNumber (ctrlText 1402);";
	};
	class stress_edit: RscEdit
	{
		idc = 1402;
		text = "0"; //--- ToDo: Localize;
		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 11 * GUI_GRID_H + GUI_GRID_Y;
		w = 11 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};



};