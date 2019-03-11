
_database = "armaworld"; //название базы данных
fnc_compileThisShitFinally = {
	private ["_function","_str","_functionText"];
	
	_function = _this;
	
	_functionText = toArray str (call compile _function);
	_functionText deleteAt 0;
	_functionText deleteAt ((count _functionText) - 1);
	_functionText = toString _functionText;
	
	_str = [_function,"= compileFinal",str _functionText] joinString " ";
	
	call compile _str;
	
};
fnc_compileThisShitFinallyPublic = {
	private ["_function","_str","_functionText"];
	
	_function = _this;
	
	_functionText = toArray str (call compile _function);
	_functionText deleteAt 0;
	_functionText deleteAt ((count _functionText) - 1);
	_functionText = toString _functionText;
	
	_str = [_function,"= compileFinal",str _functionText] joinString " ";
	
	call compile _str;
	
	publicVariable _function;
	
};
	kokoko123 = false;
	publicVariable "kokoko123";
	
	
dprk_date = (call compile ("extDB3" callExtension "9:LOCAL_TIME")) select 1;
publicVariable "dprk_date";
"extDB3" callExtension format ["9:ADD_DATABASE:%1:%1",_database];
"extDB3" callExtension format ["9:ADD_DATABASE_PROTOCOL:%1:SQL:SQL",_database];
sleep 1;
[] execVM "serverstuff\dbfuncs.sqf";
[] execVM "serverstuff\funcs.sqf";
[] execVM "serverstuff\functions.sqf";
[] execVM "serverstuff\respawn.sqf";
[] execVM "serverstuff\publicvars.sqf";
[] execVM "serverstuff\remfnc.sqf";
[] execVM "serverstuff\cfinal.sqf";
[] execVM "serverstuff\shopfuncs.sqf";
[] execVM "serverstuff\playerlist_new.sqf";
fnc_getResult_remoteFunc_code = {
			waiting_result = _this;
		};
publicVariable "fnc_getResult_remoteFunc_code";
fnc_getResult_remoteFunc = {
		private ["_code","_result","_player","_args"];
		_code = _this select 0;
		_player = _this select 1;
		_args = _this select 2;
		_result = _args call _code;
		_result remoteExec ["fnc_getResult_remoteFunc_code",_player];
	};
