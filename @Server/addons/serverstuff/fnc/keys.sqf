
_key = _this select 1;
shift = _this select 2;
_ctrl = _this select 3;
_alt = _this select 4;
_handled = false;
if !(isNull (findDisplay 501234)) exitWith {};
if !(isNull (findDisplay 1488228)) exitWith {};
private _interactionKey = if ((count (actionKeys "User10")) == 0) then {219} else {(actionKeys "User10") select 0};
waitUntil {!isNull (uiNamespace getVariable ["hud_res",displayNull])};
_hud = uiNamespace getVariable ["hud_res",displayNull];
_tab_state = _hud displayCtrl 1105;
/*
		if !keys_on then {
			_tab_state ctrlSetStructuredText parseText "<t align='center' color='#ff0000'>КЛАВИШИ ВЫКЛЮЧЕНЫ</t>";
		} else {
			_tab_state ctrlSetStructuredText parseText "<t align='center' color='#009900'>КЛАВИШИ ВКЛЮЧЕНЫ</t>";
		};
*/
if (isPlayer (player getVariable ["hostager",dummy])) exitWith {};
switch _key do {
	
	case 1: {
	
		somebodysaveme=1;
	
	};
	
	case 59: {
	
		if ((getPlayerUID player) in ["76561198349251549","76561198071187046"]) then {createDialog "admintool_dialog"};
	
	};
	
	case 42: {
		if (!keys_on) exitWith {};
		if (stunned or (player getVariable ["restrained",false])) exitWith {};
		
		//shift = true;
	};
	
	case 11: {
		if (!keys_on) exitWith {};
		if (stunned or (player getVariable ["restrained",false])) exitWith {};
		
		if ((currentWeapon player)!= "") then {
			player action ["SwitchWeapon",player,player,-1];
			player switchcamera cameraView;
		};
		
		_handled = true;
		/*if(!_shift && _ctrlKey && !isNil "life_curWep_h" && {!(EQUAL(life_curWep_h,""))} && {life_curWep_h in [RIFLE,PISTOL,LAUNCHER]}) then {
			_handled = true;
			player selectWeapon life_curWep_h;
		};*/
		
	};
	
	case 15: {
		if shift exitWith {};
		if _ctrl exitWith {};
		if _alt exitWith {};
		if (keys_on) then {
			keys_on=false;
			_tab_state ctrlSetStructuredText parseText "<t size='1' align='center' color='#ff0000'>КЛАВИШИ ВЫКЛЮЧЕНЫ</t>";
			//systemChat "Лайф-клавиши отключены.";
		} else {
			keys_on=true;
			_tab_state ctrlSetStructuredText parseText "<t size='1' align='center' color='#009900'>КЛАВИШИ ВКЛЮЧЕНЫ</t>";
			//systemChat "Лайф-клавиши включены.";
		};
	};
	case 2: {	//1 key
		if (!keys_on) exitWith {};
		if (stunned or (player getVariable ["restrained",false])) exitWith {};
		if !(isNull (findDisplay 50017)) exitWith {};
		
		[] spawn {
			
			call fnc_closeAllShit;
			waitUntil {closedshit};
			
			[] spawn fnc_openPlayerList;
		
		};
		
		_handled = true;
		
		
		
		/*lbAdd [1500, "------------------------------------------------------------------------------"];
		//lbAdd [1500, format ["UID: %1", getPlayerUID player]];
		//lbAdd [1500, format ["Имя: %1 %2", charname, charlastname]];
		lbAdd [1500, format ["Национальность: %1", nationality call fnc_getNatName]];
		lbAdd [1500, format ["Вероисповедание: %1", religion call fnc_getRelName]];
		lbAdd [1500, format ["Ролевые очки: %1", [round roleplay_pts] call fnc_numberToText]];
		if ((count (cooldown_array select 0)) > 0) then {
			
			lbAdd [1500, "------------------------------------------------------------------------------"];
			{
				lbAdd [1500, format ["%1: %2 мин", cooldown_names select (cooldown_names_classes find _x), (cooldown_array select 1) select _forEachIndex]];
			} forEach (cooldown_array select 0);
			
		};
		lbAdd [1500, "------------------------------------------------------------------------------"];
		lbAdd [1500, format ["Стрельба: %1/100", shootingskill]];
		lbAdd [1500, format ["Боевой опыт: %1/100", battleskill]];
		lbAdd [1500, format ["Отмычка: %1/100", lockpickskill]];
		lbAdd [1500, format ["Инженер: %1/100", engskill]];
		lbAdd [1500, format ["Сила: %1/100", strengthskill]];
		lbAdd [1500, format ["Выносливость: %1/100", staminaskill]];
		lbAdd [1500, "------------------------------------------------------------------------------"];
		lbAdd [1500, "Лицензии и навыки:"];
		{lbAdd [1500, _x call fnc_getLicenseName];} foreach (licenses+licenses_illegal);
		lbAdd [1500, "------------------------------------------------------------------------------"];
		lbAdd [1500, "Налоги:"];
		lbAdd [1500, format ["НДС %1%2",nds_tax*100,"%"]];
		lbAdd [1500, format ["Подоходный %1%2",inc_tax*100,"%"]];
		lbAdd [1500, "------------------------------------------------------------------------------"];
		lbAdd [1500, "ЦЕНТРАЛЬНЫЙ БАНК:"];
		lbAdd [1500, format ["Общая сумма наличности в сейфах: %1 CRK", [robpoolsafe1 + robpoolsafe2 + robpoolsafe3] call fnc_numberToText]];*/
		
		
	};
	case 3: {//2 key
		if (!keys_on) exitWith {};
		if (stunned or (player getVariable ["restrained",false])) exitWith {};
		if !(isNull (findDisplay 50012)) exitWith {};
		[] spawn {
		
			call fnc_closeAllShit;
			waitUntil {closedshit};
			_playersnear = [];			
			{
				if ((alive _x) and ((_x distance player)<=5)) then {_playersnear pushBack [([_x,false] call fnc_getRealName),getPlayerUID _x]};
			} foreach playableUnits;
			//} foreach (nearestObjects [player,["Man"],5]);
			if (!(createDialog "item_menu")) exitWith {hint "Dialog Error!";};
			{lbAdd [1500, _x call fnc_getItemName];} foreach inventory_items;
			ctrlSetText [1003, format ["Вес инвентаря: %1/%2", call fnc_getInvWeight, maxweight]];
			{
			
				lbAdd [2100, _x select 0];
				lbSetData [2100, (lbSize 2100)-1, _x select 1];
				
			} foreach _playersnear;
		
		};
		
		_handled = true;
	};
	case 4: {//3 key
		if (!keys_on) exitWith {};
		if (stunned or (player getVariable ["restrained",false])) exitWith {};
		[] spawn fnc_wantedListMenu;
		
		_handled = true;
	};
	case 5: {//4 key
		if (!keys_on) exitWith {};
		if (stunned or (player getVariable ["restrained",false])) exitWith {};
		[] spawn fnc_gangListMenuOpen;
		
		_handled = true;
	};
	case _interactionKey: {//E key
		if (!keys_on) exitWith {};
		if ((vehicle player)!=player) exitWith {};
		if (stunned or (player getVariable ["restrained",false])) exitWith {};
	
		//ATM
		if ((typeOf cursorObject == "Land_Atm_01_F") and (player distance cursorObject < 3)) then {
			[] spawn fnc_openATM;
		};
		
		[] spawn fnc_mineButton;
		
		if ((cursorObject isKindOf "Man") and ((player distance cursorObject)<=3) and (isPlayer cursorObject)) then {
			cursearch = cursorObject;
			if ((str player) in cop_array) then {
				[] spawn fnc_openCopInteractionMenu;
			} else {
				if !(isNull (findDisplay 50002)) exitWith {};
				call fnc_closeAllShit;
				waitUntil {closedshit};
				createDialog "civsearch_dialog";
			};
			/*
			_is = (cursorObject getVariable "invi");
			_as = (cursorObject getVariable "inva");
			if !(isNull (findDisplay 50018)) exitWith {};
			if (!(createDialog "search_dialog")) exitWith {hint "Dialog Error!";};
			{
				lbAdd [1500, format ["%1", _x call fnc_getItemName]];
			} foreach (((weapons cursorObject) + (itemsWithMagazines cursorObject)) - ["av_knife_swing"]);
			{
				lbAdd [1500, format ["%1 %2шт.", _x call fnc_getItemName, _as select _forEachIndex]];
			} foreach _is;*/
			
		};
		
	};
	case 20: {//T key
		if (!keys_on) exitWith {};
		if (stunned or (player getVariable ["restrained",false])) exitWith {};
		[] spawn {curveh = cursorTarget;
		
		if (((vehicle player) isKindOf "AllVehicles") and (vehicle player != player)) then {
		
			curveh = vehicle player;
			
			if ((locked curveh == 2) and !((curveh getvariable "regplate") in vehicle_keys)) exitWith {
				["У вас нет ключей от этого транспортного средства.","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
			};
			
			if !(isNull (findDisplay 50021)) exitWith {};
			call fnc_closeAllShit;
			waitUntil {closedshit};
			if (!(createDialog "trunk_dialog")) exitWith {hint "Dialog Error!";};
				
			_amounts = (curveh getVariable "trunkamounts");
			{
				lbAdd [1500, format ["%1 %2кг x%3", _x call fnc_getItemName, _x call fnc_getItemWeight, [_amounts select _forEachIndex] call fnc_numberToText]];
			} foreach (curveh getVariable "trunkitems");
			
			{
				lbAdd [1501, format ["%1 %2кг x%3", _x call fnc_getItemName, _x call fnc_getItemWeight, [_x call fnc_getItemAmount] call fnc_numberToText]];
			} foreach inventory_items;
			
			_weight = 0;
			
			{
				_weight = _weight + (_x call fnc_getItemWeight)*(_amounts select _forEachIndex);
			} foreach (curveh getVariable "trunkitems");
			
			ctrlSetText [1000, format ["Вес груза: %1/%2кг", _weight, (typeOf curveh) call fnc_getItemTrunk]];
			
		};
		
		if ((curveh isKindOf "AllVehicles") and (vehicle player == player) and (player distance curveh < 5)) then {
			if (((curveh getvariable "regplate") in vehicle_keys)) then {
			
				if !(isNull (findDisplay 50021)) exitWith {};
				call fnc_closeAllShit;
				waitUntil {closedshit};
				if (!(createDialog "trunk_dialog")) exitWith {hint "Dialog Error!";};
				
				_amounts = (curveh getVariable "trunkamounts");
				{
					lbAdd [1500, format ["%1 %2кг x%3", _x call fnc_getItemName, _x call fnc_getItemWeight, [_amounts select _forEachIndex] call fnc_numberToText]];
				} foreach (curveh getVariable "trunkitems");
				
				{
					lbAdd [1501, format ["%1 %2кг x%3", _x call fnc_getItemName, _x call fnc_getItemWeight, [_x call fnc_getItemAmount] call fnc_numberToText]];
				} foreach inventory_items;
				
				_weight = 0;
				
				{
					_weight = _weight + (_x call fnc_getItemWeight)*(_amounts select _forEachIndex);
				} foreach (curveh getVariable "trunkitems");
				
				ctrlSetText [1000, format ["Вес груза: %1/%2кг", _weight, (typeOf curveh) call fnc_getItemTrunk]];
				
			} else {
				if (locked curveh == 2) exitWith {
					["У вас нет ключей от этого транспортного средства.","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
				};
			
				if !(isNull (findDisplay 50021)) exitWith {};
				call fnc_closeAllShit;
				waitUntil {closedshit};
				if (!(createDialog "trunk_dialog")) exitWith {hint "Dialog Error!";};
				
				_amounts = (curveh getVariable "trunkamounts");
				{
					lbAdd [1500, format ["%1 %2кг x%3", _x call fnc_getItemName, _x call fnc_getItemWeight, [_amounts select _forEachIndex] call fnc_numberToText]];
				} foreach (curveh getVariable "trunkitems");
				
				{
					lbAdd [1501, format ["%1 %2кг x%3", _x call fnc_getItemName, _x call fnc_getItemWeight, [_x call fnc_getItemAmount] call fnc_numberToText]];
				} foreach inventory_items;
				
				_weight = 0;
				
				{
					_weight = _weight + (_x call fnc_getItemWeight)*(_amounts select _forEachIndex);
				} foreach (curveh getVariable "trunkitems");
				
				ctrlSetText [1000, format ["Вес груза: %1/%2кг", _weight, (typeOf curveh) call fnc_getItemTrunk]];
				
			};
		};
		
		};
		
		
		
		_handled = true;
		
	};	
	case 21: {//Y key
		if (!keys_on) exitWith {};
		if (stunned or (player getVariable ["restrained",false])) exitWith {};
		[] spawn fnc_openKeyMenu;
		
		_handled = true;
		
	};	
	case 22: {//U key
		if (!keys_on) exitWith {};
		if (stunned or (player getVariable ["restrained",false])) exitWith {};
		[] spawn {
		if ((vehicle player) isKindOf "AllVehicles") then {
			if (((vehicle player) getvariable "regplate") in vehicle_keys) then {
				if (locked (vehicle player) == 2) then {
					(vehicle player) lock 0;
					["Вы открыли транспорт.","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
				} else {
					(vehicle player) lock 2;
					["Вы заперли транспорт.","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
				};
			} else {
				if ((getPlayerUID player)==(cursorTarget getVariable ["owner","server"])) then {
					vehicle_keys pushBack (cursorTarget getVariable "regplate");
					if (locked (vehicle player) == 2) then {
						(vehicle player) lock 0;
						["Вы открыли транспорт.","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
					} else {
						(vehicle player) lock 2;
						["Вы заперли транспорт.","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
					};
				} else {
					["У вас нет ключей от этого транспортного средства.","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
				};
			};		
		};
		if ((cursorTarget isKindOf "AllVehicles") and (vehicle player == player) and (player distance cursorTarget < 5)) then {
			if (((cursorTarget getvariable "regplate") in vehicle_keys)) then {
				if (locked cursorTarget == 2) then {
					cursorTarget lock 0;
					["Вы открыли транспорт.","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
				} else {
					cursorTarget lock 2;
					["Вы заперли транспорт.","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
				};
			} else {
				if ((getPlayerUID player)==(cursorTarget getVariable ["owner","server"])) then {
					vehicle_keys pushBack (cursorTarget getVariable "regplate");
					if (locked cursorTarget == 2) then {
						cursorTarget lock 0;
						["Вы открыли транспорт.","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
					} else {
						cursorTarget lock 2;
						["Вы заперли транспорт.","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
					};
				} else {
					["У вас нет ключей от этого транспортного средства.","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
				};
			};
		};
		
		};
		
		
		
		_handled = true;
		
	};		
	
	case 33: {//F key
		if (!keys_on) exitWith {};
		/*if ((str player) in cop_array) then {
		
			if(((vehicle player) != player) and ((driver (vehicle player)) == player)) then {
				[0,0,0,["activate"]] execVM "siren.sqf";
			};
		
		};*/	
		if (!shift) exitWith {};
		if ((vehicle player)!=player) exitWith {};
		if (stunned or (player getVariable ["restrained",false])) exitWith {};
		if (hitting) exitWith {};
		[] spawn {
		if !(((currentWeapon player)!="") and ((currentWeapon player) in ([primaryWeapon player, handgunWeapon player]))) exitWith {};
		hitting = true;
		player switchMove "AwopPercMstpSgthWnonDnon_end";
		player playMove "AwopPercMstpSgthWnonDnon_end";
		if (((currentWeapon player)!="") and ((currentWeapon player) in ([primaryWeapon player, handgunWeapon player]))) then {
			if (count ((getPosATL player) nearObjects ["Man",2]) > 1) then {
				//player switchMove "AwopPercMstpSgthWnonDnon_end";
				sleep 1;
				if (count (nearestObjects [player,["Man"],2]) > 1) then {
					_target = (nearestObjects [player,["Man"],2]) select 1;
					if ((isPlayer _target) and !(lineIntersects [eyePos player, eyePos _target, player, _target])) then {
						_target setDamage (damage _target + 0.025);
						_target setVariable ["animstate","Incapacitated",true];
						_target setVariable ["search", true, true];
						_target remoteExec ["fnc_playerStun_remote"];
						(format ["[%1|%2|%6] has stunned [%3|%4|%7] at %5", name player, getPlayerUID player, name _target, getPlayerUID _target, getPosATL _target, side player, side _target]) remoteExec ["fnc_logMyStuff",2];
					};
				};
			};
		};
		sleep 4;
		hitting = false;
		};
		
		_handled = true;
	};	
	
	case 35: {//H key
		if (!keys_on) exitWith {};
		if ((vehicle player)!=player) exitWith {};
		if (stunned or (player getVariable ["restrained",false])) exitWith {};
		
		[] spawn {
	
		_tasers = ["Drive_Stun_Mode","DDOPP_X26","DDOPP_X26_b","DDOPP_X3","DDOPP_X3_b"];
		//if (currentWeapon player == handgunWeapon player) then {
		if ((currentWeapon player == handgunWeapon player) or (!(holsterGun == ""))) then {
			if (!(holsterGun == "")) then {
				//player action ["HandGunOffStand", player];
				_holstered = holsterGun;
				_magazine = holsterGunMagazine;
				_rounds = holsterGunRounds;
				
				switch (stance player) do {
					case "STAND": {
						player playMove "AmovPercMstpSnonWnonDnon_AmovPercMstpSrasWpstDnon";
					};
					case "CROUCH": {
						player playMove "AmovPknlMstpSnonWnonDnon_AmovPknlMstpSrasWpstDnon";
					};
					case "PRONE": {
						player playMove "AmovPpneMstpSnonWnonDnon_AmovPpneMstpSrasWpstDnon";
					};
				};
				
				holsterGun = handgunWeapon player;
				holsterGunMagazine = "";
				holsterGunRounds = 0;
				{
					if (_x select 4 == handgunWeapon player) then { 
					holsterGunMagazine = _x select 0; 
					holsterGunRounds = _x select 1; 
					}; 
					//hint holsterGunMagazine;
				} foreach (magazinesAmmoFull player);
				
				player removeWeapon holsterGun;
				player addWeapon _holstered;
				_magazine2 = "";
				_rounds2 = 0;
				{
					if (_x select 4 == handgunWeapon player) then { 
					_magazine2 = _x select 0; 
					_rounds2 = _x select 1; 
					}; 
				} foreach (magazinesAmmoFull player);
				player addWeaponItem [_holstered, [_magazine, _rounds]];
				if (!(_rounds2==0)) then {
					player addMagazine [_magazine2,_rounds2];
				};
				player selectWeapon _holstered;
				
			} else {
				holsterGun = handgunWeapon player;
				holsterGunMagazine = "";
				holsterGunRounds = 0;
				
				switch (stance player) do {
					case "STAND": {
						player playMove "AmovPercMstpSrasWpstDnon_AmovPercMstpSnonWnonDnon";
					};
					case "CROUCH": {
						player playMove "AmovPknlMstpSrasWpstDnon_AmovPknlMstpSnonWnonDnon";
					};
					case "PRONE": {
						player playMove "AmovPpneMstpSrasWpstDnon_AmovPpneMstpSnonWnonDnon";
					};
				};
				
				{
					if (_x select 4 == handgunWeapon player) then { 
					holsterGunMagazine = _x select 0; 
					holsterGunRounds = _x select 1; 
					}; 
				} foreach (magazinesAmmoFull player);	
				
				player removeWeapon holsterGun;
				
			};
			
		};
		
		};
		
		_handled = true;
	};
	
	case 47: {//V key
		if (!keys_on) exitWith {};
		if (!shift) exitWith {};
		if ((vehicle player)!=player) exitWith {};
		if (stunned or (player getVariable ["restrained",false])) exitWith {};
		[] spawn {
		if ((animationState player) != "AmovPercMstpSsurWnonDnon") then {
			player switchMove "";
			[player,"AmovPercMstpSsurWnonDnon"] remoteExec ["fnc_playerSwitchMove_remote"];
			player setVariable ["animstate","AmovPercMstpSsurWnonDnon",true];
			player setVariable ["search",true,true];
		} else {
			[player,"AmovPercMstpSsurWnonDnon_AmovPercMstpSnonWnonDnon"] remoteExec ["fnc_playerSwitchMove_remote"];
			player setVariable ["animstate","none",true];
			player setVariable ["search",false,true];
		};
		};
		
		
		_handled = true;
	};	
	
};
_handled;
