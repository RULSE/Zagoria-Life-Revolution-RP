
class keys_menu
{
	idd = 50015;
	movingEnable = true;
	controlsBackground[] = {background};	
	objects[] = { };		
	controls[]=
	{
		keylist,
		selectplayer,
		give,
		drop,
		close
	};

	class background: IGUIBack
	{
		idc = 2200;
		x = 5 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 30 * GUI_GRID_W;
		h = 20 * GUI_GRID_H;
	};
	class keylist: RscListbox
	{
		idc = 1500;
		x = 6 * GUI_GRID_W + GUI_GRID_X;
		y = 2 * GUI_GRID_H + GUI_GRID_Y;
		w = 18 * GUI_GRID_W;
		h = 18 * GUI_GRID_H;
	};
	class selectplayer: RscCombo
	{
		idc = 2100;
		x = 25 * GUI_GRID_W + GUI_GRID_X;
		y = 2 * GUI_GRID_H + GUI_GRID_Y;
		w = 9 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class give: RscButton
	{
		idc = 1600;
		text = "Передать"; //--- ToDo: Localize;
		x = 25 * GUI_GRID_W + GUI_GRID_X;
		y = 4 * GUI_GRID_H + GUI_GRID_Y;
		w = 9 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "[lbText [2100,lbCurSel 2100],(lbCurSel 1500)] call fnc_giveKey;";
	};
	class drop: RscButton
	{
		idc = 1601;
		text = "Выбросить"; //--- ToDo: Localize;
		x = 25 * GUI_GRID_W + GUI_GRID_X;
		y = 6 * GUI_GRID_H + GUI_GRID_Y;
		w = 9 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "[(lbCurSel 1500)] call fnc_dropKey;";
	};
	class close: RscButton
	{
		idc = 1602;
		text = "Закрыть"; //--- ToDo: Localize;
		x = 25 * GUI_GRID_W + GUI_GRID_X;
		y = 8 * GUI_GRID_H + GUI_GRID_Y;
		w = 9 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0";
	};

};
