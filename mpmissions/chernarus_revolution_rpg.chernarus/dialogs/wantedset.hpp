
class wantedset_dialog
{
	idd = 50123;
	movingEnable = true;
	controlsBackground[] = {background};	
	objects[] = { };		
	controls[]=
	{
		background,
		playerlist,
		reasontext,
		setwanted,
		close
	};

	class background: IGUIBack
	{
		idc = 2200;
		x = 5 * GUI_GRID_W + GUI_GRID_X;
		y = 7 * GUI_GRID_H + GUI_GRID_Y;
		w = 30 * GUI_GRID_W;
		h = 5 * GUI_GRID_H;
	};
	class playerlist: RscCombo
	{
		idc = 2100;
		x = 6 * GUI_GRID_W + GUI_GRID_X;
		y = 8 * GUI_GRID_H + GUI_GRID_Y;
		w = 11 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class reasontext: RscEdit
	{
		idc = 1400;
		text = "Причина"; //--- ToDo: Localize;
		x = 6 * GUI_GRID_W + GUI_GRID_X;
		y = 10 * GUI_GRID_H + GUI_GRID_Y;
		w = 28 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class setwanted: RscButton
	{
		idc = 1600;
		text = "В розыск!"; //--- ToDo: Localize;
		x = 18 * GUI_GRID_W + GUI_GRID_X;
		y = 8 * GUI_GRID_H + GUI_GRID_Y;
		w = 7.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "if ((lbCurSel 2100)<0) exitWith {systemChat 'Вы никого не выбрали.';}; [lbData [2100,lbCurSel 2100], ctrlText 1400, 0, lbText [2100, lbCurSel 2100]] spawn fnc_setPlayerWanted; closeDialog 0;";
	};
	class close: RscButton
	{
		idc = 1601;
		text = "Закрыть"; //--- ToDo: Localize;
		x = 26.5 * GUI_GRID_W + GUI_GRID_X;
		y = 8 * GUI_GRID_H + GUI_GRID_Y;
		w = 7.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0;";
	};


};