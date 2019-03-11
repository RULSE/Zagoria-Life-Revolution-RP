
//waitUntil {stats_ready};
masks_array = ["G_Balaclava_blk","G_Balaclava_oli","G_Bandanna_aviator","G_Bandanna_beast","G_Bandanna_blk","G_Bandanna_khk","G_Bandanna_oli","G_Bandanna_tan"];
[] spawn {
	//обнаружение преступников и людей в масках
	while {true} do {
	
		private ["_cities","_villages","_detected"];
		
		_cities = (nearestLocations [getPos player, ["NameCityCapital","NameCity"], 750, getPos player]);
		_villages = (nearestLocations [getPos player, ["NameVillage"], 500, getPos player]);
		_detected = "none";
		
		if ((count _cities) == 0) then {
		
			if ((count _villages)>0) then {
				_detected = _villages select 0;
			};
		
		} else {
		
			_detected = _cities select 0;
		
		};
	
		if (((typeName _detected) == "LOCATION") and ((vehicle player)==player)) then {
		
			private ["_markernamelol","_randompos"];
	
			
			if ((goggles player) in masks_array) exitWith {
			
				[_detected, "Неизвестный в маске обнаружен недалеко от"] spawn fnc_revealLocation_remote;
				
				_markernamelol = format ["wanted_%1%2", parseNumber (str player), time];
				_randompos = [(getPos player select 0) - 75 + (random 150), (getPos player select 1) - 75 + (random 150)];
				
				createMarker [_markernamelol, _randompos];				
				_markernamelol setMarkerShape "ELLIPSE";
				_markernamelol setMarkerSize [200,200];
				_markernamelol setMarkerColor "ColorRed";
				
				[_markernamelol] remoteExec ["fnc_wantedMarkerDecay",2];
			
			};
			
			if ((getPlayerUID player) in wanted_players_list) exitWith {
			
				[_detected, format ["%1, находящийся в розыске, замечен недалеко от", name player]] spawn fnc_revealLocation_remote;
				
				_markernamelol = format ["wanted_%1%2", parseNumber (str player), time];
				_randompos = [(getPos player select 0) - 75 + (random 150), (getPos player select 1) - 75 + (random 150)];
				
				createMarker [_markernamelol, _randompos];				
				_markernamelol setMarkerShape "ELLIPSE";
				_markernamelol setMarkerSize [200,200];
				_markernamelol setMarkerColor "ColorRed";
				
				[_markernamelol] remoteExec ["fnc_wantedMarkerDecay",2];
			
			};
		
		};
	
		sleep (40+(random 120));
	
	};
	
};
[] spawn {
	private ["_hud","_health_bar","_food_bar","_thirst_bar","_health_bar_b","_food_bar_b","_thirst_bar_b","_stress_bar_b","_stress_bar","_wm"];
	waitUntil {!isNull (uiNamespace getVariable ["hud_res",displayNull])};
	_hud = uiNamespace getVariable ["hud_res",displayNull];
	_wm = _hud displayCtrl 1106;
	//_wm ctrlSetFade 0.5;
	//_wm ctrlCommit 0;
	
	_health_bar_b = _hud displayCtrl 11003;
	_food_bar_b = _hud displayCtrl 11013;
	_thirst_bar_b = _hud displayCtrl 11023;
	_stress_bar_b = _hud displayCtrl 11033;
	
	_health_bar = _hud displayCtrl 1100;
	_food_bar = _hud displayCtrl 1101;
	_thirst_bar = _hud displayCtrl 1102;
	_stress_bar = _hud displayCtrl 1103;
	
	_health_bar_b progressSetPosition 1;
	_food_bar_b progressSetPosition 1;
	_thirst_bar_b progressSetPosition 1;
	_stress_bar_b progressSetPosition 1;
	
	while {true} do {
	
		_health_bar progressSetPosition (1-(getDammage player));
		_food_bar progressSetPosition (1-(hunger/100));
		_thirst_bar progressSetPosition (1-(thirst/100));
		_stress_bar progressSetPosition (stress_value/3000);
		
		sleep 1;
	
	};
	
};
[] spawn {
	private ["_hud","_rpstate"];
	waitUntil {!isNull (uiNamespace getVariable ["hud_res",displayNull])};
	_hud = uiNamespace getVariable ["hud_res",displayNull];
	_rpstate = _hud displayCtrl 23500;
	
	while {true} do {
	
		maxweight = round (60 + (20*(strengthskill/100)));
		
		if !((str player) in cop_array) then {
			
			private ["_add"];
			
			_add = true;
			if ((vest player) != "") then {_add = false;};
			if ((backpack player) != "") then {_add = false;};
			if ((hmd player) != "") then {_add = false;};
			
			if ((vehicle player)==player) then {
				if !(((animationState player) in ["amovpercmwlkslowwrfldf_ver2","amovpercmwlkslowwrfldb_ver2","amovpercmwlkslowwrfldl_ver2","amovpercmwlkslowwrfldr_ver2","amovpercmwlkslowwrfldfr_ver2","amovpercmwlkslowwrfldfl_ver2","amovpercmwlkslowwrfldbl_ver2","amovpercmwlkslowwrfldbr_ver2","amovpercmwlksnonwnondf","amovpercmwlksnonwnondb","amovpercmwlksnonwnondl","amovpercmwlksnonwnondr","amovpercmwlksnonwnondfr","amovpercmwlksnonwnondfl","amovpercmwlksnonwnondbl","amovpercmwlksnonwnondbr"]) and ((((speed player) > 0.5) and ((speed player) < 8)) or (((speed player) > -8) and ((speed player) < -0.5)))) then {_add = false;};
			} else {
				if (((speed (vehicle player)) < 40) or ((speed (vehicle player)) > 120)) then {_add = false;};				
			};
			
			if _add then {
				//roleplay_pts = roleplay_pts + 0.025;
				0.025 call fnc_addRPP;
				_rpstate ctrlSetStructuredText (parseText "<t size='1.5' font='Zeppelin33' color='#10ff10'>RPP+</t>");
			} else {
				_rpstate ctrlSetStructuredText (parseText "<t size='1.5' font='Zeppelin33' color='#10ff10'></t>");
			};
			
		};
		
		
		sleep 0.1;
		
	};
};
[] spawn {
	while {true} do {
	
		waitUntil {((backpack player)!="") or ((hmd player)!="")};
		
		hint "Вы надели рюкзак или ПНВ! В течение 15 минут вы будете получать меньше RPP и терять больше!";
		systemChat "Вы надели рюкзак или ПНВ! В течение 15 минут вы будете получать меньше RPP и терять больше!";
		
		waitUntil {((backpack player)=="") and ((hmd player)=="")};
	
	};
};
while {true} do {
	if (((backpack player)!="") or ((hmd player)!="")) then {
	
		if (((cooldown_array select 0) find "bp_nvg_cd")<0) then {
					
			(cooldown_array select 0) pushBack "bp_nvg_cd";
			(cooldown_array select 1) pushBack 15;
					
		} else {
					
			(cooldown_array select 1) set [(cooldown_array select 0) find "bp_nvg_cd", 15];
					
		};
	
	};
	
	private ["_recoil","_blood_stuff","_blood_amounts"];
	
	_recoil = (5 - 4.5*(shootingskill/100));
	
	_blood_stuff = (blood_array select 0);
	_blood_amounts = (blood_array select 1);
		
	if ("amph" in _blood_stuff) then {
		
		private ["_rate"];
		
		_rate = (_blood_amounts select (_blood_stuff find "amph"))/300;
		
		if (_rate>1) then {_rate=1};
		
		_recoil = _recoil*(1-(0.4*_rate));
				
	};
	
	if ("alcohol" in _blood_stuff) then {
			
		private ["_rate"];
			
		_rate = (_blood_amounts select (_blood_stuff find "alcohol"))/500;
		
		if (_rate>1) then {_rate=1};
			
		_recoil = _recoil*(1+(8*_rate));
			
	};
	
	player setUnitRecoilCoefficient _recoil;
	
	hunger = hunger + (1/54); //(1/36)
	thirst = thirst + (1/54);
	if (hunger >= 200) then {
		["hunger"] spawn fnc_death;
	};
	if (thirst >= 200) then {
		["thirst"] spawn fnc_death;
	};
	
	if (allowuseatm>0) then {allowuseatm=allowuseatm-1};
	
	if (alive player) then {
		
		private ["_wp"];
		
		_wp = false;
		
		{
			
			if ((player distance (_x select 1))<(_x select 3)) then {
				workplaceadd = workplaceadd + (_x select 2);
			};
			
		} forEach workplaces_array;
		
	};
	
	_memasi = (call fnc_getInvWeight);
	
	if (_memasi>50) then {
	
		if ((strengthskill<100) and ((random strengthskill)<1) and ((vehicle player) != player)) then {
			strengthskill = strengthskill + 1;
		};
	
	};
	
	player setFatigue ((getFatigue player)-0.01*(staminaskill/100));
	
	if (((vehicle player) != player) and (speed player > 9)) then {
	
		if ((staminaskill<100) and ((random staminaskill)<1)) then {
			staminaskill = staminaskill + 1;
		};
		
	};
	
	if (roleplay_pts<0) then {
		if ((vehicle player != player) and (player == (driver (vehicle player)))) then {
			player action ["eject", vehicle player];
			systemChat "RPP меньше нуля! Вы не можете управлять транспортом!";
		};
	};
	
	if (_memasi > maxweight) then {
		//player switchMove "AidlPpneMstpSnonWnonDnon_AI";
		player forceWalk true;
		systemChat "Слишком тяжело";
		if ((vehicle player != player) and ((speed (vehicle player) > 5) or (speed (vehicle player) < -5))) then {
		
			if ((driver (vehicle player))==player) then {
			
				(vehicle player) setVelocity [0,0,0];
			
			};
			player action ["eject", vehicle player];
		};
	} else {
		player forceWalk false;		
	};
	
	if (hunger >= 100) then {
		player forceWalk true;
	};
	if (thirst >= 100) then {
		player forceWalk true;
	};
	
	if ((hunger <= 25) and ((damage player) <= 0.25)) then {
		player setDamage ((damage player)-0.001);
	};
		
	player setVariable ["invi",inventory_items,true];
	player setVariable ["inva",inventory_amount,true];
	player setVariable ["licenses_array",licenses,true];
		
	for "_i" from 0 to (count farm_areas - 1) do 
	{
		
	
	_arr    = (farm_areas select _i);			
	_marker = getMarkerPos (_arr select 0);
	_distance = _arr select 1;
	_item = _arr select 2;
	_amount = round ((random (_arr select 3)));
	_chance = _arr select 4;
	_veh = _arr select 5;
	_farm = true;
	if (((vehicle player) distance _marker) > _distance) then {_farm = false;};
	if (!((vehicle player) isKindOf _veh)) then {_farm = false;};
	if (speed (vehicle player) < 1) then {_farm = false;};
	if ((random 100)>_chance) then {_farm = false;};
	if (stress_value>3000) then {_farm = false;};
	
	if (_farm) then {
		if (hunger >= 100) exitWith {
			["Вы слишком голодны.","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
		};
		if (thirst >= 100) exitWith {
			["Вы слишком сильно хотите пить.","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
		};
		stress_value = stress_value + 2;
		
		if ((vehicle player)!=player) then {
			private ["_weight","_trunkitems","_trunkamounts"];
			_weight = 0;
			_trunkitems = (vehicle player) getVariable "trunkitems";
			_trunkamounts = (vehicle player) getVariable "trunkamounts";
			{
				_weight = _weight + (_x call fnc_getItemWeight)*(_trunkamounts select _forEachIndex);
			} foreach _trunkitems;
			if ((_weight+((_item call fnc_getItemWeight)*_amount))>((typeOf (vehicle player)) call fnc_getItemTrunk)) exitWith {
				["Багажник заполнен.","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
			};
			[(vehicle player),_item,_amount] call fnc_gatherToTrunk;
		} else {		
			if (((call fnc_getInvWeight)+((_item call fnc_getItemWeight)*_amount))>maxweight) exitWith {
				["Инвентарь заполнен.","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
			};
			[_item,_amount] call fnc_addItem;
		};
		//["Вы слишком сильно хотите пить.",format ["Вы собрали %1 %2.", _amount, _item call fnc_getItemName],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
		[format ["Собрано %1 %2.", _amount, _item call fnc_getItemName]] spawn fnc_itemNotifyMePls;
	};
	};	
	
	if (isdead and (alive player)) then {
		
		private ["_deadpos","_deaddir"];
		
		_deadpos = [-5242.610,2637.03,0];
		_deaddir = 148.921;
		
		if ((player distance _deadpos) > 1000) then {
			
			player setPos _deadpos;
			player setDir _deaddir;
		};		
		
		if (timetorespawn>0) then {
			timetorespawn = timetorespawn - 1;
			hint format ["Время до возрождения %1 секунд",timetorespawn];
		};
		
		if ((timetorespawn<=0) and (isNull (findDisplay 501234)) and (isNull (findDisplay 1488228))) then {
			if (rp_firsttimewakeup==1) then {
				[] spawn fnc_openCharacterRollDialog;
			} else {
				[] spawn fnc_openRespawnDialog;
			};
			//call fnc_respawnMe;
			["Возрождаемся...","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
		} else {
		
			//hint format ["Время до возрождения %1 секунд",timetorespawn];
		
		};
	};
	
	if (stunned or (player getVariable ["restrained",false])) then {
			
		if restartsoon then {
		
			restrained_punish = 0;
		
		} else {
		
			restrained_punish = 1;
		
		};
	
	} else {
	
		restrained_punish = 0;
	
	};
	
	if (stunned) then {
	
		//disableUserInput true;
	
		stuncountdown = stuncountdown - 1;
		
		if ((vehicle player) == player) then {
					
			[player,"Incapacitated"] remoteExec ["fnc_playerPlayMove_remote"];
		
		};
		
		if (stuncountdown<=0) then {
			//disableUserInput false;
			stuncountdown = 0;
			stunned = false;
			//["stunned", stunned] call ClientSaveVar;
			//player switchmove "";
			if !(player getVariable ["restrained",false]) then {
			
				if ((vehicle player) == player) then {
					//[player] remoteExec ["fnc_playerResetAnim_remote"]; "amovppnemstpsnonwnondnon"
					//[player,"AmovPpneMstpSnonWnonDnon"] remoteExec ["fnc_playerSwitchMove_remote"];
				};
				player setVariable ["search", false, true];
				player setVariable ["animstate","none",true];
			};
		};
		if (stuncountdown>stunmax) then {
			stuncountdown=stunmax;
		};
	
	} else {
	
		//disableUserInput false;
		
	};
	
	
	sleep 1;
};
