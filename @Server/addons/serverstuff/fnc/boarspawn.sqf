
//if (!isServer) exitWith {};
while {true} do {
	if (count ([getMarkerPos "hunt1" select 0, getMarkerPos "hunt1" select 1, 0] nearObjects ["WildBoar",1000]) < 50) then {
	
		diag_log "spawning a boar?";
		_pos = [(getMarkerPos "hunt1" select 0) - 500 + (random 1000), (getMarkerPos "hunt1" select 1) - 500 + (random 1000), 0];
		_people = [];
		
		{
			if (isPlayer _x) then {_people pushBack _x};
		} foreach (_pos nearObjects ["Man", 200]);
		
		if (count _people == 0) then {
			//_grp = createGroup [east, true];
			diag_log "yes spawn";
			sleep 1;
			if (random 10 > 9.7) then {
				//_boar = "WildBoarBoss" createUnit [_pos, _grp, format ["this disableConversation true; removeAllAssignedItems this; this setVariable ['rammed',false,true]; this addEventHandler ['killed', {_this spawn fnc_boarKilledByPlayer}]; this addEventHandler ['killed', '_killer = (_this select 1); if ((speed _killer > 10) and (gunner (vehicle _killer))!= _killer) then {(_this select 0) setVariable [""rammed"",true,true]}']; this forceSpeed 40;", getMarkerPos "hunt1"]];
				_boar = (createGroup [east, true]) createUnit ["WildBoarBoss", _pos, [], 0, "NONE"];
				//systemChat str _boar;
				_boar disableConversation true;
				removeAllAssignedItems _boar;
				_boar setVariable ['rammed',false,true];
				_boar addEventHandler ['killed', {_this spawn fnc_boarKilledByPlayer}]; _boar addEventHandler ['killed', '_killer = (_this select 1); if ((speed _killer > 10) and (gunner (vehicle _killer))!= _killer) then {(_this select 0) setVariable ["rammed",true,true]}'];
				_boar forceSpeed 40;
				[group _boar, getMarkerPos "hunt1", 500] remoteExec ["BIS_fnc_taskPatrol",2];
				_boar remoteExec ["fnc_boarBoss",2];
			} else {			
				//_boar = "WildBoar" createUnit [_pos, _grp, format ["this disableConversation true; removeAllAssignedItems this; this setVariable ['rammed',false,true]; this addEventHandler ['killed', {_this spawn fnc_boarKilledByPlayer}]; this addEventHandler ['killed', '_killer = (_this select 1); if ((speed _killer > 10) and (gunner (vehicle _killer))!= _killer) then {(_this select 0) setVariable [""rammed"",true,true]}']; this forceSpeed 40;", getMarkerPos "hunt1"]];
				_boar = (createGroup [east, true]) createUnit ["WildBoar", _pos, [], 0, "NONE"];
				//systemChat str _boar;
				_boar disableConversation true;
				removeAllAssignedItems _boar;
				_boar setVariable ['rammed',false,true];
				_boar addEventHandler ['killed', {_this spawn fnc_boarKilledByPlayer}]; _boar addEventHandler ['killed', '_killer = (_this select 1); if ((speed _killer > 10) and (gunner (vehicle _killer))!= _killer) then {(_this select 0) setVariable ["rammed",true,true]}'];
				_boar forceSpeed 40;
				[group _boar, getMarkerPos "hunt1", 500] remoteExec ["BIS_fnc_taskPatrol",2];
			};	
		};
	};
	
	sleep 1;
};
