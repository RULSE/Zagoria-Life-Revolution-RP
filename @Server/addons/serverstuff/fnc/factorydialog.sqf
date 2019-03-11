
if (working) exitWith {hint "Вы не можете пользоваться заводом во время работы на нём.";};
private ["_object","_index"];
_factory = _this select 3;
if ((_factory == "testing_factory") and (roleplay_pts<300)) exitWith {
	["Недостаточно RPP","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
};
if ((_factory == "napa_weapfac") and (roleplay_pts<900)) exitWith {
	["Недостаточно RPP","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
};
if ((_factory == "napa_vehfac") and (roleplay_pts<2000)) exitWith {
	["Недостаточно RPP","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
};
curfac = factoryclass_array find _factory;
_object = (factories_array select curfac) select 2;
_production = (factories_array select (factoryclass_array find _factory)) select 4;
_storage = my_factories_stock select (my_factories find _factory);
_index = (_object getVariable ["factory_owners",[]]) find (getPlayerUID player);//todouid
_wh2 = (_object getVariable ["factory_whs",[]]) select _index;
my_factories_wh set [(my_factories find _factory), (my_factories_wh select (my_factories find _factory))+_wh2];
_whs = (_object getVariable ["factory_whs",[]]);
_whs set [_index,0];
_object setVariable ["factory_whs",_whs,true];
_wh = my_factories_wh select (my_factories find _factory);
if (!(createDialog "factory_dialog")) exitWith {hint "Dialog Error!";};
{lbAdd [1500, format ["%1", _x call fnc_getItemName]];} foreach _production;
{lbAdd [1501, format ["%1 %2шт.", (_x select 0) call fnc_getItemName, _x select 1]];} foreach _storage;
{lbAdd [1502, format ["%1 %2шт.", _x call fnc_getItemName, _x call fnc_getItemAmount]];} foreach inventory_items;
ctrlSetText [1004, format ["Человеко/часы: %1", _wh]];
