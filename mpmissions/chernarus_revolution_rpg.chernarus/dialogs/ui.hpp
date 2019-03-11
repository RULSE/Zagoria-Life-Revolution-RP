class hud_res
{
	idd=-1;
	movingEnable=0;
  	fadein=0;
	duration = 10e10;
  	fadeout=0;
	name="hud_res";
	onLoad = "uiNamespace setVariable ['hud_res',_this select 0]";
	onUnload = "uiNamespace setVariable ['hud_res', objNull]";
	onDestroy = "uiNamespace setVariable ['hud_res', objNull]";
	objects[]={};
	class controls
	{
		class fps_info: RscStructuredText
		{
			idc = 23500;
			text = "<t size='1.5' font='Zeppelin33' color='#05ff05'></t>";
			
			x = 0.005 * safezoneW + safezoneX;
			y = 0.115 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.055 * safezoneH;
			colorBackground[] = {1,1,1,0};
			sizeEx = 1 * GUI_GRID_H;
		};

		class hud_health_background: RscProgress
		{
			idc = 11003;
			style = 1;
			x = 0.969219 * safezoneW + safezoneX;
			y = 0.841 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.132 * safezoneH;
			texture = "szag_data\pics\hud\health_hud_background.paa";
		};
		class hud_hunger_background: RscProgress
		{
			idc = 11013;
			style = 1;
			x = 0.938281 * safezoneW + safezoneX;
			y = 0.841 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.132 * safezoneH;
			texture = "szag_data\pics\hud\food_hud_background.paa";
		};
		class hud_thirst_background: RscProgress
		{
			idc = 11023;
			style = 1;
			x = 0.907344 * safezoneW + safezoneX;
			y = 0.841 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.132 * safezoneH;
			texture = "szag_data\pics\hud\thirst_hud_background.paa";
		};
		class hud_stress_background: RscProgress
		{
			idc = 11033;
			style = 1;
			x = 0.876406 * safezoneW + safezoneX;
			y = 0.841 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.132 * safezoneH;
			texture = "szag_data\pics\hud\stress_hud_background.paa";
		};

		class hud_health: RscProgress
		{
			idc = 1100;
			style = 1;
			x = 0.969219 * safezoneW + safezoneX;
			y = 0.841 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.132 * safezoneH;
			texture = "szag_data\pics\hud\health_hud.paa";
		};
		class hud_hunger: RscProgress
		{
			idc = 1101;
			style = 1;
			x = 0.938281 * safezoneW + safezoneX;
			y = 0.841 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.132 * safezoneH;
			texture = "szag_data\pics\hud\food_hud.paa";
		};
		class hud_thirst: RscProgress
		{
			idc = 1102;
			style = 1;
			x = 0.907344 * safezoneW + safezoneX;
			y = 0.841 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.132 * safezoneH;
			texture = "szag_data\pics\hud\thirst_hud.paa";
		};
		class hud_stress: RscProgress
		{
			idc = 1103;
			style = 1;
			x = 0.876406 * safezoneW + safezoneX;
			y = 0.841 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.132 * safezoneH;
			texture = "szag_data\pics\hud\stress_hud.paa";
		};

		class hud_health_icon: RscPicture
		{
			idc = 1100;
			x = 0.969219 * safezoneW + safezoneX;
			y = 0.841 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.132 * safezoneH;
			text = "szag_data\pics\hud\health_hud_icon.paa";
		};
		class hud_hunger_icon: RscPicture
		{
			idc = 1101;
			x = 0.938281 * safezoneW + safezoneX;
			y = 0.841 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.132 * safezoneH;
			text = "szag_data\pics\hud\food_hud_icon.paa";
		};
		class hud_thirst_icon: RscPicture
		{
			idc = 1102;
			x = 0.907344 * safezoneW + safezoneX;
			y = 0.841 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.132 * safezoneH;
			text = "szag_data\pics\hud\thirst_hud_icon.paa";
		};
		class hud_stress_icon: RscPicture
		{
			idc = 1103;
			x = 0.876406 * safezoneW + safezoneX;
			y = 0.841 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.132 * safezoneH;
			text = "szag_data\pics\hud\stress_hud_icon.paa";
		};
		class hud_tab_pic: RscPicture
		{
			idc = 1104;
			x = 0.804219 * safezoneW + safezoneX;
			y = 0.874 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.055 * safezoneH;
			text = "szag_data\pics\hud\tab_pic.paa";
		};
		class hud_tab_state: RscStructuredText
		{
			idc = 1105;
			text = "<t size='1' align='center' color='#009900'>КЛАВИШИ ВКЛЮЧЕНЫ</t>";
			x = 0.773281 * safezoneW + safezoneX;
			y = 0.94 * safezoneH + safezoneY;
			w = 0.0979687 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class wm: RscStructuredText
		{
			idc = 1106;
			text = "<t font='Zeppelin33Italic' size='1.5' align='left' color='#88ffffff' shadowColor='#555555'>vk.com/s_zagoria<br/>ОТКРЫТЫЙ ТЕСТ v0.9</t>";
			x = 0.0101562 * safezoneW + safezoneX;
			y = 0.918 * safezoneH + safezoneY;
			w = 0.70125 * safezoneW;
			h = 0.066 * safezoneH;
		};
		
	};   
	
};