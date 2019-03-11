
private ["_vehicle","_time","_curtime","_kit","_exitvar","_item"];
_vehicle = nearestObjects [player, ["LandVehicle","Air"], 5];
if (count _vehicle == 0) exitWith {["Заправка","Подойдите ближе к транспортному средству.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
_vehicle = _vehicle select 0;
_item = _this select 2;
_exitvar = false;
_time = 10;
_curtime = 0;
if !((str _vehicle) in servervehiclesarray) exitWith {["Заправка","Вы должны находиться рядом с транспортом который можно заправить.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
if ((player distance _vehicle) > 5) exitWith {["Заправка","Вы должны находиться рядом с транспортом который можно заправить.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
if ((vehicle player)!=player) exitWith {["Заправка","Вы не должны находиться в машине.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
while {_curtime<_time} do {
	
	_curtime = _curtime + 1;
	
	hint format ["Заправка транспорта %1/%2",_curtime,_time];
	
	if ((player distance _vehicle) > 5) exitWith {["Заправка","Вы должны находиться рядом с транспортом который можно заправить.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls; _exitvar = true;};
	if ((_item call fnc_getItemAmount)<1) exitWith {["Заправка","А канистра где?",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls; _exitvar = true;};
	if ((vehicle player)!=player) exitWith {["Заправка","Вы не должны находиться в машине.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls; _exitvar = true;};
	sleep 1;
	
};
if _exitvar exitWith {};
[_item,1] call fnc_removeItem;
_vehicle setFuel ((fuel _vehicle) + 0.25);
["Заправка",format ["Транспортное средство %1 успешно заправлено.", (typeOf _vehicle) call fnc_getItemName],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
