#define GUI_GRID_X	(0)
#define GUI_GRID_Y	(0)
#define GUI_GRID_W	(0.025)
#define GUI_GRID_H	(0.04)
#define GUI_GRID_WAbs	(1)
#define GUI_GRID_HAbs	(1)

class playerlist
{
	idd = 50017;
	movingEnable = true;
	controlsBackground[] = {IGUIBack_2200};	
	objects[] = { };		
	controls[]=
	{
		rp_stats,
		state_data,
		rp_data,
		cooldowns,
		licenses,
		cooldowns_lb,
		licenses_lb,
		skills,
		show_license,
		close,
		cooldown_desc
	};
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT START (by Bowman, v1.063, #Fumuxi)
	////////////////////////////////////////////////////////

	class IGUIBack_2200: IGUIBack
	{
		idc = 2200;
		x = -9 * GUI_GRID_W + GUI_GRID_X;
		y = 0 * GUI_GRID_H + GUI_GRID_Y;
		w = 58 * GUI_GRID_W;
		h = 25 * GUI_GRID_H;
	};
	class rp_stats: RscStructuredText
	{
		idc = 1100;
		x = 11 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 18 * GUI_GRID_W;
		h = 4 * GUI_GRID_H;
	};
	class state_data: RscStructuredText
	{
		idc = 1101;
		x = 30 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 18 * GUI_GRID_W;
		h = 20 * GUI_GRID_H;
	};
	class rp_data: RscStructuredText
	{
		idc = 1102;
		x = -8 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 18 * GUI_GRID_W;
		h = 4 * GUI_GRID_H;
	};
	class cooldowns: RscText
	{
		idc = 1000;
		text = "Кулдауны:"; //--- ToDo: Localize;
		x = -8 * GUI_GRID_W + GUI_GRID_X;
		y = 6 * GUI_GRID_H + GUI_GRID_Y;
		w = 4.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class licenses: RscText
	{
		idc = 1001;
		text = "Лицензии:"; //--- ToDo: Localize;
		x = 11 * GUI_GRID_W + GUI_GRID_X;
		y = 6 * GUI_GRID_H + GUI_GRID_Y;
		w = 4.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class cooldowns_lb: RscListbox
	{
		idc = 1500;
		x = -8 * GUI_GRID_W + GUI_GRID_X;
		y = 7 * GUI_GRID_H + GUI_GRID_Y;
		w = 18 * GUI_GRID_W;
		h = 7 * GUI_GRID_H;
		onLBSelChanged = "(_this select 1) spawn fnc_cooldownDescription;";
	};
	class licenses_lb: RscListbox
	{
		idc = 1501;
		x = 11 * GUI_GRID_W + GUI_GRID_X;
		y = 7 * GUI_GRID_H + GUI_GRID_Y;
		w = 18 * GUI_GRID_W;
		h = 7 * GUI_GRID_H;
	};
	class skills: RscStructuredText
	{
		idc = 1103;
		x = 11 * GUI_GRID_W + GUI_GRID_X;
		y = 18 * GUI_GRID_H + GUI_GRID_Y;
		w = 18 * GUI_GRID_W;
		h = 6 * GUI_GRID_H;
	};
	class show_license: RscButton
	{
		idc = 1600;
		text = "Показать лицензию стоящим рядом"; //--- ToDo: Localize;
		x = 11 * GUI_GRID_W + GUI_GRID_X;
		y = 15 * GUI_GRID_H + GUI_GRID_Y;
		w = 18 * GUI_GRID_W;
		h = 2 * GUI_GRID_H;
		onMouseButtonDown = "if ((lbCurSel 1501)>-1) then {[lbText [1501, (lbCurSel 1501)]] call fnc_showLicenseToAll;};";
	};
	class close: RscButton
	{
		idc = 1601;
		text = "ЗАКРЫТЬ"; //--- ToDo: Localize;
		x = 30 * GUI_GRID_W + GUI_GRID_X;
		y = 22 * GUI_GRID_H + GUI_GRID_Y;
		w = 18 * GUI_GRID_W;
		h = 2 * GUI_GRID_H;
		action = "closeDialog 0;";
	};
	class cooldown_desc: RscStructuredText
	{
		idc = 1104;
		text = "Описание кулдауна"; //--- ToDo: Localize;
		x = -8 * GUI_GRID_W + GUI_GRID_X;
		y = 15 * GUI_GRID_H + GUI_GRID_Y;
		w = 18 * GUI_GRID_W;
		h = 9 * GUI_GRID_H;
	};
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT END
	////////////////////////////////////////////////////////

	
};
