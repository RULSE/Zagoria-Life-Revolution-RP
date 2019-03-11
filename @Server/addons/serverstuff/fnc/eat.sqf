
_amount = _this select 0;
_params = _this select 1;
_item = _this select 2;
_value = _params select 0;
_value = round (_value*1.5);
_value2 = _params select 0;
//if (_amount>1) then {_amount=1;};
if ((_item in ["boar_grib","boar_meat","tacticalbacon"]) and (religion in ["sunni"])) then {
	["Харам","Вы едите свинину будучи суннитом. Вы потеряли 100 RPP.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	if ((roleplay_pts-100)>0) then {
		roleplay_pts=roleplay_pts-100;
	} else {
		roleplay_pts=0;
	};
};
if ((hunger-_value)>=0) then {
	//roleplay_pts = roleplay_pts + _value2;
	_value call fnc_addRPP;
};
[_item,_amount] call fnc_removeItem;
hunger = hunger - (_value*_amount);
if (hunger<0) then {hunger = 0};
["Вы утолили голод","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
exit
