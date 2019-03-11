
class char_roll_dialog
{
	idd = 1488228;
	movingEnable = true;
	controlsBackground[] = {background};	
	objects[] = { };		
	controls[]=
	{
		photo,
		natregskills,
		playerinfo,
		startbutton,
		startbutton_hidden
	};

	class background: RscPicture
	{
		idc = 2200;
		x = 0.335 * safezoneW + safezoneX;
		y = 0.291 * safezoneH + safezoneY;
		w = 0.33 * safezoneW;
		h = 0.44 * safezoneH;
		text = "szag_data\pics\dialogs\char_roll\char_roll_background.paa";
	};
	class photo: RscPicture
	{
		idc = 1100;
		x = 0.530937 * safezoneW + safezoneX;
		y = 0.313 * safezoneH + safezoneY;
		w = 0.12375 * safezoneW;
		h = 0.198 * safezoneH;
	};
	class natregskills: RscStructuredText
	{
		idc = 1101;
		text = "Национальность:<br/>Вероисповедание:<br/>Навыки:<br/>Стрельба:<br/>Боевой опыт:<br/>Взлом:<br/>Инженерное дело:<br/>Сила:<br/>Выносливость:";
		x = 0.345312 * safezoneW + safezoneX;
		y = 0.313 * safezoneH + safezoneY;
		w = 0.175313 * safezoneW;
		h = 0.198 * safezoneH;
	};
	class playerinfo: RscStructuredText
	{
		idc = 1102;
		text = "Персонаж сгенерирован.";
		x = 0.345312 * safezoneW + safezoneX;
		y = 0.533 * safezoneH + safezoneY;
		w = 0.309375 * safezoneW;
		h = 0.11 * safezoneH;
	};
	class startbutton: RscPicture
	{
		idc = 1600;
		text = "szag_data\pics\dialogs\char_roll\start_button.paa";
		x = 0.4175 * safezoneW + safezoneX;
		y = 0.665 * safezoneH + safezoneY;
		w = 0.165 * safezoneW;
		h = 0.044 * safezoneH;
	};
	class startbutton_hidden: RscStructuredText
	{
		idc = 221600;
		x = 0.4175 * safezoneW + safezoneX;
		y = 0.665 * safezoneH + safezoneY;
		w = 0.165 * safezoneW;
		h = 0.044 * safezoneH;
		onMouseEnter="ctrlSetText [1600, ""szag_data\pics\dialogs\char_roll\start_button_hover.paa""]; playSound ""button_hover"";";
		onMouseExit="ctrlSetText [1600, ""szag_data\pics\dialogs\char_roll\start_button.paa""];";
		onMouseButtonDown = "closeDialog 0; playSound ""button_click"";";
		//action = "[] spawn fnc_characterRolled";
	};


};