
class civsearch_dialog
{
	idd = 50002;
	movingEnable = true;
	controlsBackground[] = {background};	
	objects[] = { };
	controls[]=
	{
		osmotr,
		restrain,
		allitems,
		allweapons,
		undress,
		close
	};

	class background: IGUIBack
	{
		idc = 2200;
		x = 10 * GUI_GRID_W + GUI_GRID_X;
		y = 0 * GUI_GRID_H + GUI_GRID_Y;
		w = 20 * GUI_GRID_W;
		h = 13 * GUI_GRID_H;
	};
	class osmotr: RscButton
	{
		idc = 1600;
		text = "Обыскать"; //--- ToDo: Localize;
		x = 11 * GUI_GRID_W + GUI_GRID_X;
		y = 3 * GUI_GRID_H + GUI_GRID_Y;
		w = 18 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0; if (!(cursearch getVariable 'search')) exitWith {}; call fnc_searchPlayer;";
	};
	class restrain: RscButton
	{
		idc = 1603;
		text = "Заковать/освободить"; //--- ToDo: Localize;
		x = 11 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 18 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "[] spawn fnc_restrainAction;";
	};
	class allitems: RscButton
	{
		idc = 1604;
		text = "Выложить все предметы"; //--- ToDo: Localize;
		x = 11 * GUI_GRID_W + GUI_GRID_X;
		y = 5 * GUI_GRID_H + GUI_GRID_Y;
		w = 18 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0; if (!(cursearch getVariable ['search',true])) exitWith {}; _par = format ['if (%1==player) then {call fnc_dropAllItems};',cursearch];if ((cursearch distance player)<=3) then {(compile _par) remoteExec ['call'];};";
	};
	class allweapons: RscButton
	{
		idc = 1605;
		text = "Выложить всё оружие"; //--- ToDo: Localize;
		x = 11 * GUI_GRID_W + GUI_GRID_X;
		y = 7 * GUI_GRID_H + GUI_GRID_Y;
		w = 18 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0; if (!(cursearch getVariable ['search',true])) exitWith {}; _par = format ['if (%1==player) then {call fnc_dropAllWeapons};',cursearch];if ((cursearch distance player)<=3) then {(compile _par) remoteExec ['call'];};";
	};
	class undress: RscButton
	{
		idc = 1606;
		text = "Раздеть"; //--- ToDo: Localize;
		x = 11 * GUI_GRID_W + GUI_GRID_X;
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 18 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0; if (!(cursearch getVariable ['search',true])) exitWith {}; _par = format ['if (%1==player) then {call fnc_dropAllDress};',cursearch];if ((cursearch distance player)<=3) then {(compile _par) remoteExec ['call'];};";
	};
	class close: RscButton
	{
		idc = 1608;
		text = "Закрыть"; //--- ToDo: Localize;
		x = 11 * GUI_GRID_W + GUI_GRID_X;
		y = 11 * GUI_GRID_H + GUI_GRID_Y;
		w = 18 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0";
	};

};