
if (working) exitWith {hint "Вы не можете пользоваться заводом во время работы на нём.";};
private ["_object"];
_factory = _this select 3;
curfac = factoryclass_array find _factory;
_object = (factories_array select curfac) select 2;
_index = (_object getVariable ["factory_owners",[]]) find (getPlayerUID player); //todouid
//_index = (factory_wagers select curfac) find ("1488"); //todouid
_kassa = (_object getVariable ["factory_money",[]]) select _index;
_wage = (_object getVariable ["factory_wages",[]]) select _index;
if (!(createDialog "factorywage_dialog")) exitWith {hint "Dialog Error!";};
ctrlSetText [1000, format ["Касса: %1 CRK", _kassa]];
ctrlSetText [1001, format ["Зарплата: %1 CRK", _wage]];
