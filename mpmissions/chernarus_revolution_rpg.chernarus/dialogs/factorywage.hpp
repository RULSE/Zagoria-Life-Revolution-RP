class factorywage_dialog
{
	idd = 50005;
	movingEnable = true;
	controlsBackground[] = {background};	
	objects[] = { };		
	controls[] = {kassa, wage, close, amount, setwage, putmoney, takemoney, close};	
	
	class background: IGUIBack
	{
		idc = 2200;
		x = 14 * GUI_GRID_W + GUI_GRID_X;
		y = 6 * GUI_GRID_H + GUI_GRID_Y;
		w = 12 * GUI_GRID_W;
		h = 14 * GUI_GRID_H;
	};
	class kassa: RscText
	{
		idc = 1000;
		text = "Касса:"; //--- ToDo: Localize;
		x = 15 * GUI_GRID_W + GUI_GRID_X;
		y = 7 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class wage: RscText
	{
		idc = 1001;
		text = "Зарплата:"; //--- ToDo: Localize;
		x = 15 * GUI_GRID_W + GUI_GRID_X;
		y = 8 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class amount: RscEdit
	{
		idc = 1400;
		text = "0"; //--- ToDo: Localize;
		x = 15 * GUI_GRID_W + GUI_GRID_X;
		y = 10 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
	};
	class setwage: RscButton
	{
		idc = 1600;
		text = "Установить зарплату"; //--- ToDo: Localize;
		x = 15 * GUI_GRID_W + GUI_GRID_X;
		y = 12 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "(parseNumber (ctrlText 1400)) call fnc_factorySetWage; closeDialog 0;";
	};
	class putmoney: RscButton
	{
		idc = 1601;
		text = "Положить деньги в кассу"; //--- ToDo: Localize;
		x = 15 * GUI_GRID_W + GUI_GRID_X;
		y = 14 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "(parseNumber (ctrlText 1400)) call fnc_factoryPutMoney; closeDialog 0;";
	};
	class takemoney: RscButton
	{
		idc = 1602;
		text = "Взять деньги из кассы"; //--- ToDo: Localize;
		x = 15 * GUI_GRID_W + GUI_GRID_X;
		y = 16 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "(parseNumber (ctrlText 1400)) call fnc_factoryTakeMoney; closeDialog 0;";
	};
	class close: RscButton
	{
		idc = 1603;
		text = "Закрыть"; //--- ToDo: Localize;
		x = 15 * GUI_GRID_W + GUI_GRID_X;
		y = 18 * GUI_GRID_H + GUI_GRID_Y;
		w = 10 * GUI_GRID_W;
		h = 1 * GUI_GRID_H;
		action = "closeDialog 0";
	};

};