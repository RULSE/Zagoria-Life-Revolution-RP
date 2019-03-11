
private ["_item","_license","_price","_arr","_need","_minimum","_demand","_newamount","_amount","_exitvarr"];
_this = _this select 3;
_item = _this select 0;
_license = _this select 1;
_price = _this select 2;
_exitvarr = false;
if (_license!="none") then {
	if !(_license call fnc_playerHasLicense) exitWith {
		["Переработка",format ["Вам нужна %1",_license call fnc_getLicenseName],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
		_exitvarr = true;
	};
};
if _exitvarr exitWith {};
if (("money" call fnc_getItemAmount)<_price) exitWith {
	["Переработка","Недостаточно денег!",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
};
_arr = _item call fnc_getItemResources;
_need = "";
{
	_need = _need + format ['%2x%1 ',(_x select 0) call fnc_getItemName,_x select 1];
} foreach _arr;
_minimum = 1;
{
	if ((_x select 1) < 1) then {_minimum = 1/(_x select 1)};
} foreach _arr;
_demand = format ['Для производства требуется %1, минимальная партия - %2 шт.', _need, _minimum];
_amount = floor ((((_arr select 0) select 0) call fnc_getItemAmount)/((_arr select 0) select 1));
{
	_newamount = floor (((_x select 0) call fnc_getItemAmount)/(_x select 1));
	
	if (_newamount<_amount) then {_amount=_newamount};	
	
} forEach _arr;
if (_amount<1) exitWith {
	["Переработка",_demand,[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
};
if ((_amount<_minimum) or ((_amount/_minimum)!=round(_amount/_minimum))) exitWith {
	["Переработка",format ["Количество данного продукта должно быть кратно %1. Возьмите в инвентарь именно столько сколько требуется.", _minimum],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
};
{
	
	[_x select 0, (_x select 1)*_amount] call fnc_removeItem;
		
} forEach _arr;
[_item,_amount] call fnc_addItem;
["Переработка",format ["Вы произвели %1 %2 за %3 CRK", _amount, _item call fnc_getItemName, _price],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
//if 9(_item in ["heroin","mdma","amphetamine","mari","lsd","psilo"]) and )
if (("napa" in licenses_illegal) and (_item in ["heroin","mdma","amphetamine","mari","lsd","psilo"])) then {
	if ((roleplay_pts>0) and ((roleplay_pts-_amount*4)>=0)) then {
	
		//roleplay_pts = roleplay_pts-_amount*4;
		[(_amount*4),true] call fnc_removeRPP;
	
	};
	if ((roleplay_pts>0) and ((roleplay_pts-_amount*4)<0)) then {
	
		//roleplay_pts = 0;
		[(_amount*4),true] call fnc_removeRPP;
	
	};
	["НаПа",format ["Вы потеряли %1 RPP за производство наркотиков.",_amount*4],[1,1,1,1],[0.8,0,0,0.8]] spawn fnc_notifyMePls;
};
