
_this = _this select 3;
_factory = _this select 0;
_price = _this select 1;
_index = factoryclass_array find _factory;
_object = ((factories_array select _index) select 2);
if ((_factory == "testing_factory") and (roleplay_pts<300)) exitWith {
	["Недостаточно RPP","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
};
if ((_factory == "napa_weapfac") and (roleplay_pts<900)) exitWith {
	["Недостаточно RPP","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
};
if ((_factory == "napa_vehfac") and (roleplay_pts<2000)) exitWith {
	["Недостаточно RPP","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
};
if (("money" call fnc_getItemAmount) < _price) exitWith {
	["Недостаточно денег","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
};
["money",_price] call fnc_removeItem;
my_factories = my_factories + [_factory];
my_factories_wh = my_factories_wh + [0];
my_factories_stock = my_factories_stock + [[]];
private ["_names"];
/*
_names = _object getVariable ["factory_names",[]];
_names pushBack (name player);
systemChat str _names;
_object setVariable ["factory_names",_names,true];*/
_names = _object getVariable ["factory_names",[]];
_names set [count _names,name player];
_object setVariable ["factory_names",_names,true];
_owners = (_object getVariable ["factory_owners",[]]);
_owners pushBack (getPlayerUID player);
_object setVariable ["factory_owners",_owners,true];
_money = (_object getVariable ["factory_money",[]]);
_money pushBack 0;
_object setVariable ["factory_money",_money,true];
_wages = (_object getVariable ["factory_wages",[]]);
_wages pushBack 0;
_object setVariable ["factory_wages",_wages,true];
_whs = (_object getVariable ["factory_whs",[]]);
_whs pushBack 0;
_object setVariable ["factory_whs",_whs,true];
["Завод куплен","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
/*
factory_wages set [_index, (factory_wages select _index) + [0]];
publicVariable "factory_wages";
factory_wagers set [_index, (factory_wagers select _index) + [getPlayerUID player]];
publicVariable "factory_wagers";
factory_whs set [_index, (factory_whs select _index) + [0]];
publicVariable "factory_whs";
factory_money set [_index, (factory_money select _index) + [0]];
publicVariable "factory_money";*/
