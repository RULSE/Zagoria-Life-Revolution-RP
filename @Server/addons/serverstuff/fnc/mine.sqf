
_tool = _this select 2;
_toollevel = _this select 1;
	if (hunger >= 100) exitWith {
		["Добыча","Вы слишком голодны.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	};
	if (thirst >= 100) exitWith {
		["Добыча","Вы слишком сильно хотите пить.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	};
	
if (mining) exitWith {
		["Добыча","Вы уже добываете ресурс.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
};
if (stress_value>=3000) exitWith {
		["Добыча","Вы слишком устали. Отдохните и развейтесь.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
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
		["Добыча","Вы не в состоянии работать.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
};
_resource = "none";
{
	if ((player distance (getMarkerPos (_x select 0)) <= (_x select 1)) and (_tool in (_x select 3))) then {
		_resource = _x select 2;
	};
} foreach mine_areas;
if (_resource == "none") exitWith {
		["Добыча","Инструмент не подходит для данного ресурса, либо вы не в зоне добычи.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
};
mining = true;
player playMove "AmovPercMstpSnonWnonDnon_exercisekneeBendB";
["Добыча","Работаем...",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
hunger = hunger + (1/36);
thirst = thirst + (1/36);
stress_value = stress_value + 2;
switch _toollevel do {
	case 1: {
		sleep 4;
		_amount = round (random 1) + 1;
		_amount = _amount*3;
		[_resource, _amount] call fnc_addItem;
		[format ["Вы добыли %1 %2.",_amount,_resource call fnc_getItemName]] spawn fnc_itemNotifyMePls;
	};
	case 2: {
		sleep 4;
		_amount = round (random 1) + 2;
		_amount = _amount*3;
		[_resource, _amount] call fnc_addItem;
		[format ["Вы добыли %1 %2.",_amount,_resource call fnc_getItemName]] spawn fnc_itemNotifyMePls;
	};
	case 3: {
		sleep 4;
		_amount = round (random 3) + 1;
		_amount = _amount*3;
		[_resource, _amount] call fnc_addItem;
		[format ["Вы добыли %1 %2.",_amount,_resource call fnc_getItemName]] spawn fnc_itemNotifyMePls;
	};
};
mining = false;
