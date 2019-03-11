
_this = _this select 3;
_animal = _this select 0;
_animals = ["WildBoar","WildBoarBoss"];
if (_animal getVariable "rammed") exitWith {
	["Охота","Тело животного сильно повреждено.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	deleteVehicle _animal;
};
if (!(alive _animal)) then {
	switch (typeOf _animal) do {
		case "WildBoar": {
			player playMove "AinvPknlMstpSlayWrflDnon_medic";
			sleep 5;
			if (!(isNil "_animal")) then {
				["boar_meat", 3] call fnc_addItem;
				["boar_skin", 1] call fnc_addItem;
				["boar_tooth", 2] call fnc_addItem;
				deleteVehicle _animal;
			};
		};
		case "WildBoarBoss": {
			player playMove "AinvPknlMstpSlayWrflDnon_medic";
			sleep 5;
			if (!(isNil "_animal")) then {
				["boar_meat", 3] call fnc_addItem;
				["boar_skin", 1] call fnc_addItem;
				["sekach_tooth", 2] call fnc_addItem;
				deleteVehicle _animal;
			};
		};
	};
};
exit
