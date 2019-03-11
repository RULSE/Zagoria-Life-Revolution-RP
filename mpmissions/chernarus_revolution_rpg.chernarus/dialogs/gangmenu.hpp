
class gang_menu_dialog
{
	idd = 50009;
	movingEnable = true;
	controlsBackground[] = {background};	
	objects[] = { };		
	controls[]=
	{
		memberlist,
		close,
		inviteplayer,
		invitetext,
		opengroupstatus,
		playerlist,
		kickplayer,
		//upgradeplayer,
		//makeanowner,
		RscStructuredText_1100,
		rasformir
	};

	class background: IGUIBack
	{
		idc = 2200;
		x = 0 * GUI_GRID_W + GUI_GRID_X;
		y = 0 * GUI_GRID_H + GUI_GRID_Y;
		w = 40 * GUI_GRID_W;
		h = 25 * GUI_GRID_H;
	};
	class memberlist: RscListbox
	{
		idc = 1500;
		x = 1 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 21 * GUI_GRID_W;
		h = 23 * GUI_GRID_H;
	};
	class close: RscButton
	{
		idc = 1600;
		text = "Закрыть"; //--- ToDo: Localize;
		x = 23 * GUI_GRID_W + GUI_GRID_X;
		y = 23 * GUI_GRID_H + GUI_GRID_Y;
		w = 16 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0;";
	};
	class inviteplayer: RscButton
	{
		idc = 1601;
		text = "Пригласить игрока"; //--- ToDo: Localize;
		x = 23 * GUI_GRID_W + GUI_GRID_X;
		y = 3 * GUI_GRID_H + GUI_GRID_Y;
		w = 16 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "[] spawn fnc_invitePlayerToGang;";
	};
	class invitetext: RscText
	{
		idc = 1000;
		text = "Свободное вступление"; //--- ToDo: Localize;
		x = 23 * GUI_GRID_W + GUI_GRID_X;
		y = 5 * GUI_GRID_H + GUI_GRID_Y;
		w = 8.5 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class opengroupstatus: RscCombo
	{
		idc = 2100;
		x = 32 * GUI_GRID_W + GUI_GRID_X;
		y = 5 * GUI_GRID_H + GUI_GRID_Y;
		w = 7 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		onLBSelChanged = "(_this select 1) spawn fnc_gangAllowJoin;";
	};
	class playerlist: RscCombo
	{
		idc = 2101;
		x = 23 * GUI_GRID_W + GUI_GRID_X;
		y = 1 * GUI_GRID_H + GUI_GRID_Y;
		w = 16 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class kickplayer: RscButton
	{
		idc = 1602;
		text = "Выгнать выбранного игрока"; //--- ToDo: Localize;
		x = 23 * GUI_GRID_W + GUI_GRID_X;
		y = 7 * GUI_GRID_H + GUI_GRID_Y;
		w = 16 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "[] spawn fnc_kickPlayerFromGang;";
	};
	//убрано за ненадобностью
	/*class upgradeplayer: RscButton
	{
		idc = 1603;
		text = "Выдать права руководителя/разжаловать"; //--- ToDo: Localize;
		x = 23 * GUI_GRID_W + GUI_GRID_X;
		y = 9 * GUI_GRID_H + GUI_GRID_Y;
		w = 16 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "[] spawn fnc_makePlayerDeputyOfGang;";
	};*/
	//для предотвращения абуза, так как группировка удаляется при смерти главаря от рук бандитов или мусоров
	/*class makeanowner: RscButton
	{
		idc = 1604;
		text = "Сделать владельцем группировки"; //--- ToDo: Localize;
		x = 23 * GUI_GRID_W + GUI_GRID_X;
		y = 11 * GUI_GRID_H + GUI_GRID_Y;
		w = 16 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "[] spawn fnc_makePlayerOwnerOfGang;";
	};*/
	class RscStructuredText_1100: RscStructuredText
	{
		idc = 1100;
		x = 23 * GUI_GRID_W + GUI_GRID_X;
		y = 15 * GUI_GRID_H + GUI_GRID_Y;
		w = 16 * GUI_GRID_W;
		h = 7 * GUI_GRID_H;
	};
	class rasformir: RscButton
	{
		idc = 1605;
		text = "Удалить группировку"; //--- ToDo: Localize;
		x = 23 * GUI_GRID_W + GUI_GRID_X;
		y = 13 * GUI_GRID_H + GUI_GRID_Y;
		w = 16 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0; [] spawn fnc_deleteGang;";
	};

};