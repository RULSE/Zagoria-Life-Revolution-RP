
global_respawn_array = [
	["Жилой район Черногорска",[["civrespawn_1","civrespawn_2","civrespawn_3","civrespawn_4","civrespawn_5","civrespawn_6","civrespawn_7"],"marker_16"],{!((str player) in cop_array) and (!((getPlayerUID player) in players_ingame) or isdead)}],
	["База полиции в Черногорске",[["coprespawn_1"],"coprespawn_1"],{((str player) in cop_array) and (!((getPlayerUID player) in players_ingame_cop) or isdead)}],
	["Прикольный спавн",[["marker_115"],"marker_115"],{(!isNil "bowman_var") and !((str player) in cop_array) and (!((getPlayerUID player) in players_ingame) or isdead)}]
];
publicVariable "global_respawn_array";
players_ingame = [];
publicVariable "players_ingame";
players_ingame_cop = [];
publicVariable "players_ingame_cop";
fnc_openRespawnDialog = {
	cutText ["","BLACK FADED", 999999999];
	
	if (charname == "durak") then {
			
		charname = selectRandom (nationality call fnc_getNatNames);
		charlastname = selectRandom (nationality call fnc_getNatLastNames);
	
	};
	
	player setVariable ["charname",charname,true];
	player setVariable ["charlastname",charlastname,true];
	
	if (isNil "role_id") then {
	
		role_id = currentchar;
		currentchar = currentchar + 1;
		publicVariable "currentchar";
	
	};
	
	player setVariable ["role_id",role_id,true];
	//player setVariable ["realname",(),true];
	createDialog "respawn_dialog";
	
	//waitUntil {(rp_firsttimewakeup == 0) and (isNull (findDisplay 1488228))};
	
	(findDisplay 501234) displaySetEventHandler ["KeyDown","if((_this select 1) == 1) then {true}"]; //Block the ESC menu
	
	
	if !(isNil "last_position") then {
	
		"last_position" setMarkerPosLocal last_position;
	
	};
	
	{
	
		if (call (_x select 2)) then {
		
			lbAdd [1500, _x select 0];
			lbSetData [1500, (lbSize 1500) - 1, str (_x select 1)];
		
		};
	
	} forEach (global_respawn_array+[["Точка отключения",[["last_position"],"last_position"],{((((getMarkerPos "last_position") select 0) > 0) and (((getMarkerPos "last_position") select 1) > 0)) and !isdead}]]);
	
	lbSetCurSel [1500,0];
};
publicVariable "fnc_openRespawnDialog";
fnc_onRespawnSelect = {
	private ["_marker","_ctrlmap","_display"];
	
	_marker = lbData [1500, _this select 1];
	_marker = ((call compile _marker) select 1);
	_display = findDisplay 501234;
	_ctrlmap = _display displayCtrl 1200;
			
	_ctrlmap ctrlMapAnimAdd [1.5, 0.05, getMarkerPos _marker];
	ctrlMapAnimCommit _ctrlmap;
};
publicVariable "fnc_onRespawnSelect";
fnc_respawnMe = {
	if ((str player) in cop_array) then {
		if !((getPlayerUID player) in players_ingame_cop) then {
			players_ingame_cop pushBack (getPlayerUID player);
			publicVariable "players_ingame_cop";
		};
	
	} else {
		if !((getPlayerUID player) in players_ingame) then {
			players_ingame pushBack (getPlayerUID player);
			publicVariable "players_ingame";
		};
	
	};
	
	if isdead then {
		if ((str player) in cop_array) then {
			[] spawn fnc_initCopLoadout;
		} else {
			[] spawn fnc_initCivLoadout;
		};
	
		respawntime = 10;
		jailtimeleft = 0;
		
		isdead = false;
		timetorespawn = respawntime;
		
		hunger = 0;
		thirst = 0;
		
		blood_array = [[],[]];
	
	};
	
	player setVariable ["rp_face_var",rp_face,true];
	[player, rp_face] remoteExec ["setFace"];
	
	[] spawn fnc_clientShopsInit;
	
	/*if (rp_firsttimewakeup==1) then {
		
		killed_players_pts = 0;
		[] spawn fnc_openCharacterRollDialog;
	};*/
	
	private ["_marker"];
	
	_marker = lbData [1500, lbCurSel 1500];
	_marker = selectRandom (((call compile _marker) select 0));
	
	player setPosATL (getMarkerPos _marker);
	
	"last_position" setMarkerPosLocal [0,0,0];
	
	closeDialog 0;
	
	cutText ["","BLACK IN",0];
	
	//playSound format ["intro_%1", (round random 4) + 1];
	
};
publicVariable "fnc_respawnMe";