publicVariable "fnc_getResult_remoteFunc";
fnc_getResult = {
	private ["_code","_args","_result","_remote"];
	_code = _this select 0;
	_args = _this select 1;
	waiting_result = nil;
	[_code,player,_args] remoteExec ["fnc_getResult_remoteFunc",2];
	waitUntil {!isNil "waiting_result"};
	_result = waiting_result;
	waiting_result = nil;
	_result
};
publicVariable "fnc_getResult";
fnc_serverUpdatePlayerCop = {
	
	private ["_code","_args","_result","_position","_direction","_food","_water","_bank","_cash","_weapons","_weapons_accs","_items","_weaponsCargo","_equipment","_mags"];
		
	_code = {
		
		("extDB3" callExtension format ["0:SQL:SELECT playeruid From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
	
	_args = [_this select 0];
	
	_result = _args call _code;
	
	//systemChat str _result;
	
	if (typeName (call compile _result) != "ARRAY") exitWith {systemChat "Ошибка базы данных! Проверьте данные подключения!";};
	if (typeName ((call compile _result) select 1) != "ARRAY") exitWith {systemChat "Ошибка базы данных! Проверьте данные подключения! Возвращён не массив!";};
	
	if (count ((call compile _result) select 1) < 1) then {
		
		_code = {
			
			private ["_callshit"];
			
			//_callshit = format ["0:SQL:INSERT INTO player_data (playeruid, name, position, direction, food, water, bank, inventory, items, weapons_cargo, equipment, weapons, magazines, licenses, vehicle_keys, player_values, factories, holster) VALUES ('%1','%2','%3',%4,%5,%6,%7,'%8','%9','%10','%11','%12','%13','%14','%15','%16','%17','%18')",_this select 0,_this select 1,_this select 2,_this select 3,_this select 4,_this select 5,_this select 6,_this select 7,_this select 8,_this select 9,_this select 10,_this select 11,_this select 12,_this select 13,_this select 14,_this select 15,_this select 16,_this select 17];
			
			_callshit = ["0:SQL:INSERT INTO player_data (playeruid, name, position_cop, direction_cop, food_cop, water_cop, bank, inventory_cop, items_cop, weapons_cargo_cop, equipment_cop, weapons_cop, magazines_cop, licenses_cop, vehicle_keys_cop, player_values_cop, holster, deatharray, roleplay_pts) VALUES ('", str (_this select 0), "','", str (_this select 1), "','", _this select 2, "',", _this select 3, ",", _this select 4, ",", _this select 5, ",", _this select 6, ",'", _this select 7, "','", _this select 8, "','", _this select 9, "','", _this select 10, "','", _this select 11, "','", _this select 12, "','", _this select 13, "','", _this select 14, "','", _this select 15, "','", _this select 17, "','", _this select 18, "',", _this select 19,")"] joinString "";
			
			("extDB3" callExtension _callshit)
			
		};
		_this call _code;
		
	} else {
				
		_code = {
			
			private ["_callshit"];
			
			//_callshit = ["0:SQL:INSERT INTO player_data (playeruid, name, position, direction, food, water, bank, inventory, items, weapons_cargo, equipment, weapons, magazines, licenses, vehicle_keys, player_values, factories, holster) VALUES ('", _this select 0, "','", _this select 1, "','", _this select 2, "',", _this select 3, ",", _this select 4, ",", _this select 5, ",", _this select 6, ",'", _this select 7, "','", _this select 8, "','", _this select 9, "','", _this select 10, "','", _this select 11, "','", _this select 12, "','", _this select 13, "','", _this select 14, "','", _this select 15, "','", _this select 16, "','", _this select 17, "')"] joinString "";
			
			//0:SQL:UPDATE player_data SET name = '%2', position = '%3', direction = %4, food = %5, water = %6, bank = %7, cash = %8, items = '%9', weapons_cargo = '%10', equipment = '%11', weapons = '%12', magazines = '%13' WHERE playeruid = '%1'
			
			_callshit = ["0:SQL:UPDATE player_data SET name = '", str (_this select 1), "', position_cop = '", _this select 2, "', direction_cop = ", _this select 3, ", food_cop = ", _this select 4, ", water_cop = ", _this select 5, ", bank = ", _this select 6, ", inventory_cop = '", _this select 7, "', items_cop = '", _this select 8, "', weapons_cargo_cop = '", _this select 9, "', equipment_cop = '", _this select 10, "', weapons_cop = '", _this select 11, "', magazines_cop = '", _this select 12, "', licenses_cop = '", _this select 13, "', vehicle_keys_cop = '", _this select 14, "', player_values_cop = '", _this select 15, "', holster_cop = '", _this select 17, "', deatharray_cop = '", _this select 18, "', roleplay_pts = ", _this select 19, " WHERE playeruid = '", str (_this select 0), "'"] joinString "";
			
			("extDB3" callExtension _callshit)
			
			//("extDB3" callExtension format ["0:SQL:UPDATE player_data SET name = '%2', position = '%3', direction = %4, food = %5, water = %6, bank = %7, cash = %8, items = '%9', weapons_cargo = '%10', equipment = '%11', weapons = '%12', magazines = '%13' WHERE playeruid = '%1'",_this select 0,_this select 1,_this select 2,_this select 3,_this select 4,_this select 5,_this select 6,_this select 7,_this select 8,_this select 9,_this select 10,_this select 11,_this select 12])
			
		};
	
		_this call _code;
				
	};
	
	
};
fnc_serverUpdatePlayer = {
	
	private ["_code","_args","_result","_position","_direction","_food","_water","_bank","_cash","_weapons","_weapons_accs","_items","_weaponsCargo","_equipment","_mags"];
		
	_code = {
		
		("extDB3" callExtension format ["0:SQL:SELECT playeruid From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
	
	_args = [_this select 0];
	
	_result = _args call _code;
	
	//systemChat str _result;
	
	if (typeName (call compile _result) != "ARRAY") exitWith {systemChat "Ошибка базы данных! Проверьте данные подключения!";};
	if (typeName ((call compile _result) select 1) != "ARRAY") exitWith {systemChat "Ошибка базы данных! Проверьте данные подключения! Возвращён не массив!";};
	
	if (count ((call compile _result) select 1) < 1) then {
		
		_code = {
			
			private ["_callshit"];
			
			//_callshit = format ["0:SQL:INSERT INTO player_data (playeruid, name, position, direction, food, water, bank, inventory, items, weapons_cargo, equipment, weapons, magazines, licenses, vehicle_keys, player_values, factories, holster) VALUES ('%1','%2','%3',%4,%5,%6,%7,'%8','%9','%10','%11','%12','%13','%14','%15','%16','%17','%18')",_this select 0,_this select 1,_this select 2,_this select 3,_this select 4,_this select 5,_this select 6,_this select 7,_this select 8,_this select 9,_this select 10,_this select 11,_this select 12,_this select 13,_this select 14,_this select 15,_this select 16,_this select 17];
			
			_callshit = ["0:SQL:INSERT INTO player_data (playeruid, name, position, direction, food, water, bank, inventory, items, weapons_cargo, equipment, weapons, magazines, licenses, vehicle_keys, player_values, factories, holster, deatharray, workplaces, cooldown_array, roleplay_pts) VALUES ('", str (_this select 0), "','", str (_this select 1), "','", _this select 2, "',", _this select 3, ",", _this select 4, ",", _this select 5, ",", _this select 6, ",'", _this select 7, "','", _this select 8, "','", _this select 9, "','", _this select 10, "','", _this select 11, "','", _this select 12, "','", _this select 13, "','", _this select 14, "','", _this select 15, "','", _this select 16, "','", _this select 17, "','", _this select 18, "','", _this select 19, "','", _this select 20 , "',", _this select 21 ,")"] joinString "";
			
			("extDB3" callExtension _callshit)
			
		};
		_this call _code;
		
	} else {
				
		_code = {
			
			private ["_callshit"];
			
			//_callshit = ["0:SQL:INSERT INTO player_data (playeruid, name, position, direction, food, water, bank, inventory, items, weapons_cargo, equipment, weapons, magazines, licenses, vehicle_keys, player_values, factories, holster) VALUES ('", _this select 0, "','", _this select 1, "','", _this select 2, "',", _this select 3, ",", _this select 4, ",", _this select 5, ",", _this select 6, ",'", _this select 7, "','", _this select 8, "','", _this select 9, "','", _this select 10, "','", _this select 11, "','", _this select 12, "','", _this select 13, "','", _this select 14, "','", _this select 15, "','", _this select 16, "','", _this select 17, "')"] joinString "";
			
			//0:SQL:UPDATE player_data SET name = '%2', position = '%3', direction = %4, food = %5, water = %6, bank = %7, cash = %8, items = '%9', weapons_cargo = '%10', equipment = '%11', weapons = '%12', magazines = '%13' WHERE playeruid = '%1'
			
			_callshit = ["0:SQL:UPDATE player_data SET name = '", str (_this select 1), "', position = '", _this select 2, "', direction = ", _this select 3, ", food = ", _this select 4, ", water = ", _this select 5, ", bank = ", _this select 6, ", inventory = '", _this select 7, "', items = '", _this select 8, "', weapons_cargo = '", _this select 9, "', equipment = '", _this select 10, "', weapons = '", _this select 11, "', magazines = '", _this select 12, "', licenses = '", _this select 13, "', vehicle_keys = '", _this select 14, "', player_values = '", _this select 15, "', factories = '", _this select 16, "', holster = '", _this select 17, "', deatharray = '", _this select 18, "', workplaces = '", _this select 19,"', cooldown_array = '", _this select 20, "', roleplay_pts = ", _this select 21 ," WHERE playeruid = '", str (_this select 0), "'"] joinString "";
			
			("extDB3" callExtension _callshit)
			
			//("extDB3" callExtension format ["0:SQL:UPDATE player_data SET name = '%2', position = '%3', direction = %4, food = %5, water = %6, bank = %7, cash = %8, items = '%9', weapons_cargo = '%10', equipment = '%11', weapons = '%12', magazines = '%13' WHERE playeruid = '%1'",_this select 0,_this select 1,_this select 2,_this select 3,_this select 4,_this select 5,_this select 6,_this select 7,_this select 8,_this select 9,_this select 10,_this select 11,_this select 12])
			
		};
		
	
	 //isdead,respawntime,timetorespawn
	
		_this call _code;
		
		//systemChat str _result;
		
	};	
	
};
fnc_savePlayerDataCop_code1 = {
			
		_this call fnc_serverUpdatePlayerCop;
			
	};
	
publicVariable "fnc_savePlayerDataCop_code1";
fnc_savePlayerDataCop = {
	
	private ["_code","_args","_result","_position","_direction","_food","_water","_bank","_cash","_weapons","_weapons_accs","_items","_weaponsCargo","_equipment","_mags"];
	
	_position = getPosATL player;
	
	if (!isdead and (_position distance (getMarkerPos "respawn_civilian") < 500)) exitWith {};
	
	_direction = getDir player;
	_food = hunger;
	_water = thirst;
	_bank = deposit;
	_cash = player getVariable ["cash",0];
	_weapons = [primaryWeapon player, secondaryWeapon player, handgunWeapon player, binocular player];
	_weapons_accs = [player weaponAccessories primaryWeapon player,player weaponAccessories handgunWeapon player,player weaponAccessories secondaryWeapon player];
	_items = [assignedItems player];
	_weaponsCargo = [];
	_equipment = [uniform player, vest player, backpack player, headgear player, goggles player];
	_mags = magazinesAmmoFull player;
	
	if ((uniform player) != "") then {
		_items pushBack (itemCargo (uniformContainer player));
		_weaponsCargo pushBack (getWeaponCargo (uniformContainer player));
	} else {
		_items pushBack [];
		_weaponsCargo pushBack [];
	};
	if ((vest player) != "") then {
		_items pushBack (itemCargo (vestContainer player));
		_weaponsCargo pushBack (getWeaponCargo (vestContainer player));
	} else {
		_items pushBack [];
		_weaponsCargo pushBack [];
	};
	if ((backpack player) != "") then {
		_items pushBack (itemCargo (backpackContainer player));
		_weaponsCargo pushBack (getWeaponCargo (backpackContainer player));
	} else {
		_items pushBack [];
		_weaponsCargo pushBack [];
	};
		
	_args = [getPlayerUID player, name player, _position, _direction, _food, _water, _bank, [inventory_items,inventory_amount], _items, _weaponsCargo, _equipment, [_weapons,_weapons_accs], _mags, [licenses,licenses_illegal,demerits], vehicle_keys, [stress,addiction,addiction_level,maxweight,allowuseatm,stolencash,nationality,religion,[shootingskill,battleskill,lockpickskill,engskill,strengthskill,staminaskill],[charname,charlastname,rp_face,role_id],rp_firsttimewakeup,jailed, jailtimeleft, allowjailescape, stress_value, blood_array], [my_factories,my_factories_wh,my_factories_stock], [holsterGun,holsterGunMagazine,holsterGunRounds],[isdead,respawntime,timetorespawn,restrained_punish],roleplay_pts];
		
	_args remoteExec ["fnc_savePlayerDataCop_code1",2];
	
};
publicVariable "fnc_savePlayerDataCop";
fnc_savePlayerData_code1 = {
		
		_this call fnc_serverUpdatePlayer;
		
	};
	
publicVariable "fnc_savePlayerData_code1";
fnc_savePlayerData = {
	
	if ((str player) in cop_array) exitWith {[] call fnc_savePlayerDataCop;};
	
	private ["_code","_args","_result","_position","_direction","_food","_water","_bank","_cash","_weapons","_weapons_accs","_items","_weaponsCargo","_equipment","_mags"];
	
	_position = getPosATL player;
	
	if (!isdead and (_position distance (getMarkerPos "respawn_civilian") < 500)) exitWith {};
	
	_direction = getDir player;
	_food = hunger;
	_water = thirst;
	_bank = deposit;
	_weapons = [primaryWeapon player, secondaryWeapon player, handgunWeapon player, binocular player];
	_weapons_accs = [player weaponAccessories primaryWeapon player,player weaponAccessories handgunWeapon player,player weaponAccessories secondaryWeapon player];
	_items = [assignedItems player];
	_weaponsCargo = [];
	_equipment = [uniform player, vest player, backpack player, headgear player, goggles player];
	_mags = magazinesAmmoFull player;
	
	if ((uniform player) != "") then {
		_items pushBack (itemCargo (uniformContainer player));
		_weaponsCargo pushBack (getWeaponCargo (uniformContainer player));
	} else {
		_items pushBack [];
		_weaponsCargo pushBack [];
	};
	if ((vest player) != "") then {
		_items pushBack (itemCargo (vestContainer player));
		_weaponsCargo pushBack (getWeaponCargo (vestContainer player));
	} else {
		_items pushBack [];
		_weaponsCargo pushBack [];
	};
	if ((backpack player) != "") then {
		_items pushBack (itemCargo (backpackContainer player));
		_weaponsCargo pushBack (getWeaponCargo (backpackContainer player));
	} else {
		_items pushBack [];
		_weaponsCargo pushBack [];
	};
	
	_args = [getPlayerUID player, name player, _position, _direction, _food, _water, _bank, [inventory_items,inventory_amount], _items, _weaponsCargo, _equipment, [_weapons,_weapons_accs], _mags, [licenses,licenses_illegal,demerits], vehicle_keys, [stress,addiction,addiction_level,maxweight,allowuseatm,stolencash,nationality,religion,[shootingskill,battleskill,lockpickskill,engskill,strengthskill,staminaskill],[charname,charlastname,rp_face,role_id],rp_firsttimewakeup,jailed, jailtimeleft, allowjailescape, stress_value, blood_array], [my_factories,my_factories_wh,my_factories_stock], [holsterGun,holsterGunMagazine,holsterGunRounds],[isdead,respawntime,timetorespawn,restrained_punish],my_workplaces,cooldown_array,roleplay_pts];
	
	_args remoteExec ["fnc_savePlayerData_code1",2];
	
};
publicVariable "fnc_savePlayerData";
fnc_getDprkData_1 = {
	("extDB3" callExtension format ["0:SQL:SELECT variable,level,expires From dprk_data WHERE uid = '%1'",str (_this select 0)])
};
publicVariable "fnc_getDprkData_1";
fnc_loadPlayerData = {
	private ["_code","_args","_result"];
		
	_args = [getPlayerUID player];
	
	_result = [fnc_getDprkData_1,_args] call fnc_getResult;
	
	if (typeName (call compile _result) != "ARRAY") exitWith {systemChat "Ошибка базы данных! Проверьте данные подключения!";};
	
	if (typeName ((call compile _result) select 1) != "ARRAY") exitWith {systemChat "Ошибка базы данных! Проверьте данные подключения! Возвращён не массив!";};
	
	if (count ((call compile _result) select 1) > 0) then {
	
		private ["_dksprk","_act1"];
	
		//"[1,[[""bowman_var"",1,[7,10,2018]]]]"
		
		_result = call compile _result;
		
		_result = (_result select 1) select 0;
		
		//dprk_expire = _result select 2;
		
		_dksprk = _result select 2;
		_act1 = true;		
		
		if ((_dksprk select 2) < (dprk_date select 0)) then {
			_act1 = false;
		};
		
		if (((_dksprk select 2) == (dprk_date select 0)) and ((_dksprk select 1) < (dprk_date select 1))) then {
			_act1 = false;
		}; 
		
		if (((_dksprk select 2) == (dprk_date select 0)) and ((_dksprk select 1) == (dprk_date select 1)) and ((_dksprk select 0) < (dprk_date select 2))) then {
			_act1 = false;
		}; 
		
		missionNamespace setVariable [_result select 0, true];
			
		if (_act1) then {
			dprk_level = _result select 1;
			//systemChat "success";
		} else {
			dprk_level = 0;
			//systemChat "zero";
		};
				
		//systemChat str _result;
	
	} else {
	
		dprk_level = 0;
		//systemChat "vashe zero";
	
	};
	player setPosATL (getMarkerPos "respawn_civilian");
	if ((str player) in cop_array) then {
		[] spawn fnc_initCopLoadout;
	} else {
		[] spawn fnc_initCivLoadout;
	};
	
	if ((str player) in cop_array) exitWith {[] call fnc_loadPlayerDataCop;};	
		
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_1,_args] call fnc_getResult;
	
	if (typeName (call compile _result) != "ARRAY") exitWith {systemChat "Ошибка базы данных! Проверьте данные подключения!";};
	
	if (typeName ((call compile _result) select 1) != "ARRAY") exitWith {systemChat "Ошибка базы данных! Проверьте данные подключения! Возвращён не массив!";};
	
	if (count ((call compile _result) select 1) < 1) exitWith {
	
		if !(isdead) then {
			//coz respawn [] spawn fnc_clientShopsInit;
		};
		if (rp_firsttimewakeup==1) then {
			[] spawn fnc_openCharacterRollDialog;
		} else {
			[] spawn fnc_openRespawnDialog;
		};
	
	};
	
	//systemChat format ["'%1' 111",(((call compile _result) select 1) select 0) select 0];
		
	if (typeName ((((call compile _result) select 1) select 0) select 0) == "STRING") exitWith {
		
		if !(isdead) then {
			//coz respawn [] spawn fnc_clientShopsInit;
		};
		
		systemChat "Ошибка получения позиции!";
		
	};
		
	removeallweapons player;
	removeAllItemsWithMagazines player;
	removeUniform player;
	removeVest player;
	removeBackpack player;
	removeAllAssignedItems player;
	removeHeadgear player;
	removeGoggles player;
	
	systemChat "Загрузка персонажа...";
		
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_2,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	
	//systemChat "Загружаем одежду...";
	
	player forceAddUniform (_result select 0);
	player addVest (_result select 1);
	player addBackpack (_result select 2);
	player addHeadgear (_result select 3);
	player addGoggles (_result select 4);
	
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_3,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	
	//systemChat "Загружаем предметы...";
	
	{
		player linkItem _x;		
	} forEach (_result select 0);
	
	{
		player addItemToUniform _x;		
	} forEach (_result select 1);
	
	{
		player addItemToVest _x;		
	} forEach (_result select 2);
	
	{
		player addItemToBackpack _x;		
	} forEach (_result select 3);
	
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_4,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;	
		
	if ((uniform player) != "") then {
		_weapons = (_result select 0) select 0;
		_amounts = (_result select 0) select 1;
		{
			(uniformContainer player) addWeaponCargoGlobal [_x, _amounts select _forEachIndex];
		} forEach _weapons;
	};
	if ((vest player) != "") then {
		_weapons = (_result select 1) select 0;
		_amounts = (_result select 1) select 1;
		{
			(vestContainer player) addWeaponCargoGlobal [_x, _amounts select _forEachIndex];
		} forEach _weapons;
	};
	if ((backpack player) != "") then {
		_weapons = (_result select 2) select 0;
		_amounts = (_result select 2) select 1;
		{
			(backpackContainer player) addWeaponCargoGlobal [_x, _amounts select _forEachIndex];
		} forEach _weapons;
	};
		
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_5,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	
	//systemChat "Загружаем оружие...";
	
	{
		player addWeapon _x;
		
	} forEach (_result select 0);	
	
	{
		player addWeaponItem [primaryWeapon player, _x];
		
	} forEach ((_result select 1) select 0);	
	
	{
		player addWeaponItem [handgunWeapon player, _x];
		
	} forEach ((_result select 1) select 1);	
	
	{
		player addWeaponItem [secondaryWeapon player, _x];
		
	} forEach ((_result select 1) select 2);	
		
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_6,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	
	//systemChat "Загружаем магазины...";
	
	{
		_magazine = _x select 0;
		_ammo = _x select 1;
		_container = _x select 4;
		switch (_container) do {
			case "Uniform": {
				(uniformContainer player) addMagazineAmmoCargo [_magazine, 1, _ammo];
			};
			case "Vest": {
				(vestContainer player) addMagazineAmmoCargo [_magazine, 1, _ammo];
			};
			case "Backpack": {
				(backpackContainer player) addMagazineAmmoCargo [_magazine, 1, _ammo];
			};
			case "Throw_Bolt": {
				player addMagazine _magazine;
			};
			case "HandGrenadeMuzzle": {
				player addItem _magazine;
			};
			default {
				player addWeaponItem [_container, [_magazine, _ammo]];
			};
		};
		
		
	}foreach _result;
	
	systemChat "Загрузка завершена!";
		
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_7,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	
	//player setPosATL _result;
	last_position = _result;
		
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_8,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
		
	player setDir _result;
		
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_9,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	hunger = _result;
		
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_10,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	thirst = _result;
		
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_11,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	deposit = _result;
		
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_12,_args] call fnc_getResult;	
	
	if (typeName ((call compile _result) select 1) == "STRING") then {
	
		//systemChat "Таки мультипарт!";
	
		_dataos = call compile ((call compile _result) select 1);
		
		//systemChat format ["%1 DADADA", _dataos];
		
		_result = "";
	
		waitUntil {
		
			//systemChat "da";
			
			_newpls = [fnc_getRes_remote_code_12_2, [_dataos]] call fnc_getResult;
			_result = _result + _newpls;
			
			//copyToClipboard str _result;
		
			((count toArray _newpls) == 0)
		};
		
		_result = (((call compile _result) select 1) select 0) select 0;
	
	} else {
	
		//systemChat "Не мультипарт!";
		
		_result = (((call compile _result) select 1) select 0) select 0;
	
	};
	
	//systemChat (str _result);
	//systemChat str (count toArray (str _result));
	
	//systemChat str (count toArray (str _result));
	inventory_items = _result select 0;
	inventory_amount = _result select 1;
	
	player setVariable ["invi",inventory_items,true];
	player setVariable ["inva",inventory_amount,true];
		
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_13,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	licenses = _result select 0;
	licenses_illegal = _result select 1;
	demerits = _result select 2;
	
	player setVariable ["licenses_array",licenses,true];
		
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_14,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	vehicle_keys = _result;
	
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_15,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	
	stress = _result select 0;
	addiction = _result select 1;
	addiction_level = _result select 2;
	maxweight = _result select 3;
	allowuseatm = _result select 4;
	stolencash = _result select 5;
	nationality = _result select 6;
	religion = _result select 7;
	shootingskill = (_result select 8) select 0;
	battleskill = (_result select 8) select 1;
	lockpickskill = (_result select 8) select 2;
	engskill = (_result select 8) select 3;
	strengthskill = (_result select 8) select 4;
	staminaskill = (_result select 8) select 5;
	charname = (_result select 9) select 0;
	charlastname = (_result select 9) select 1;
	rp_face = (_result select 9) select 2;
	if (count (_result select 9) > 3) then {
		role_id = (_result select 9) select 3;
	};
	player setVariable ["rp_face_var",rp_face,true];
	[player, rp_face] remoteExec ["setFace"];
	rp_firsttimewakeup = (_result select 10);
	jailed = (_result select 11);
	jailtimeleft = (_result select 12);
	allowjailescape = (_result select 13);
	stress_value = (_result select 14);
	blood_array = (_result select 15);
	
	player setVariable ["charnames",[charname,charlastname],true];
	
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_16,_args] call fnc_getResult;	
	
	if (typeName ((call compile _result) select 1) == "STRING") then {
	
		//systemChat "Таки мультипарт!";
	
		_dataos = call compile ((call compile _result) select 1);
		
		//systemChat format ["%1 DADADA", _dataos];
		
		_result = "";
	
		waitUntil {
		
			//systemChat "da";
			
			_newpls = [fnc_getRes_remote_code_12_2, [_dataos]] call fnc_getResult;
			_result = _result + _newpls;
			
			//copyToClipboard str _result;
		
			((count toArray _newpls) == 0)
		};
		
		_result = (((call compile _result) select 1) select 0) select 0;
		
		//systemChat str (count toArray (str _result));
	
	} else {
	
		//systemChat "Не мультипарт!";
		
		_result = (((call compile _result) select 1) select 0) select 0;
	
	};
	
	my_factories = _result select 0;
	my_factories_wh = _result select 1;
	my_factories_stock = _result select 2;
	
	//systemChat format ["%1 %2", _result, my_factories];
		
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_17,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	
	holsterGun = _result select 0;
	holsterGunMagazine = _result select 1;
	holsterGunRounds = _result select 2;
		
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_18,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	
	isdead = _result select 0;
	respawntime = _result select 1;
	timetorespawn = _result select 2;
	restrained_punish = _result select 3;
	
	if isdead then {
		//player setPosATL last_position;
	} else {
		if (rp_firsttimewakeup==1) then {
			[] spawn fnc_openCharacterRollDialog;
		} else {
			if jailed then {
				cutText ["","BLACK IN",0];
				player setPos (getMarkerPos "prison_spawn");
				[] spawn fnc_clientShopsInit;
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
				[] spawn fnc_sitInJail;
				
			} else {
				[] spawn fnc_openRespawnDialog;
			};
		};
	};
	
	if (restrained_punish>0) then {
	
		allowjailescape = false;
		
		private ["_args"];
		
		_args = [player,player,30];
	
		_args remoteExec ["fnc_arrestAction_remote_code1"];
		
		systemChat "Вы вышли из игры будучи в наручниках либо оглушённым. Вам придётся отсидеть в тюрьме 30 минут.";
	
	};
	
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_19,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	
	my_workplaces = _result;
	
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_20,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	
	cooldown_array = _result;
	
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_21,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	
	//systemChat format ["%1 FIJASKFIJASKFIJASFASF",_result];
	
	roleplay_pts = _result;
	
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_22,_args] call fnc_getResult;
	
	_result = ((call compile _result) select 1);
	
	//systemChat format ["HELLO %1",_result];
	
	if (((count _result) > 0) and ((wanted_players_list find (getPlayerUID player)) < 0)) then {
		
		private ["_arrw"];
		
		_arrw = [];
		
		{
			_arrw pushBack [(_x select 1) select 0, _x select 2];
		} forEach _result;
		
		wanted_players_names pushBack (name player);
		publicVariable "wanted_players_names";
		wanted_players_list pushBack (getPlayerUID player);
		publicVariable "wanted_players_list";
		wanted_players_array pushBack _arrw;
		publicVariable "wanted_players_array";
	} else {
		if ((wanted_players_list find (getPlayerUID player)) >= 0) then {
			wanted_players_names set [wanted_players_list find (getPlayerUID player), name player];
			publicVariable "wanted_players_names";
		};
	};	
	
	//other
	
	if !(isdead) then {
		//coz respawn [] spawn fnc_clientShopsInit;
	};
		
	/*
	
jailed, jailtimeleft, allowjailescape
jailed = false;
jailtimeleft = 0;
allowjailescape = true;
	*/
	
		
};
publicVariable "fnc_loadPlayerData";
fnc_loadPlayerDataCop = {
	private ["_code","_args","_result"];
	
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_22,_args] call fnc_getResult;
	
	_result = ((call compile _result) select 1);
		
	if (((count _result) > 0) and ((wanted_players_list find (getPlayerUID player)) < 0)) then {
		
		private ["_arrw"];
		
		_arrw = [];
		
		{
			_arrw pushBack [(_x select 1) select 0, _x select 2];
		} forEach _result;
		
		wanted_players_names pushBack (name player);
		publicVariable "wanted_players_names";
		wanted_players_list pushBack (getPlayerUID player);
		publicVariable "wanted_players_list";
		wanted_players_array pushBack _arrw;
		publicVariable "wanted_players_array";
	} else {
		if ((wanted_players_list find (getPlayerUID player)) >= 0) then {
			wanted_players_names set [wanted_players_list find (getPlayerUID player), name player];
			publicVariable "wanted_players_names";
		};
	};	
	
	if ((getPlayerUID player) in wanted_players_list) exitWith {endMission "police_no"};
	
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_23,_args] call fnc_getResult;
	
	if (typeName (call compile _result) != "ARRAY") exitWith {systemChat "Ошибка базы данных! Проверьте данные подключения!";};
	
	if (typeName ((call compile _result) select 1) != "ARRAY") exitWith {systemChat "Ошибка базы данных! Проверьте данные подключения! Возвращён не массив!";};
	
	if (count ((call compile _result) select 1) < 1) exitWith {
	
		endMission "police_no2";
	
		if !(isdead) then {
			//coz respawn [] spawn fnc_clientShopsInit;
		};
		if (rp_firsttimewakeup==1) then {
			[] spawn fnc_openCharacterRollDialog;
		};
	
	};
	
	
	if (typeName ((((call compile _result) select 1) select 0) select 0) == "STRING") exitWith {
			
		_args = [getPlayerUID player];
		
		_result = [fnc_getRes_remote_code_40,_args] call fnc_getResult;
		
		_result = (((call compile _result) select 1) select 0) select 0;
		
		roleplay_pts = _result;
	
		_args = [getPlayerUID player];
		
		_result = [fnc_getRes_remote_code_33,_args] call fnc_getResult;
		
		_result = (((call compile _result) select 1) select 0) select 0;
		deposit = _result;
			
		if (roleplay_pts<50) exitWith {endMission "police_no2"};
		
		if !(isdead) then {
			//coz respawn [] spawn fnc_clientShopsInit;
		};
		if (rp_firsttimewakeup==1) then {
			[] spawn fnc_openCharacterRollDialog;
		} else {
			[] spawn fnc_openRespawnDialog;
		};
		
	};
	
	removeallweapons player;
	removeAllItemsWithMagazines player;
	removeUniform player;
	removeVest player;
	removeBackpack player;
	removeAllAssignedItems player;
	removeHeadgear player;
	removeGoggles player;
	
	systemChat "Загрузка персонажа...";
	
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_24,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	
	//systemChat "Загружаем одежду...";
	
	player forceAddUniform (_result select 0);
	player addVest (_result select 1);
	player addBackpack (_result select 2);
	player addHeadgear (_result select 3);
	player addGoggles (_result select 4);
	
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_25,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	
	//systemChat "Загружаем предметы...";
	
	{
		player linkItem _x;		
	} forEach (_result select 0);
	
	{
		player addItemToUniform _x;		
	} forEach (_result select 1);
	
	{
		player addItemToVest _x;		
	} forEach (_result select 2);
	
	{
		player addItemToBackpack _x;		
	} forEach (_result select 3);
	
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_26,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;	
		
	if ((uniform player) != "") then {
		_weapons = (_result select 0) select 0;
		_amounts = (_result select 0) select 1;
		{
			(uniformContainer player) addWeaponCargoGlobal [_x, _amounts select _forEachIndex];
		} forEach _weapons;
	};
	if ((vest player) != "") then {
		_weapons = (_result select 1) select 0;
		_amounts = (_result select 1) select 1;
		{
			(vestContainer player) addWeaponCargoGlobal [_x, _amounts select _forEachIndex];
		} forEach _weapons;
	};
	if ((backpack player) != "") then {
		_weapons = (_result select 2) select 0;
		_amounts = (_result select 2) select 1;
		{
			(backpackContainer player) addWeaponCargoGlobal [_x, _amounts select _forEachIndex];
		} forEach _weapons;
	};
	
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_27,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	
	//systemChat "Загружаем оружие...";
	
	{
		player addWeapon _x;
		
	} forEach (_result select 0);	
	
	{
		player addWeaponItem [primaryWeapon player, _x];
		
	} forEach ((_result select 1) select 0);	
	
	{
		player addWeaponItem [handgunWeapon player, _x];
		
	} forEach ((_result select 1) select 1);	
	
	{
		player addWeaponItem [secondaryWeapon player, _x];
		
	} forEach ((_result select 1) select 2);
	
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_28,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	
	//systemChat "Загружаем магазины...";
	
	{
		_magazine = _x select 0;
		_ammo = _x select 1;
		_container = _x select 4;
		switch (_container) do {
			case "Uniform": {
				(uniformContainer player) addMagazineAmmoCargo [_magazine, 1, _ammo];
			};
			case "Vest": {
				(vestContainer player) addMagazineAmmoCargo [_magazine, 1, _ammo];
			};
			case "Backpack": {
				(backpackContainer player) addMagazineAmmoCargo [_magazine, 1, _ammo];
			};
			case "Throw_Bolt": {
				player addMagazine _magazine;
			};
			case "HandGrenadeMuzzle": {
				player addItem _magazine;
			};
			default {
				player addWeaponItem [_container, [_magazine, _ammo]];
			};
		};
		
		
	}foreach _result;
	
	systemChat "Загрузка завершена!";
	
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_29,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	
	//player setPosATL _result;
	last_position = _result;
	
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_30,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
		
	player setDir _result;
	
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_31,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	hunger = _result;
	
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_32,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	thirst = _result;
	
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_33,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	deposit = _result;
	
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_34,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	inventory_items = _result select 0;
	inventory_amount = _result select 1;
	
	player setVariable ["invi",inventory_items,true];
	player setVariable ["inva",inventory_amount,true];
	
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_35,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	licenses = _result select 0;
	licenses_illegal = _result select 1;
	demerits = _result select 2;
	
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_36,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	vehicle_keys = _result;
	
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_37,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	
	stress = _result select 0;
	addiction = _result select 1;
	addiction_level = _result select 2;
	maxweight = _result select 3;
	allowuseatm = _result select 4;
	stolencash = _result select 5;
	nationality = _result select 6;
	religion = _result select 7;
	shootingskill = (_result select 8) select 0;
	battleskill = (_result select 8) select 1;
	lockpickskill = (_result select 8) select 2;
	engskill = (_result select 8) select 3;
	strengthskill = (_result select 8) select 4;
	staminaskill = (_result select 8) select 5;
	charname = (_result select 9) select 0;
	charlastname = (_result select 9) select 1;
	rp_face = (_result select 9) select 2;
	if (count (_result select 9) > 3) then {
		role_id = (_result select 9) select 3;
	};
	player setVariable ["rp_face_var",rp_face,true];
	[player, rp_face] remoteExec ["setFace"];
	rp_firsttimewakeup = (_result select 10);
	jailed = (_result select 11);
	jailtimeleft = (_result select 12);
	allowjailescape = (_result select 13);
	stress_value = (_result select 14);
	blood_array = (_result select 15);
	
	player setVariable ["charnames",[charname,charlastname],true];
	
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_38,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	
	holsterGun = _result select 0;
	holsterGunMagazine = _result select 1;
	holsterGunRounds = _result select 2;
	
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_39,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	
	isdead = _result select 0;
	respawntime = _result select 1;
	timetorespawn = _result select 2;
	restrained_punish = _result select 3;
	
	if isdead then {
		//player setPosATL last_position;
	} else {
		if (rp_firsttimewakeup==1) then {
			[] spawn fnc_openCharacterRollDialog;
		} else {
			if jailed then {				
				cutText ["","BLACK IN",0];
				player setPos (getMarkerPos "prison_spawn");
				[] spawn fnc_clientShopsInit;
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
				
				[] spawn fnc_sitInJail;
				
			} else {
				[] spawn fnc_openRespawnDialog;
			};
		};
	};
	
	if (restrained_punish>0) then {
	
		allowjailescape = false;
		
		private ["_args"];
		
		_args = [player,player,30];
	
		_args remoteExec ["fnc_arrestAction_remote_code1"];
				
		systemChat "Вы вышли из игры будучи в наручниках либо оглушённым. Вам придётся отсидеть в тюрьме 30 минут.";
	
	};
	
	_args = [getPlayerUID player];
	
	_result = [fnc_getRes_remote_code_40,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	
	roleplay_pts = _result;
		
	if (roleplay_pts<50) exitWith {endMission "police_no2"};
	
	//other
	
	if !(isdead) then {
		//coz respawn [] spawn fnc_clientShopsInit;
	};
		
	
};
publicVariable "fnc_loadPlayerDataCop";
[] spawn {
	private ["_currentTimestamp","_nowServerTimeHour","_nowServerTimeMin","_nowServerTimeSec","_code","_warn30","_warn15","_warn10","_warn5","_warn1","_restarts","_restartsbefore"];
	
	_warn30 = true;
	_warn15 = true;
	_warn10 = true;
	_warn5 = true;
	_warn1 = true;
	
	_restarts = [24,4,8,12,16,20];
	_restartsbefore = [30,15,10,5,1];
	while {true} do {
		
		_currentTimestamp = (call compile ("extDB3" callExtension "9:LOCAL_TIME")) select 1;
		_nowServerTimeHour = _currentTimestamp select 3;
		_nowServerTimeMin  = _currentTimestamp select 4;
		_nowServerTimeSec  = _currentTimestamp select 5;
		
		{
		
			private ["_hour"];
			
			_hour = _x;
		
			{
			
				if (call compile format ["_warn%1",_x]) then {
				
					if ((_nowServerTimeHour == (_hour - 1)) and (_nowServerTimeMin >= (60 - _x))) then {
					
						(call compile format ["_warn%1 = false;",_x]);
								
						if (_x == 5) then {
						
							restartsoon = true;
							publicVariable "restartsoon";
						
						};
						
						_code = {
						
							hint format ["Рестарт сервера через %1 минут!",_this];
							systemChat format ["Рестарт сервера через %1 минут!",_this];
							["РЕСТАРТ",format ["Рестарт сервера через %1 минут!",_this],[1,1,1,1],[0.5,0.5,0.5,0.8]] spawn fnc_notifyMePls;
						
						};
						
						[_x,_code] remoteExec ["spawn"];
					
					};
				
				};
			
			} forEach _restartsbefore;
		
		} forEach _restarts;
		
		sleep 1;
	
	};
};
[8, 5, 1] spawn {
	ENV_ZEIT_MORGEN = 09;
	ENV_ZEIT_ABEND  = 21;
	
	while {isServer} do {
	
		if ((daytime > ENV_ZEIT_ABEND) or (daytime < ENV_ZEIT_MORGEN)) then {
		
			setTimeMultiplier 36;
		
		} else {
		
			setTimeMultiplier 12;
		
		};	
		
		sleep 60;
	
	};
	
	/*
	while {isServer} do {
		if (SkipTimeDay == 0) exitWith {};
		_WarteBeiTag   = (_this select 0) * 60;
		_WarteBeiNacht = (_this select 1) * 60;
		_SkiptDuration = (_this select 2);
		currentTime = daytime;
		while {true} do 
			{
			if ((daytime > ENV_ZEIT_ABEND) or (daytime < ENV_ZEIT_MORGEN)) then 
				{
				if (_WarteBeiNacht == 0) then 
					{
					if (daytime < ENV_ZEIT_MORGEN) then 
						{
						skiptime (floor(ENV_ZEIT_MORGEN - daytime));
						} 
						else 
						{
						skiptime ((floor(24 - daytime)) + ENV_ZEIT_MORGEN);
						};
					} 
					else 
					{
					sleep _WarteBeiNacht;
					};
				} 
				else 
				{
				sleep _WarteBeiTag;
				
				};
			//format['skiptime %1', _SkiptDuration] call broadcast;
			
			skiptime _SkiptDuration;
			
			currentTime = daytime;
				
			};
	};
	
	*/
};
