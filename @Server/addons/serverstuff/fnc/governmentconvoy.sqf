
_counter = 0;
_sidewon = "nikto";
while {true} do 
{
	diag_log "CONVOY SPAWNING";
	sleep 5;
	
	private ["_code","_args","_convoytruck","_marker","_convoydriver","_convoygroup"];
	
	_convoygroup = createGroup west;
	
	_marker = (selectRandom ["convoy_spawn_1","convoy_spawn_2"]);
	
	//_convoytruck = createVehicle ["C_Truck_02_box_F", getMarkerPos _marker, [], 0, "NONE"];
	
	_classname = "C_Truck_02_box_F";
	
	_regplate = str currentplate;
	currentplate = currentplate + 1;
	publicVariable "currentplate";
	_vehname = format ["veh_%1",_regplate];
	
			_code = {
				
				["Государственный груз","Грузовик отправляется на базу сил правопорядка. Ему требуется сопровождение.",[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;
				
			};
			
			_args = [];
			
			[_args,_code] remoteExec ["spawn"];
	
	call compile format ["%1 = createVehicle [_classname, getMarkerPos _marker, [], 0, ''];",_vehname];		
			
	_veh = call compile _vehname;
	_convoytruck = call compile _vehname;
			
	_veh setVehicleVarName format ["veh%1",_regplate];
	call compile format ["%1 = %2;",format ["veh%1",_regplate],_vehname];
	
	_tex = ((items_array select (items_classes find _classname)) select 6) select 0;
			
	_veh setVariable ["tuning_data",[_tex,0],true];
			
	_veh setVariable ["owner","server"];
	
	_veh setVariable ["policevehicle",true,true];
	
	_veh remoteExec ["fnc_offroadSpeedLimit",2];
			
	/*if ((count _params) == 1) then {
				
		_params = _params select 0;
		_veh setObjectTextureGlobal [0,_params];
		_veh setVariable ["tuning_data",[_params,0],true];
				
	};*/
	
	publicVariable format ["veh%1",_regplate];
	servervehiclesarray pushBack str _veh;
	publicVariable "servervehiclesarray";
	clearWeaponCargoGlobal _veh;
	clearMagazineCargoGlobal _veh;
	clearItemCargoGlobal _veh;
	_veh setVariable ["regplate", _regplate, true];
	_veh setVariable ["trunkitems", [], true];
	_veh setVariable ["trunkamounts", [], true];
	
	_convoydriver = _convoygroup createUnit ["B_crew_F", getMarkerPos _marker, [], 0, "FORM"];
	
	_convoydriver moveInDriver _convoytruck;
	_convoydriver assignAsDriver _convoytruck;
	_convoydriver commandMove getmarkerpos "convoy_end";
	
	clearWeaponCargo _convoytruck;
	
	_markerobj = createMarker ["convoy",[0,0]];																				
	_markername = "convoy";																														
	_markerobj setMarkerShape "ICON";								
	"convoy" setMarkerType "mil_marker";										
	"convoy" setMarkerColor "ColorRed";																														
	"convoy" setMarkerText "Правительственная машина";
	
	diag_log "CONVOY SPAWNING END";
	
	while {true} do {
		
		_markername setMarkerPos (getPos _convoytruck);
		
		if (_counter>20) then {
			_counter = 0;
			_convoydriver assignAsDriver _convoytruck;
			_convoydriver commandMove getmarkerpos "convoy_end";
		};
		
		if (_convoytruck distance (getMarkerPos "convoy_capture") < 10) exitWith {
			diag_log "CONVOY PRIEHAL";
			
			_sidewon = "civ";
			
			_code = {
				
				["Государственный груз","Грузовик был захвачен. Преступники победили!",[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;
				
			};
			
			_args = [];
			
			[_args,_code] remoteExec ["spawn"];
			
			diag_log "CONVOY PRIEHAL 1";
			
			//[getPlayerUID (driver _convoytruck), "Хищение оружия", 40000, name (driver _convoytruck)] call fnc_setPlayerWanted;
			
			_code = {
			
				if (player == _this) then {
				
					//[getPlayerUID player, "Хищение оружия", 40000, name player] call fnc_setPlayerWanted;
					[getPlayerUID player, "Хищение оружия", 40000, [player,true] call fnc_getRealName] call fnc_setPlayerWanted;
					(vehicle player) setVelocity [0,0,0];
				
				};
			
			};
			
			_args = driver _convoytruck;
			
			[_args,_code] remoteExec ["spawn"];
			
			diag_log "CONVOY PRIEHAL 2";
			
			//_convoytruck setVelocity [0,0,0];
			
			diag_log "CONVOY PRIEHAL 3";
			
			if ((random 1)<0.5) then {
				
				convoy_guns addWeaponCargoGlobal ["arifle_mas_ak74",5];
				convoy_guns addMagazineCargoGlobal ["30Rnd_mas_545x39_mag",50];
				
			} else {
				
				convoy_guns addWeaponCargoGlobal ["arifle_mas_akm",3];
				convoy_guns addMagazineCargoGlobal ["30Rnd_mas_762x39_mag",30];
			};
			
			diag_log "CONVOY PRIEHAL 4";
			
			sleep 1;
			
			diag_log "CONVOY PRIEHAL 5";
			
			deleteVehicle _convoydriver;
			
			diag_log "CONVOY PRIEHAL 6";
		};
		
		if (_convoytruck distance (getMarkerPos "convoy_end") < 30) exitWith {
			
			_sidewon = "cop";
			
			_code = {
				
				["Государственный груз","Грузовик прибыл в место назначения. Органы правопорядка победили.",[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;
				
			};
			
			_args = [];
			
			[_args,_code] remoteExec ["spawn"];
			
			_convoytruck setVelocity [0,0,0];
			
			sleep 1;
						
			deleteVehicle _convoytruck;
			deleteVehicle _convoydriver;
		};
		
		if !(alive _convoytruck) exitWith {
			
			_code = {
				
				["Государственный груз","Грузовик был уничтожен! Всё содержимое сгорело!",[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;
				
			};
			
			_args = [];
			
			[_args,_code] remoteExec ["spawn"];
			
			sleep 10;
			
			deleteVehicle _convoytruck;
			deleteVehicle _convoydriver;
			
		};
		
		_counter = _counter + 1;
		
		sleep 1;
		
	};
	
	deleteMarker _markername;
	deleteGroup _convoygroup;
};
