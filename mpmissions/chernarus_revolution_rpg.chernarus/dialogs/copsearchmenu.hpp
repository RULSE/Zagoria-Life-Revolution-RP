
class copsearch_dialog
{
	idd = 50003;
	movingEnable = true;
	controlsBackground[] = {background};	
	objects[] = { };		
	controls[]=
	{
		osmotr,
		illegalstuff,
		fine_edit,
		fine,
		restrain,
		allitems,
		allweapons,
		undress,
		arrest,
		arrest_value,
		close
	};
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT START (by Bowman, v1.063, #Hacuhy)
	////////////////////////////////////////////////////////

	class background: IGUIBack
	{
		idc = 2200;
		x = 10 * GUI_GRID_W + GUI_GRID_X;
		y = 0 * GUI_GRID_H + GUI_GRID_Y;
		w = 20 * GUI_GRID_W;
		h = 21 * GUI_GRID_H;
	};
	class osmotr: RscButton
	{
		idc = 1600;
		text = "Осмотр"; //--- ToDo: Localize;
		x = 11 * GUI_GRID_W + GUI_GRID_X;
		y = 3 * GUI_GRID_H + GUI_GRID_Y;
		w = 18 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0; if (!(cursearch getVariable 'search')) exitWith {}; call fnc_searchPlayerCop;";
	};
	class illegalstuff: RscButton
	{
		idc = 1601;
		text = "Обыск и изъятие"; //--- ToDo: Localize;
		x = 11 * GUI_GRID_W + GUI_GRID_X;
		y = 5 * GUI_GRID_H + GUI_GRID_Y;
		w = 18 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "[] spawn fnc_searchAction;";
	};
	class fine_edit: RscEdit
	{
		idc = 1400;
		text = "0"; //--- ToDo: Localize;
		x = 11 * GUI_GRID_W + GUI_GRID_X;
		y = 7 * GUI_GRID_H + GUI_GRID_Y;
		w = 11 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class fine: RscButton
	{
		idc = 1602;
		text = "Штраф"; //--- ToDo: Localize;
		x = 23 * GUI_GRID_W + GUI_GRID_X;
		y = 7 * GUI_GRID_H + GUI_GRID_Y;
		w = 6 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "[] spawn fnc_fineAction;";
	};
	class restrain: RscButton
	{
		idc = 1603;
		text = "Заковать/отпустить"; //--- ToDo: Localize;
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
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 18 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0; if (!(cursearch getVariable ['search',true])) exitWith {}; _par = format ['if (%1==player) then {call fnc_dropAllItems};',cursearch];if ((cursearch distance player)<=3) then {(compile _par) remoteExec ['call'];};";
	};
	class allweapons: RscButton
	{
		idc = 1605;
		text = "Обезоружить"; //--- ToDo: Localize;
		x = 11 * GUI_GRID_W + GUI_GRID_X;
		y = 11 * GUI_GRID_H + GUI_GRID_Y;
		w = 18 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0; if (!(cursearch getVariable ['search',true])) exitWith {}; _par = format ['if (%1==player) then {call fnc_dropAllWeapons};',cursearch];if ((cursearch distance player)<=3) then {(compile _par) remoteExec ['call'];};";
	};
	class undress: RscButton
	{
		idc = 1606;
		text = "Раздеть"; //--- ToDo: Localize;
		x = 11 * GUI_GRID_W + GUI_GRID_X;
		y = 13 * GUI_GRID_H + GUI_GRID_Y;
		w = 18 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0; if (!(cursearch getVariable ['search',true])) exitWith {}; _par = format ['if (%1==player) then {call fnc_dropAllDress};',cursearch];if ((cursearch distance player)<=3) then {(compile _par) remoteExec ['call'];};";
	};
	class arrest: RscButton
	{
		idc = 1607;
		text = "Арестовать на 1 минут"; //--- ToDo: Localize;
		x = 11 * GUI_GRID_W + GUI_GRID_X;
		y = 17 * GUI_GRID_H + GUI_GRID_Y;
		w = 18 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "[sliderPosition 1100,cursearch] call fnc_arrestAction;";
	};
	class arrest_value: RscSlider
	{
		idc = 1100;
		x = 11 * GUI_GRID_W + GUI_GRID_X;
		y = 15 * GUI_GRID_H + GUI_GRID_Y;
		w = 18 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		onSliderPosChanged = "[_this select 0, _this select 1, 1607] call fnc_copInteractionArrestSliderChanged;";
	};
	class close: RscButton
	{
		idc = 1608;
		text = "Закрыть"; //--- ToDo: Localize;
		x = 11 * GUI_GRID_W + GUI_GRID_X;
		y = 19 * GUI_GRID_H + GUI_GRID_Y;
		w = 18 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0;";
	};

};