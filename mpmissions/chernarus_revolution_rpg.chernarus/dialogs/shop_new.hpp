class generic_shop_dialog_new
{
	idd = 502289;
	movingEnable = true;
	controlsBackground[] = {};	
	objects[] = { };		
	controls[]=
	{
		buy_background,
		virt_description_background,
		shop_header,
		shopname,
		close,
		buyamount,
		sell_background,
		buyitem,
		sellitem,
		sellamount,
		buy_list,
		sell_list,
		class_virts,
		class_weaps,
		class_gear,
		class_vehs,
		playercash,
		virt_description,
		virt_desc2,
		magazines_background,
		accessoires_background,
		magazines_list,
		mags_amount,
		mag_buy,
		accessoires_list,
		accessoires_amount,
		accessoires_buy,
		buy_gear_list,
		gear_type_combo,
		veh_colors
	};

	class buy_background: IGUIBack
	{
		idc = 2200;
		x = 0.0101562 * safezoneW + safezoneX;
		y = 0.082 * safezoneH + safezoneY;
		w = 0.262969 * safezoneW;
		h = 0.902 * safezoneH;
	};
	class virt_description_background: IGUIBack
	{
		idc = 2201;
		x = 0.278281 * safezoneW + safezoneX;
		y = 0.687 * safezoneH + safezoneY;
		w = 0.268125 * safezoneW;
		h = 0.297 * safezoneH;
	};
	class shop_header: IGUIBack
	{
		idc = 2202;
		x = 0.0101562 * safezoneW + safezoneX;
		y = 0.016 * safezoneH + safezoneY;
		w = 0.979687 * safezoneW;
		h = 0.055 * safezoneH;
	};
	class shopname: RscText
	{
		idc = 1100;
		x = 0.0153125 * safezoneW + safezoneX;
		y = 0.027 * safezoneH + safezoneY;
		w = 0.252656 * safezoneW;
		h = 0.033 * safezoneH;
	};
	class close: RscButton
	{
		idc = 1600;
		text = "Закрыть"; //--- ToDo: Localize;
		x = 0.9125 * safezoneW + safezoneX;
		y = 0.027 * safezoneH + safezoneY;
		w = 0.0721875 * safezoneW;
		h = 0.033 * safezoneH;
		action = "closeDialog 0;";
	};
	class buyamount: RscEdit
	{
		idc = 1400;
		text = "1"; //--- ToDo: Localize;
		x = 0.0153125 * safezoneW + safezoneX;
		y = 0.94 * safezoneH + safezoneY;
		w = 0.180469 * safezoneW;
		h = 0.033 * safezoneH;
	};
	class sell_background: IGUIBack
	{
		idc = 2203;
		x = 0.726875 * safezoneW + safezoneX;
		y = 0.082 * safezoneH + safezoneY;
		w = 0.262969 * safezoneW;
		h = 0.902 * safezoneH;
	};
	class buyitem: RscButton
	{
		idc = 1601;
		text = "Купить"; //--- ToDo: Localize;
		x = 0.200937 * safezoneW + safezoneX;
		y = 0.94 * safezoneH + safezoneY;
		w = 0.0670312 * safezoneW;
		h = 0.033 * safezoneH;
		action = "(lbCurSel 1500) spawn fnc_newBuyItem;";
	};
	class sellitem: RscButton
	{
		idc = 1602;
		text = "Продать"; //--- ToDo: Localize;
		x = 0.917656 * safezoneW + safezoneX;
		y = 0.94 * safezoneH + safezoneY;
		w = 0.0670312 * safezoneW;
		h = 0.033 * safezoneH;
		action = "(lbCurSel 1501) spawn fnc_newSellItem;";
	};
	class sellamount: RscEdit
	{
		idc = 1401;
		text = "1"; //--- ToDo: Localize;
		x = 0.732031 * safezoneW + safezoneX;
		y = 0.94 * safezoneH + safezoneY;
		w = 0.180469 * safezoneW;
		h = 0.033 * safezoneH;
	};
	class buy_list: RscListbox
	{
		idc = 1500;
		x = 0.0153125 * safezoneW + safezoneX;
		y = 0.093 * safezoneH + safezoneY;
		w = 0.252656 * safezoneW;
		h = 0.836 * safezoneH;
		
		onLBSelChanged = "[(lbData [1500,(_this select 1)]),(_this select 1)] spawn fnc_tovarDescription;";
	};
	class sell_list: RscListbox
	{
		idc = 1501;
		x = 0.732031 * safezoneW + safezoneX;
		y = 0.093 * safezoneH + safezoneY;
		w = 0.252656 * safezoneW;
		h = 0.836 * safezoneH;
	};
	class class_virts: RscButton
	{
		idc = 1603;
		text = "Вирт. предметы"; //--- ToDo: Localize;
		x = 0.273125 * safezoneW + safezoneX;
		y = 0.027 * safezoneH + safezoneY;
		w = 0.0928125 * safezoneW;
		h = 0.033 * safezoneH;
		action = "[] spawn fnc_switchToVirtItems;";
	};
	class class_weaps: RscButton
	{
		idc = 1604;
		text = "Оружие"; //--- ToDo: Localize;
		x = 0.371094 * safezoneW + safezoneX;
		y = 0.027 * safezoneH + safezoneY;
		w = 0.0928125 * safezoneW;
		h = 0.033 * safezoneH;
		action = "[] spawn fnc_switchToWeapons;";
	};
	class class_gear: RscButton
	{
		idc = 1605;
		text = "Одежда и снаряжение"; //--- ToDo: Localize;
		x = 0.469062 * safezoneW + safezoneX;
		y = 0.027 * safezoneH + safezoneY;
		w = 0.0928125 * safezoneW;
		h = 0.033 * safezoneH;
		action = "[] spawn fnc_switchToGear;";
	};
	class class_vehs: RscButton
	{
		idc = 1606;
		text = "Техника"; //--- ToDo: Localize;
		x = 0.567031 * safezoneW + safezoneX;
		y = 0.027 * safezoneH + safezoneY;
		w = 0.0928125 * safezoneW;
		h = 0.033 * safezoneH;
		action = "[] spawn fnc_switchToVehs;";
	};
	class playercash: RscText
	{
		idc = 1101;
		x = 0.665 * safezoneW + safezoneX;
		y = 0.027 * safezoneH + safezoneY;
		w = 0.242344 * safezoneW;
		h = 0.033 * safezoneH;
	};
	class virt_description: RscStructuredText
	{
		idc = 1102;
		x = 0.283439 * safezoneW + safezoneX;
		y = 0.698 * safezoneH + safezoneY;
		w = 0.257813 * safezoneW;
		h = 0.209 * safezoneH;
	};
	class virt_desc2: RscStructuredText
	{
		idc = 1103;
		x = 0.283437 * safezoneW + safezoneX;
		y = 0.907 * safezoneH + safezoneY;
		w = 0.257813 * safezoneW;
		h = 0.066 * safezoneH;
	};
	
	class magazines_background: IGUIBack
	{
		idc = 2204;
		x = 0.726875 * safezoneW + safezoneX;
		y = 0.082 * safezoneH + safezoneY;
		w = 0.262969 * safezoneW;
		h = 0.44 * safezoneH;
	};
	class accessoires_background: IGUIBack
	{
		idc = 2205;
		x = 0.726875 * safezoneW + safezoneX;
		y = 0.544 * safezoneH + safezoneY;
		w = 0.262969 * safezoneW;
		h = 0.44 * safezoneH;
	};
	class magazines_list: RscListbox
	{
		idc = 1502;
		x = 0.732031 * safezoneW + safezoneX;
		y = 0.093 * safezoneH + safezoneY;
		w = 0.252656 * safezoneW;
		h = 0.374 * safezoneH;
		
		onLBSelChanged = "[(lbData [1502,(_this select 1)]),(_this select 1)] spawn fnc_tovarDescription2;";
	};
	class mags_amount: RscEdit
	{
		idc = 1402;
		text = "1"; //--- ToDo: Localize;
		x = 0.732031 * safezoneW + safezoneX; 
		y = 0.478 * safezoneH + safezoneY;
		w = 0.180469 * safezoneW;
		h = 0.033 * safezoneH;
	};
	class mag_buy: RscButton
	{
		idc = 1608;
		text = "Купить"; //--- ToDo: Localize;
		x = 0.917656 * safezoneW + safezoneX;
		y = 0.478 * safezoneH + safezoneY;
		w = 0.0670312 * safezoneW;
		h = 0.033 * safezoneH;
		action = "(lbCurSel 1502) spawn fnc_newBuyMag;";
	};
	class accessoires_list: RscListbox
	{
		idc = 1503;
		x = 0.732031 * safezoneW + safezoneX;
		y = 0.555 * safezoneH + safezoneY;
		w = 0.252656 * safezoneW;
		h = 0.374 * safezoneH;
		
		onLBSelChanged = "[(lbData [1503,(_this select 1)]),(_this select 1)] spawn fnc_tovarDescription2;";
	};
	class accessoires_amount: RscEdit
	{
		idc = 1403;
		text = "1"; //--- ToDo: Localize;
		x = 0.732031 * safezoneW + safezoneX;
		y = 0.94 * safezoneH + safezoneY;
		w = 0.180469 * safezoneW;
		h = 0.033 * safezoneH;
	};
	class accessoires_buy: RscButton
	{
		idc = 1607;
		text = "Купить"; //--- ToDo: Localize;
		x = 0.917656 * safezoneW + safezoneX;
		y = 0.94 * safezoneH + safezoneY;
		w = 0.0670312 * safezoneW;
		h = 0.033 * safezoneH;
		action = "(lbCurSel 1503) spawn fnc_newBuyAcc;";
	};
	
	class buy_gear_list: RscListbox
	{
		idc = 1504;
		x = 0.0153121 * safezoneW + safezoneX;
		y = 0.137 * safezoneH + safezoneY;
		w = 0.252656 * safezoneW;
		h = 0.792 * safezoneH;
		
		onLBSelChanged = "[(lbData [1504,(_this select 1)]),(_this select 1)] spawn fnc_tovarDescription;";
	};
	class gear_type_combo: RscCombo
	{
		idc = 2106;
		x = 0.0153125 * safezoneW + safezoneX;
		y = 0.093 * safezoneH + safezoneY;
		w = 0.252656 * safezoneW;
		h = 0.033 * safezoneH;
		
		onLBSelChanged = "[(lbData [2106,(_this select 1)])] spawn fnc_switchToGear_something;";
	};
	class veh_colors: RscCombo
	{
		idc = 2107;
		x = 0.0153125 * safezoneW + safezoneX;
		y = 0.093 * safezoneH + safezoneY;
		w = 0.252656 * safezoneW;
		h = 0.033 * safezoneH;
		
		onLBSelChanged = "[] spawn fnc_shopShowCarColor;";
	};

};