
class atm_dialog
{
	idd = 50001;
	movingEnable = true;
	controlsBackground[] = {background};	
	objects[] = { };		
	controls[] = {account, amount, deposit, withdraw, playerselect, transfer, close};	
	
	class background: RscPicture
	{
		idc = 2200;
		text = "szag_data\pics\dialogs\atm\atm_bg.paa";
		x = 0.29375 * safezoneW + safezoneX;
		y = 0.225 * safezoneH + safezoneY;
		w = 0.4125 * safezoneW;
		h = 0.55 * safezoneH;
	};
	class account: RscStructuredText
	{
		idc = 1001;
		x = 0.355625 * safezoneW + safezoneX;
		y = 0.423 * safezoneH + safezoneY;
		w = 0.149531 * safezoneW;
		h = 0.077 * safezoneH;
	};
	class amount: RscEdit
	{
		idc = 1400;
		text = "0"; //--- ToDo: Localize;
		x = 0.530937 * safezoneW + safezoneX;
		y = 0.456 * safezoneH + safezoneY;
		w = 0.0825 * safezoneW;
		h = 0.033 * safezoneH;
	};
	class deposit: RscButtonHidden
	{
		idc = 1600;
		text = ""; //--- ToDo: Localize;
		x = 0.530937 * safezoneW + safezoneX;
		y = 0.511 * safezoneH + safezoneY;
		w = 0.108281 * safezoneW;
		h = 0.044 * safezoneH;
		action = "call compile format ['%1 call fnc_atm_deposit', ctrlText 1400]; closedialog 0;";
	};
	class withdraw: RscButtonHidden
	{
		idc = 1601;
		text = ""; //--- ToDo: Localize;
		x = 0.530937 * safezoneW + safezoneX;
		y = 0.577 * safezoneH + safezoneY;
		w = 0.108281 * safezoneW;
		h = 0.055 * safezoneH;
		action = "call compile format ['%1 call fnc_atm_withdraw', ctrlText 1400]; closedialog 0;";
	};
	class playerselect: RscCombo
	{
		idc = 2100;
		x = 0.355625 * safezoneW + safezoneX;
		y = 0.522 * safezoneH + safezoneY;
		w = 0.113437 * safezoneW;
		h = 0.033 * safezoneH;
	};
	class transfer: RscButtonHidden
	{
		idc = 1602;
		text = ""; //--- ToDo: Localize;
		x = 0.355625 * safezoneW + safezoneX;
		y = 0.577 * safezoneH + safezoneY;
		w = 0.113437 * safezoneW;
		h = 0.055 * safezoneH;
		action = "[] spawn fnc_atmTransferMoney;";
	};
	class close: RscButtonHidden
	{
		idc = 1603;
		text = ""; //--- ToDo: Localize;
		x = 0.530937 * safezoneW + safezoneX;
		y = 0.643 * safezoneH + safezoneY;
		w = 0.108281 * safezoneW;
		h = 0.055 * safezoneH;
		action = "closeDialog 0";
	};

};