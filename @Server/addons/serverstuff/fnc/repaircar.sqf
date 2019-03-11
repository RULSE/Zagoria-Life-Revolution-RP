
private ["_vehicle","_time","_curtime","_kit","_exitvar","_item"];
_vehicle = nearestObjects [player, ["LandVehicle","Air"], 5];
if (count _vehicle == 0) exitWith {["Ремонт","Подойдите ближе к транспортному средству.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
_vehicle = _vehicle select 0;
_item = _this select 2;
_time = 120 - engskill;
_curtime = 0;
_exitvar = false;
if !((str _vehicle) in servervehiclesarray) exitWith {["Ремонт","Вы должны находиться рядом с транспортом который можно починить.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
if ((player distance _vehicle) > 5) exitWith {["Ремонт","Вы должны находиться рядом с транспортом который можно починить.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
if ((vehicle player)!=player) exitWith {["Ремонт","Вы не должны находиться внутри транспорта.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
while {_curtime<_time} do {
	
	_curtime = _curtime + 1;
	
	hint format ["Починка транспорта %1/%2",_curtime,_time];
	
	if ((player distance _vehicle) > 5) exitWith {["Ремонт","Вы должны находиться рядом с транспортом который можно починить.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls; _exitvar = true;};
	if ((_item call fnc_getItemAmount)<1) exitWith {["Ремонт","А ремка где?",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls; _exitvar = true;};
	if ((vehicle player)!=player) exitWith {["Ремонт","Вы не должны находиться внутри транспорта.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls; _exitvar = true;};
	sleep 1;
	
};
if _exitvar exitWith {};
_prog = 0;
if ((random 200)>engskill) then {_prog=1};
engskill = engskill + _prog;
if (engskill>100) then {engskill=100};
[_item,1] call fnc_removeItem;
_vehicle setDamage 0;
["Ремонт",format ["Транспортное средство %1 успешно отремонтировано.", (typeOf _vehicle) call fnc_getItemName],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
