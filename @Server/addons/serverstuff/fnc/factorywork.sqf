
private ["_factory","_object"];
_factory = _this select 3;
curfac = factoryclass_array find _factory;
_object = (factories_array select curfac) select 2;
joblist = [];
_temp = [];
_money = _object getVariable ["factory_money",[]];
_owners = _object getVariable ["factory_owners",[]];
_wages = _object getVariable ["factory_wages",[]];
_names = _object getVariable ["factory_names",[]];
if (!(createDialog "factorywork_dialog")) exitWith {hint "Dialog Error!";};
{
	if ((_x>0) and (((_money select _forEachIndex)>=_x) or (_owners select _forEachIndex == "server"))) then {
		joblist pushBack [_forEachIndex,_x,_names select _forEachIndex];
	};
} foreach _wages;
if (count joblist > 0) then {
	for "_i" from 0 to ((count joblist) - 1) do {
		for "_m" from 0 to ((count joblist) - 1) do {
			if (((joblist select _m) select 1) < ((joblist select (_m+1)) select 1)) then {
				_temp = joblist select (_m+1);
				joblist set [_m+1,joblist select _m];
				joblist set [_m,_temp];
			};
		};
	};
};
//hint format ["%1", joblist];
{
	lbAdd [1500, format ["%1 CRK/мин [%2]",(_x select 1)*60, _x select 2]];
} foreach joblist;
