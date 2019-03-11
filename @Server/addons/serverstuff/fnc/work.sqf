
if (working) exitWith {hint "Вы уже работаете.";};
private ["_object"];
_object = (factories_array select curfac) select 2;
_index = (joblist select _this) select 0;
working = true;
_zp = 0;
//(factory_money select curfac) set [_index, ((factory_money select curfac) select _index)+_amount]
hint format ["Как наработаетесь просто прекратите...", 1];
	
while {working} do {
	
	private ["_money","_owners","_wages","_whs"];
	
	
	if (stress_value>=3000) then {
		working = false;
		["Работа","Вы слишком устали. Выпейте пива, выкурите сигарету, съездите на рыбалку.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	};
	
	_exitpls = false;
	{
		
		if (_x > 100) then {		
			if !((blood_array select 0) select _forEachIndex in ["mdma","amph"]) then {
				_exitpls=true;
			};
		};
	} forEach (blood_array select 1);
	if _exitpls exitWith {
		working = false;
		["Работа","Вы не в состоянии работать.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	};
	
	if (!working) exitWith {};
	if (player distance _object > 5) exitWith {["Работа","Вы слишком далеко.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	player playmove "Acts_carFixingWheel";
	sleep 1;
	
	stress_value = stress_value + 1;
	_money = _object getVariable ["factory_money",[]];
	_owners = _object getVariable ["factory_owners",[]];
	_wages = _object getVariable ["factory_wages",[]];
	_whs = _object getVariable ["factory_whs",[]];
	
	if (((_money select _index)>=(_wages select _index)) or (_owners select _index == "server")) then {
		_whs set [_index,(_whs select _index)+1];
		_money set [_index,(_money select _index)-(_wages select _index)];
		gov_money = gov_money + round((_wages select _index)*inc_tax);
		publicVariable "gov_money";
		_zp = _zp + round((_wages select _index)*(1-inc_tax));
		deposit = deposit + (round((_wages select _index)*(1-inc_tax)));
		hunger = hunger + (1/36);
		thirst = thirst + (1/36);
		//roleplay_pts = roleplay_pts + 0.1;
		0.1 call fnc_addRPP;
		//publicVariable "factory_money";
		//publicVariable "factory_whs";
		_object setVariable ["factory_money",_money,true];
		_object setVariable ["factory_whs",_whs,true];
	} else {
		working = false;
	};
	
};
player switchmove "";
["Работа",format ["Вы закончили смену, на ваш счёт перечислено %1 CRK, вычтено %2%3 налогов...",_zp,inc_tax*100,"%"],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
working = false;
