/*class RscText
{
	idc = -1;
	type = CT_STATIC;
	style = ST_LEFT;
	fixedWidth = 0;
	sizeEx = "4.32 * (1 / (getResolution select 3)) * pixelGrid * 0.5";
	colorText[] = {1, 1, 1, 1};
	colorShadow[] = {0, 0, 0, 0.5};
	colorBackground[] = {0, 0, 0, 0};
	tooltipColorText[] = {1, 1, 1, 1};
	tooltipColorBox[] = {1, 1, 1, 1};
	tooltipColorShade[] = {0, 0, 0, 0.65};
	font = "RobotoCondensed";
	shadow = 1;
	lineSpacing = 1;
};*/

class hud_nots
{
	idd = -1;
	fadeIn = 0;
	movingEnable = 0;
	duration = 10e10;
	fadeOut = 0;
	onLoad = "uiNamespace setVariable ['hud_nots',_this select 0]";
	onUnload = "uiNamespace setVariable ['hud_nots', objNull]";
	onDestroy = "uiNamespace setVariable ['hud_nots', objNull]";
	class controls
	{
		/*class notifications : RscText
		{
			idc = 454235235234;
			x = -13 * GUI_GRID_W + GUI_GRID_X;
			y = -9.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 19.5 * GUI_GRID_W;
			h = 8 * GUI_GRID_H;
		};*/
	};
};