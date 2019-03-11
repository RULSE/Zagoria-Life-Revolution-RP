
class respawn_dialog
{
	idd = 501234;
	movingEnable = true;
	controlsBackground[] = {background};	
	objects[] = { };		
	controls[]=
	{
		spawnlist,
		mapitem,
		joingame,
		tolobby
	};
	////////////////////////////////////////////////////////
	// GUI EDITOR OUTPUT START (by Bowman, v1.063, #Papeky)
	////////////////////////////////////////////////////////

	class background: IGUIBack
	{
		idc = 2200;
		x = 0 * GUI_GRID_W + GUI_GRID_X;
		y = 2 * GUI_GRID_H + GUI_GRID_Y;
		w = 40 * GUI_GRID_W;
		h = 21 * GUI_GRID_H;
	};
	class spawnlist: RscListbox
	{
		idc = 1500;
		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 3 * GUI_GRID_H + GUI_GRID_Y;
		w = 18 * GUI_GRID_W;
		h = 19 * GUI_GRID_H;
		onLbSelChanged = "_this spawn fnc_onRespawnSelect;";
	};
	class mapitem: RscMapControl
	{
		idc = 1200;
		x = 20 * GUI_GRID_W + GUI_GRID_X;
		y = 3 * GUI_GRID_H + GUI_GRID_Y;
		w = 19 * GUI_GRID_W;
		h = 16 * GUI_GRID_H;
			
		maxSatelliteAlpha = 0.5;
		alphaFadeStartScale = 1;
		alphaFadeEndScale = 0.3;
	};
	class joingame: RscButton
	{
		idc = 1600;
		text = "Появиться"; //--- ToDo: Localize;
		x = 20 * GUI_GRID_W + GUI_GRID_X;
		y = 20 * GUI_GRID_H + GUI_GRID_Y;
		w = 9 * GUI_GRID_W;
		h = 2 * GUI_GRID_H;
		action = "[] spawn fnc_respawnMe;";
	};
	class tolobby: RscButton
	{
		idc = 1601;
		text = "В лобби"; //--- ToDo: Localize;
		x = 30 * GUI_GRID_W + GUI_GRID_X;
		y = 20 * GUI_GRID_H + GUI_GRID_Y;
		w = 9 * GUI_GRID_W;
		h = 2 * GUI_GRID_H;
		action = "closeDialog 0; endMission 'wat';";
	};


};