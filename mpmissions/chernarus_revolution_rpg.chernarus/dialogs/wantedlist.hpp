
class wantedlist_dialog
{
	idd = 50122;
	movingEnable = true;
	controlsBackground[] = {background};	
	objects[] = { };		
	controls[]=
	{
		playerlist,
		wantedtext,
		close,
		forgive,
		setwanted
	};

	class background: IGUIBack
	{
		idc = 2200;
		x = 0 * GUI_GRID_W + GUI_GRID_X;
		y = 0 * GUI_GRID_H + GUI_GRID_Y;
		w = 40 * GUI_GRID_W;
		h = 25 * GUI_GRID_H;
	};
	class playerlist: RscListbox
	{
		idc = 1500;
		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 13 * GUI_GRID_W;
		h = 23 * GUI_GRID_H;
		onLbSelChanged = "[] spawn fnc_wantedLbChanged;"; 
	};
	class wantedtext: RscStructuredText
	{
		idc = 1100;
		x = 15 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 24 * GUI_GRID_W;
		h = 21 * GUI_GRID_H;
	};
	class close: RscButton
	{
		idc = 1600;
		text = "Закрыть"; //--- ToDo: Localize;
		x = 32 * GUI_GRID_W + GUI_GRID_X;
		y = 23 * GUI_GRID_H + GUI_GRID_Y;
		w = 7 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0;";
	};
	class forgive: RscButton
	{
		idc = 1601;
		text = "Отпустить грехи"; //--- ToDo: Localize;
		x = 15 * GUI_GRID_W + GUI_GRID_X;
		y = 23 * GUI_GRID_H + GUI_GRID_Y;
		w = 7 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "if ((lbCurSel 1500)<0) exitWith {systemChat 'Вы никого не выбрали.';}; [lbData [1500, lbCurSel 1500]] spawn fnc_setPlayerUnWanted; closeDialog 0;";
	};
	class setwanted: RscButton
	{
		idc = 1602;
		text = "Объявить в розыск"; //--- ToDo: Localize;
		x = 23.5 * GUI_GRID_W + GUI_GRID_X;
		y = 23 * GUI_GRID_H + GUI_GRID_Y;
		w = 7 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0; [] spawn fnc_wantedSetMenu;";
	};


};