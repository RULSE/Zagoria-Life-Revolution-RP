
fnc_factories = compile preProcessfile "serverstuff\fnc\factories.sqf";
publicVariable "fnc_factories";
fnc_factoryBuy = compile preProcessfile "serverstuff\fnc\factorybuy.sqf";
publicVariable "fnc_factoryBuy";
fnc_factoryDialog = compile preProcessfile "serverstuff\fnc\factorydialog.sqf";
publicVariable "fnc_factoryDialog";
fnc_factoryWage = compile preProcessfile "serverstuff\fnc\factorywage.sqf";
publicVariable "fnc_factoryWage";
fnc_factoryWork = compile preProcessfile "serverstuff\fnc\factorywork.sqf";
publicVariable "fnc_factoryWork";
fnc_work = compile preProcessfile "serverstuff\fnc\work.sqf";
publicVariable "fnc_work";
fnc_workStop = compile preProcessfile "serverstuff\fnc\workstop.sqf";
publicVariable "fnc_workStop";
fnc_openCarshop = compile preProcessfile "serverstuff\fnc\opencarshop.sqf";
publicVariable "fnc_openCarshop";
fnc_openShop = compile preProcessfile "serverstuff\fnc\openshop.sqf";
publicVariable "fnc_openShop";
fnc_keys = compile preProcessfile "serverstuff\fnc\keys.sqf";
publicVariable "fnc_keys";
fnc_variablesLocal = compile preProcessfile "serverstuff\fnc\variables_local.sqf";
publicVariable "fnc_variablesLocal";
fnc_itemActions = compile preProcessfile "serverstuff\fnc\itemactions.sqf";
publicVariable "fnc_itemActions";
fnc_pickUpItem = compile preProcessfile "serverstuff\fnc\pickup.sqf";
publicVariable "fnc_pickUpItem";
fnc_licensesInit = compile preProcessfile "serverstuff\fnc\licenses.sqf";
publicVariable "fnc_licensesInit";
fnc_itemMine = compile preProcessfile "serverstuff\fnc\mine.sqf";
publicVariable "fnc_itemMine";
fnc_noMove = compile preProcessfile "serverstuff\fnc\nomove.sqf";
publicVariable "fnc_noMove";
fnc_itemNoUse = compile preProcessfile "serverstuff\fnc\nouse.sqf";
publicVariable "fnc_itemNoUse";
fnc_osvezh = compile preProcessfile "serverstuff\fnc\osvezh.sqf";
publicVariable "fnc_osvezh";
fnc_refuelCar = compile preProcessfile "serverstuff\fnc\refuelcar.sqf";
publicVariable "fnc_refuelCar";
fnc_buyLicense = compile preProcessfile "serverstuff\fnc\buylicense.sqf";
publicVariable "fnc_buyLicense";
fnc_clientloop = compile preProcessfile "serverstuff\fnc\clientloop.sqf";
publicVariable "fnc_clientloop";
fnc_bloodLoop = compile preProcessfile "serverstuff\fnc\blood_loop.sqf";
publicVariable "fnc_bloodLoop";
fnc_itemDrink = compile preProcessfile "serverstuff\fnc\drink.sqf";
publicVariable "fnc_itemDrink";
fnc_itemEat = compile preProcessfile "serverstuff\fnc\eat.sqf";
publicVariable "fnc_itemEat";
fnc_processItem = compile preProcessfile "serverstuff\fnc\process.sqf";
publicVariable "fnc_processItem";
fnc_death = compile preProcessfile "serverstuff\fnc\death.sqf";
publicVariable "fnc_death";
fnc_salaries = compile preProcessfile "serverstuff\fnc\salaries.sqf";
publicVariable "fnc_salaries";
fnc_jobTaxi = compile preProcessfile "serverstuff\fnc\taxi.sqf";
publicVariable "fnc_jobTaxi";
fnc_jobCourier = compile preProcessfile "serverstuff\fnc\courier.sqf";
publicVariable "fnc_jobCourier";
fnc_boarBoss = compile preProcessfile "serverstuff\fnc\boarboss.sqf";
publicVariable "fnc_boarBoss";
fnc_repairCar = compile preProcessfile "serverstuff\fnc\repaircar.sqf";
publicVariable "fnc_repairCar";
fnc_lockPick = compile preProcessfile "serverstuff\fnc\lockpick.sqf";
publicVariable "fnc_lockPick";
fnc_canisterRefuel = compile preProcessfile "serverstuff\fnc\canisterrefuel.sqf";
publicVariable "fnc_canisterRefuel";
fnc_buySlave = compile preProcessfile "serverstuff\fnc\buyslave.sqf";
publicVariable "fnc_buySlave";
fnc_drinkAlcohol = compile preProcessfile "serverstuff\fnc\drinkalcohol.sqf";
publicVariable "fnc_drinkAlcohol";
fnc_cigSmoke = compile preProcessfile "serverstuff\fnc\cigsmoke.sqf";
publicVariable "fnc_cigSmoke";
fnc_cigUnpack = compile preProcessfile "serverstuff\fnc\cigunpack.sqf";
publicVariable "fnc_cigUnpack";
fnc_itemDrugUse = compile preProcessfile "serverstuff\fnc\druguse.sqf";
publicVariable "fnc_itemDrugUse";
fnc_boarSpawn = compile preProcessfile "serverstuff\fnc\boarspawn.sqf";
publicVariable "fnc_boarSpawn";
fnc_governmentConvoy = compile preProcessfile "serverstuff\fnc\governmentconvoy.sqf";
fnc_mushrooms = compile preProcessfile "serverstuff\fnc\mushrooms.sqf";
[] spawn fnc_governmentConvoy;
[] spawn fnc_boarSpawn;
[] spawn fnc_mushrooms;
addMissionEventHandler ["HandleDisconnect",{_this call fnc_disconnect; false;}];
fnc_playerInit = {
	setViewDistance 1000;
	setTerrainGrid 50;
	//[] spawn fnc_boarSpawn;
	{
	
		_x setFace (_x getVariable ["rp_face_var","AsianHead_A3_06"]);
	
	} forEach playableUnits;
	
	waitUntil {kokoko123};
	waitUntil {!isNil "itemobjects_public"};
	
	waituntil {!isNil "fnc_keys"};
	waituntil {!isnull (finddisplay 46)};
	
	1488 cutRsc ["hud_res","PLAIN",1,false];
	1487 cutRsc ["hud_nots","PLAIN",1,false];
	itemobjects = itemobjects_public;
	
	[] spawn fnc_variablesLocal;
	[] spawn fnc_itemActions;
	[] spawn fnc_factories;
	[] spawn fnc_licensesInit;
	[] spawn fnc_briefingStuff;
	
	//itemobjects = ["Land_BarrelSand_F","Land_WoodPile_F","Land_Shovel_F","Land_Money_F", "Land_Suitcase_F", "Land_BakedBeans_F", "Land_Can_V2_F", "Land_Can_V1_F", "Land_BottlePlastic_V2_F", "Land_TacticalBacon_F", "Land_CerealsBox_F","Land_MetalBarrel_F","Land_Axe_F","Land_Axe_fire_F"];
		
	
	shift = false;
	_keys = (findDisplay 46) displayAddEventHandler ["KeyDown", "_this call fnc_keys;"];
	_keys = (findDisplay 46) displayAddEventHandler ["KeyUp", "if (_this select 1 == 42) then {shift=false};"];
	
	{
		if !(!((_x select 16) select 0) and ((str player) in cop_array)) then {
			call compile format ["
				%1 = 'Box_NATO_Ammo_F' createVehicleLocal [0,0,0];
				%1 setPosATL %2;
				%1 setDir %3;		
				clearWeaponCargo %1;
				clearMagazineCargo %1;
				clearItemCargo %1;
				%1 allowDamage false;
				%1 setVariable ['shop','%4'];
				%1 addAction ['Продать содержимое', fnc_sellCrateItems, [], 1.5, true, true, '', 'true', 3];
			",_x select 6,_x select 13,_x select 14,_x select 0];
		};
	} forEach global_shops_array;
	
	//[] spawn fnc_clientShopsInit;
	
	[] call fnc_loadPlayerData;
	
	player_init_finished = 1;
	
	[] spawn fnc_clientloop;
	[] spawn fnc_bloodLoop;
	[] spawn fnc_salaries;
	
	if !((getPlayerUID player) in playerlist) then {
		playerlist pushBack (getPlayerUID player);
		publicVariable "playerlist";
	};
	
	[] spawn {
		
		while {true} do {
			
			somebodysaveme=1;
			
			sleep 5;
			
		};
		
	};
	
	//addMissionEventHandler ["HandleDisconnect",{_this call fnc_disconnect; false;}];
	
	[] spawn {
		
		while {true} do {
		
			if (somebodysaveme>0) then {
				
				[] call fnc_savePlayerData;
				
				somebodysaveme = 0;
				
			};
			
			//sleep 0.5;
		
		};
		
	};
	
	
	{
		_x setFuelCargo 0;
		//_x addAction [format ["Заправить машину %1$/л",round(50*(1+nds_tax))], {_this spawn fnc_refuelCar;}, [_x], 1.5, true, true, "", "(vehicle player != player)",5];
	} foreach ([0,0,0] nearObjects ["Land_A_FuelStation_Feed",100000]);
	
	player addRating 9999999999;
	
	_uid = getPlayerUID player;
	
	_index = (slave_owners_array find _uid);
	if (_index>=0) then {
		
		_slaves = slaves_array select _index;
		
		_slaves = _slaves arrayIntersect _slaves;
		
		{
			
			[_x] join (group player);
			
			_args = [_x,player];
			_args remoteExec ["fnc_slavesRemote_code",2];
			
			
		} forEach _slaves;
		
	};
	
	
	[] spawn {
	
		waitUntil {!isNil "fnc_notifyMe"};
		
		private ["_scr"];
		
		notifymepls = [];
		
		while {true} do {
		
			if (count notifymepls > 0) then {
			
				_scr = (notifymepls select 0) spawn fnc_notifyMe;
				notifymepls deleteAt 0;
				waitUntil {scriptDone _scr};
			
			};
			
			sleep 0.1;
		
		};
	
	};
	
	
	[] spawn {
	
		waitUntil {!isNil "fnc_itemNotifyMe"};
		
		private ["_scr"];
		
		notifymepls_items = [];
		
		while {true} do {
		
			if (count notifymepls_items > 0) then {
			
				_scr = (notifymepls_items select 0) spawn fnc_itemNotifyMe;
				notifymepls_items deleteAt 0;
				waitUntil {scriptDone _scr};
			
			};
			
			sleep 0.1;
		
		};
	
	};
	
	waitUntil {!isNil "fnc_eachFrameTags"};
	waitUntil {!isNil "masks_array"};
	waitUntil {!isNil "fnc_checkLampsWorking"};
	
	[] spawn fnc_checkLampsWorking;
	
	tags_array = [[],[]]; //[структ.текст,idc], юниты
	tag_distance = 10;
	
	free_tags = [];
	
	for "_i" from 0 to 200 do {
	
		free_tags pushBack _i;
	
	};
	
	onEachFrame fnc_eachFrameTags;
	
	life_tfWarn = 0;
	
	_sleep = 5;
	while {true} do {
		uiSleep (_sleep * 60);
		_error = "";
		_channelError = false;
		_server = [] call TFAR_fnc_getTeamSpeakServerName;
		_channel = [] call TFAR_fnc_getTeamSpeakChannelName;
		_pluginEnabled = [] call TFAR_fnc_isTeamSpeakPluginEnabled;
		switch(true) do {
			case (!_pluginEnabled): {_error = "Включите плагин Task Force Arma 3 Radio! Зайдите в плагины TeamSpeak (Ctrl+Shift+P) и проверьте активен ли он. После этого нажмите кнопку <t color='#ffcc00'>Обновить все/Reload ALL</t>"}; //маловероятная ошибка, но важная
			case (_server!=tf_radio_server_name): {_error = format["Вы не подключены к TeamSpeak Zagoria Life Revolution [Armaworld]! Наш сервер: <t color='#ffcc00'>85.14.245.205</t><br/>Если вас автоматически не перекинет в канал <t color='#ffcc00'>%1</t>, то зайдите в плагины TeamSpeak (Ctrl+Shift+P) и нажмите кнопку <t color='#ffcc00'>Обновить все/Reload ALL</t>.","TFAR"]}; //один идиот на 100 человек
			case (_channel!=tf_radio_channel_name): {
				_error = format["Вы должны быть в специальном канале TeamSpeak для игры на сервере! Плагин будет перезагружен и вас перекинет в канал <t color='#ffcc00'>%1</t>. Если это не сработает, то зайдите в плагины (Ctrl+Shift+P) и нажмите кнопку <t color='#ffcc00'>Обновить все/Reload ALL</t>.","TFAR"];
				_channelError = true;
			}; //самая частая проблема
		};
		if (_error!="") then {
			life_tfWarn=life_tfWarn+1;
			_sleep = 5;
			//[format[" <t size='2.2' color='#ff0000' align='center'>Внимание!</t><br /><br />%1<br /><br />Это предупреждение номер %2 из 3.<br /><br />Следующая проверка через %3 минут! Исправьте ошибку или будете исключены из игры!</t>",_error,life_tfWarn,_sleep],"error"] spawn UnionClient_system_hint;
			hint parseText format[" <t size='2.2' color='#ff0000' align='center'>Внимание!</t><br /><br />%1<br /><br />Это предупреждение номер %2 из 3.<br /><br />Следующая проверка через %3 минут! Исправьте ошибку или будете исключены из игры!</t>",_error,life_tfWarn,_sleep];
			if (_channelError) then {
				["processPlayerPositionsHandler", "onEachFrame"] call BIS_fnc_removestackedEventHandler;
				uiSleep 5;
				["processPlayerPositionsHandler", "onEachFrame", "TFAR_fnc_processPlayerPositions"] call BIS_fnc_addStackedEventHandler;
			};
		} else {
			life_tfWarn = 0;
			_sleep = 15;
		};
		if (false) exitWith {};
		if (life_tfWarn > 2) exitWith {
			//[0,format["%1 был исключен с сервера из-за нарушения правила нахождения в TeamSpeak",name player]] remoteExecCall ["UnionClient_system_broadcast",RCLIENT];
			uiSleep 2;
			["TaskForce",false,false] call BIS_fnc_endMission;
		};
	};
};
publicVariable "fnc_playerInit";
