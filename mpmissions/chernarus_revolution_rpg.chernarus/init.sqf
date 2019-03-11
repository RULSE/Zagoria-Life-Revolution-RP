cutText ["","BLACK FADED", 999999999];

if (isServer) then {
	[] execVM "serverstuff\db.sqf";	
};

ClientSaveVar = {};

waituntil {!isNil "fnc_playerInit"};

[] spawn fnc_playerInit;