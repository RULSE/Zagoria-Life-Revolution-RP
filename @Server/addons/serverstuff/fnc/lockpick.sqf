
private ["_vehicle","_pickchance","_prog"];
_vehicle = nearestObjects [player, ["LandVehicle","Air"], 5];
if (count _vehicle == 0) exitWith {["Взлом","Подойдите ближе к транспортному средству.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
_vehicle = _vehicle select 0;
_pickchance = round (lockpickskill/10) + 1;
if !((str _vehicle) in servervehiclesarray) exitWith {["Взлом","Вы должны находиться рядом с транспортом который можно вскрыть.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
if ((player distance _vehicle) > 5) exitWith {["Взлом","Вы должны находиться рядом с транспортом который можно вскрыть.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
if ((_vehicle getVariable ["regplate","none"]) in vehicle_keys) exitWith {["Взлом","У вас уже есть ключи от этого транспортного средства.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
if ((_vehicle getVariable ["owner","none"]) == (getPlayerUID player)) exitWith {["Взлом","У вас есть запасные ключи. Просто попробуйте открыть.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
player playMove "AinvPknlMstpSlayWrflDnon_medic";
sleep 7;
if ((player distance _vehicle) > 5) exitWith {["Взлом","Вскрыть не удалось. Транспортное средство слишком далеко.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
if (("lockpick" call fnc_getItemAmount)<1) exitWith {["Взлом","А отмычки где?",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
_prog = 0;
if ((random 200)>lockpickskill) then {_prog=1};
lockpickskill = lockpickskill + _prog;
if !((random 11)<_pickchance) exitWith {
	
	if (lockpickskill<90) then {
		
		["Взлом","Вскрыть не удалось! И отмычка сломалась!",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	
		["lockpick",1] call fnc_removeItem;
		
	} else {
		
		["Взлом","Вскрыть не удалось!",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
		
	};
	
};
if (lockpickskill>80) then {
	
	["Взлом",format ["%1 вскрыт!",(typeOf _vehicle) call fnc_getItemName],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
		
	_vehicle lock 0;
	
	vehicle_keys pushBack (_vehicle getVariable ["regplate","1"]);
	
} else {
	
	["Взлом",format ["%1 вскрыт! Но отмычка сломалась.",(typeOf _vehicle) call fnc_getItemName],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	
	["lockpick",1] call fnc_removeItem;
	
	_vehicle lock 0;
	
	vehicle_keys pushBack (_vehicle getVariable ["regplate","1"]);
	
};
