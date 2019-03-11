
//if (taxijob) exitWith {hint "Вы уже работаете таксистом.";};
private ["_action","_marker","_markerdestination","_markerarray","_markerobj"];
_action = _this select 0;
if (_action == "finish") then {
	
	if (taxipassenger!=dummy) then {
		deleteVehicle taxipassenger;
	};
	//deleteMarkerLocal taximarker;
	//deleteMarkerLocal "taximarker";
	
	taxijob = false;
	taximissiontaken = false;
	taxipassenger = dummy;
	taximarker = "taximarker";
	taxiguyactive = false;
				
	player removeSimpleTask taxi_task;
	
	["Такси","Вы завершили работу таксиста.",[1,1,1,1],[0.5,0.5,0,0.8]] spawn fnc_notifyMePls;
	
};
if (_action == "start") then {
	
	taxijob = true;
	
	_marker = selectRandom taxi_markers_array;	
	_markerarray = taxi_markers_array - [_marker];
	_markerdestination = selectRandom _markerarray;
	
	//_markerobj = createMarkerLocal ["taximarker",getMarkerPos _marker];
	//_markerobj setMarkerShapeLocal "ICON";
	//"taximarker" setMarkerTypeLocal "mil_marker";
	//"taximarker" setMarkerColorLocal "ColorYellow";
	//"taximarker" setMarkerTextLocal "Пассажир";
		
	//"CUP_C_C_Profiteer_02" createUnit [getMarkerPos _marker, group civ_logicunit, format ["this setVehicleVarName '%1_taxipassenger';",player]];	
	_unitsarray = ["C_man_1_2_F"];
	
	taxipassenger = (group civ_logicunit) createUnit [selectRandom _unitsarray, getMarkerPos _marker, [], 5, "NONE"];
	taxipassenger setVehicleVarName (format ["%1_taxipassenger",player]);
	[taxipassenger] join grpNull;
	
	taxi_task = player createSimpleTask ["taxijob"];
	taxi_task setSimpleTaskDescription ["Заберите пассажира и отвезите в место назначения.","Заберите пассажира","Забрать"];
	taxi_task setSimpleTaskDestination (getPosATL taxipassenger);
	taxi_task setSimpleTaskAlwaysVisible true;
	taxi_task setTaskState "Assigned";
	
	taxipassenger disableAI "ALL";
	//taxipassenger disableAI "TARGET";
	
	["Такси","Пассажир ждёт вас. Его место отмечено на карте.",[1,1,1,1],[0.5,0.5,0,0.8]] spawn fnc_notifyMePls;
	
	[_markerdestination,_marker,123] spawn {
		
		private ["_money","_taxitime","_markerobj"];
		
		_taxitime = 0;
		_markerobj = _this select 2;
		
		taxiguyactive = true;
		while {true} do {
			
			_taxitime = _taxitime + 1;
			
			if ((((vehicle player) emptyPositions "cargo") > 0) and (((vehicle player) distance taxipassenger) < 5) and taxiguyactive and (speed (vehicle player) < 2)) then {
				
				if !(taximissiontaken) then {
				
					player removeSimpleTask taxi_task;
					
					taxi_task = player createSimpleTask ["taxijob"];
					taxi_task setSimpleTaskDescription ["Высадите пассажира в точке назначения.","Отвезите пассажира","Высадить"];
					taxi_task setSimpleTaskDestination (getMarkerPos (_this select 0));
					taxi_task setSimpleTaskAlwaysVisible true;
					taxi_task setTaskState "Assigned";
					
					taximissiontaken = true;
					
					["Такси","Отвезите пассажира в точку назначения на карте.",[1,1,1,1],[0.5,0.5,0,0.8]] spawn fnc_notifyMePls;
					
					//deleteMarkerLocal _markerobj;
																																																				
					//_markerobj = createMarkerLocal ["taximarker",getMarkerPos (_this select 0)];
					//_markerobj setMarkerShapeLocal "ICON";
					//"taximarker" setMarkerTypeLocal "mil_marker";
					//"taximarker" setMarkerColorLocal "ColorYellow";
					//"taximarker" setMarkerTextLocal "Пассажир хочет сюда";
					
				};
								
				[taxipassenger,(vehicle player)] remoteExec ["fnc_taxiRemote_code1"];
								
			};	
			if (player == vehicle player and taxijob) then {
								
				[taxipassenger,(vehicle player)] remoteExec ["fnc_taxiRemote_code2"];
				
			};	
			
			if ((player!=(vehicle player)) and (((vehicle player) distance (getMarkerPos (_this select 0))) < 30) and (speed (vehicle player) < 2) and taxijob and (taxipassenger in (vehicle player))) exitWith {
				
				//_money = ((2000 max(round(((((getMarkerPos (_this select 0)) distance (getMarkerPos (_this select 1)))+((getMarkerPos (_this select 0)) distance (getMarkerPos (_this select 1))))*1)-(time-_taxitime))))min 10);
				_money = (((getMarkerPos (_this select 0)) distance (getMarkerPos (_this select 1)))-(time-_taxitime))*0.5;
				if (_money < 0) then {_money = 0};
				_money = _money+(((getMarkerPos (_this select 0)) distance (getMarkerPos (_this select 1)))*0.5);
				_money = round _money;
				_money = _money*3;
				["money",_money] call fnc_addItem;
				
				player removeSimpleTask taxi_task;
				
				["Такси",format ["Вы заработали %1 CRK",_money],[1,1,1,1],[0.5,0.5,0,0.8]] spawn fnc_notifyMePls;
				
				taximissiontaken = false;				
				taxiguyactive = false;
								
				[taxipassenger,(vehicle player),getMarkerPos (_this select 0)] remoteExec ["fnc_taxiRemote_code3"];
				
				sleep 5;
				
				deleteVehicle taxipassenger;
				
				taxipassenger = dummy;
	
			};
			
			if (!(alive player) or (isdead) or !(alive taxipassenger)) exitWith {
				
				taxijob = false;
				taximissiontaken = false;				
				taxiguyactive = false;
				if (taxipassenger!=dummy) then {
					deleteVehicle taxipassenger;
				};
				taxipassenger = dummy;
				//deleteMarkerLocal (_this select 2);
				//deleteMarkerLocal "taximarker";
				["finish"] spawn fnc_jobTaxi;
	
			};
			
			
			sleep 1;
			
		};
		
		//deleteMarkerLocal (_this select 2);
		//deleteMarkerLocal "taximarker";
		
		if taxijob then {
			["start"] spawn fnc_jobTaxi;
		};		
		
	};	
	
};
