
fnc_initializeServerVars = {
	
	private ["_code","_args","_result","_varcount","_i"];
	
	//_result = ("extDB3" callExtension "0:SQL:SELECT shopclass,shopname,shopdescription,object,owner,kassa,crate,spawn,model,position,direction,spawn_position,spawn_direction,crate_position,crate_direction,buyshit From shops");
	_result = ("extDB3" callExtension "0:SQL:SELECT COUNT(*) From servervars");
	
	_varcount = (((call compile _result) select 1) select 0) select 0;
	
	//systemChat str _varcount;
	
	variables_to_save = [];
	
	for "_i" from 1 to _varcount do {
		
		private ["_object","_owners","_money","_wages","_whs"];
		
		_result = ("extDB3" callExtension format ["0:SQL:SELECT name,value From servervars WHERE id = %1",_i]);
				
		_result = ((call compile _result) select 1) select 0;
		
		missionNamespace setVariable [_result select 0, (_result select 1) select 0];
		
		variables_to_save pushBack (_result select 0);
		
		publicVariable (_result select 0);
		
	};
		
};
fnc_initializeFactories = {
	
	private ["_code","_args","_result","_faccount","_i"];
	
	//_result = ("extDB3" callExtension "0:SQL:SELECT shopclass,shopname,shopdescription,object,owner,kassa,crate,spawn,model,position,direction,spawn_position,spawn_direction,crate_position,crate_direction,buyshit From shops");
	_result = ("extDB3" callExtension "0:SQL:SELECT COUNT(*) From factories");
	
	_faccount = (((call compile _result) select 1) select 0) select 0;
	
	//factories_array
	
	factories_array = [];
	factoryclass_array = [];
	factories_array_items = [];
	
	for "_i" from 1 to _faccount do {
		
		private ["_object","_owners","_money","_wages","_whs","_products","_allowed_put"];
		
		_result = ("extDB3" callExtension format ["0:SQL:SELECT classname,name,object,price,items,crate,spawn,cond From factories WHERE id = %1",_i]);
				
		_result = ((call compile _result) select 1) select 0;
		
		_result set [2,call compile (_result select 2)];
		_result set [5,call compile (_result select 5)];
		_result set [6,call compile (_result select 6)];
		
		_products = _result select 4;
		
		//systemChat str _products;
		
		factories_array pushBack _result;
		
		_object = (_result select 2);
		
		_result = ("extDB3" callExtension format ["0:SQL:SELECT playerid,kassa,wage,whs,factoryname From factories_owners WHERE factory = '%1'",str (_result select 0)]);
				
		_result = ((call compile _result) select 1);
		
		_owners = [];
		_names = [];
		_money = [];
		_wages = [];
		_whs = [];
		
		{
			_owners pushBack (_x select 0);
			_money pushBack (_x select 1);
			_wages pushBack (_x select 2);
			_whs pushBack (_x select 3);
			_names pushBack (_x select 4);
		} forEach _result;
		
		_object setVariable ["factory_names",_names,true];
		_object setVariable ["factory_owners",_owners,true];
		_object setVariable ["factory_money",_money,true];
		_object setVariable ["factory_wages",_wages,true];
		_object setVariable ["factory_whs",_whs,true];
		_object setVariable ["allowed_put",[],true];
		
		_allowed_put = [];
		
		waitUntil {!isNil "fnc_getItemResources"};
		
		{
			private ["_res"];
			_res = _x call fnc_getItemResources;
			
			//if (isNil "_res") then {systemChat str _x};
			
			{
				if !((_x select 0) in _allowed_put) then {_allowed_put pushBack (_x select 0);};
			} forEach _res;
			
		} forEach _products;
		
		_object setVariable ["allowed_put",_allowed_put,true];
		
		//hint str _result;
		
	};
	
	publicVariable "factories_array";	
		
	{
		factoryclass_array pushBack (_x select 0);	
	} forEach factories_array;
	
	publicVariable "factoryclass_array";	
	
};
fnc_initializeShops = {
	
	private ["_code","_args","_result","_shopscount","_i"];
	
	//_result = ("extDB3" callExtension "0:SQL:SELECT shopclass,shopname,shopdescription,object,owner,kassa,crate,spawn,model,position,direction,spawn_position,spawn_direction,crate_position,crate_direction,buyshit From shops");
	_result = ("extDB3" callExtension "0:SQL:SELECT COUNT(*) From shops");
	
	_shopscount = (((call compile _result) select 1) select 0) select 0;
	
	global_shops_array = [];
	global_shops_array_classes = [];
	global_shops_array_items = [];
	
	for "_i" from 1 to _shopscount do {
		
		_result = ("extDB3" callExtension format ["0:SQL:SELECT shopclass,shopname,shopdescription,object,owner,kassa,crate,spawn,model,position,direction,spawn_position,spawn_direction,crate_position,crate_direction,buyshit,legal From shops WHERE id = %1",_i]);
		
		_result = ((call compile _result) select 1) select 0;
		
		global_shops_array pushBack _result;	
		
		//hint str global_shops_array;
		
	};
	
	publicVariable "global_shops_array";
	
		
	{
		global_shops_array_classes pushBack (_x select 0);	
	} forEach global_shops_array;
	
	publicVariable "global_shops_array_classes";	
	
	{
		private ["_arr"];
		
		_result = ("extDB3" callExtension format ["0:SQL:SELECT itemclass,amount,price,maxamount,minimalamount,license,vehinit From shops_goods WHERE shopclass = '%1'",str (_x select 0)]);
	
		_result = (call compile _result) select 1;
		
		_arr = [];
		
		{
			_arr pushBack (_x select 0);
			
		} forEach _result;
		
		_arr = [_result,_arr];
		
		global_shops_array_items pushBack _arr;
		
		call compile format ["
			%1 = 'Land_HelipadEmpty_F' createVehicle [0,0,0];
			%1 setPosATL %2;
			%1 setDir %3;		
			%1 allowDamage false;
			publicVariable '%1';
		",_x select 7,_x select 11,_x select 12];
		
		call compile format ["
			if (isNil '%1') then {
				%1 = '%2' createVehicle [0,0,0];
				%1 setPosATL %3;
				%1 setDir %4;		
				%1 allowDamage false;
				publicVariable '%1';
				%1 setVariable ['legalshop',%5 select 0, true];
			};
		",_x select 3,_x select 8,_x select 9,_x select 10,_x select 16];
		
	} forEach global_shops_array;
	
	publicVariable "global_shops_array_items";	
	
	kokoko123 = true;
	
	publicVariable "kokoko123";
	
};
fnc_initializeItems = {
	
	private ["_code","_args","_result","_itemcount"];
	
	_result = ("extDB3" callExtension "0:SQL:SELECT COUNT(*) From array_invitems");
	
	_itemcount = (((call compile _result) select 1) select 0) select 0;
	
	items_array = [];
	itemobjects_public = [];
	
	for "_i" from 1 to _itemcount do {
				
		_result = ("extDB3" callExtension format ["0:SQL:SELECT itemclass,classname,name,weight,legal,script,args,description,droppable,type,parts,trunk,wh From array_invitems WHERE id = %1",_i]);
		
		_result = ((call compile _result) select 1) select 0;
		
		items_array pushBack _result;	
		
		if ((_result select 9)=="item") then {
		
			itemobjects_public pushBack (_result select 1);
		
		};
		
	};
	
	publicVariable "items_array";	
	publicVariable "itemobjects_public";	
	
	//hint str items_array;
		
	//systemChat "ZHEZH";
	//copyToClipboard "ZHEZH";
	//copyToClipboard str items_array;
	
	items_classes = [];
	{items_classes=items_classes+[_x select 0]} foreach items_array;
	
	//copyToClipboard str items_array;
	
	publicVariable "items_classes";
	
};
fnc_clientShopsInit = {
	
	//waitUntil {!isNil "player_init_finished"};
	
	
		/*player addAction ["Эвакуировать", {(_this select 3) spawn fnc_impoundVehicle}, _x, 1.5, true, true, "",
		format ["
		_cond = false;
		if (player distance %1 < 5) then {_cond = true};
		_cond and (_target == player)
		", _x],-1
		];*/
		
	if ((str player) in cop_array) then {
	
		{
	
			player addAction ["Допросить", {(_this select 3) spawn fnc_copDoprosShop}, _x, 1.5, true, true, "",
			format ["
			_cond = false;
			if (player distance %1 < 5) then {_cond = true};
			_cond and (_target == player)
			", _x],-1
			];
		
		} forEach ["psilo_buyer","whale_buyer","drug_buyer_1","samogon_buyer"];
	
			
	};
	
	{
		if !(!((_x select 16) select 0) and ((str player) in cop_array)) then {
			if ((_x select 3) in gangareas_array) then {
				
				player addAction [format ["%1", _x select 1], {_this spawn fnc_openShop}, _x select 0, 1.5, true, true, "",
				format ["
				_cond = false;
				if ((player distance %1 < 5) and (((%1 getVariable ['flagowner','none'])!='none') and ((%1 getVariable ['flagowner','none'])==(call fnc_getMyGang)))) then {_cond = true};
				_cond and (_target == player)
				", (_x select 3)],-1
				];
				
				/*player addAction ["Наркотрафик", {_this spawn fnc_openNarcoSklad}, _x select 0, 1.5, true, true, "",
				format ["
				_cond = false;
				if ((player distance %1 < 5) and (((%1 getVariable ['flagowner','none'])!='none') and ((%1 getVariable ['flagowner','none'])==(call fnc_getMyGang)))) then {_cond = true};
				_cond and (_target == player)
				", (_x select 3)],-1
				];*/
			
			} else {
				player addAction [format ["%1", _x select 1], {_this spawn fnc_openShop}, _x select 0, 1.5, true, true, "",
				format ["
				_cond = false;
				if (player distance %1 < 3) then {_cond = true};
				_cond and (_target == player)
				", (_x select 3)],-1
				];
				
			};
		};
		
	} forEach global_shops_array;
	
	waitUntil {!isNil "factories_array"};
	
	if ((str player) in cop_array) then {
		
		{
			player addAction ["Допросить потерпевшего", {(_this select 3) spawn fnc_askRobbed}, _x, 1.5, true, true, "",
			format ["
			_cond = false;
			if ((player distance %1 < 5) and ((count (%1 getVariable ['gsrobbers',[]])) > 0)) then {_cond = true};
			_cond
			", _x],-1
			];
		} foreach gs_array;
	};
	
	if !((str player) in cop_array) then {
	
	
	
		
		{
			player addAction ["Нейтрализовать флаг", {(_this select 3) spawn fnc_gangAreaNeutralize;}, [_x], 1.5, true, true, "",
			format ["
			_cond = false;
			if (player distance %1 < 8) then {_cond = true};
			if ((call fnc_getMyGang) == 'none') then {_cond = false};
			if ((call fnc_getMyGang) == (gangareas_owners select %2)) then {_cond = false};
			if ((%1 getVariable ['flagowner','none']) in [(call fnc_getMyGang),'none']) then {_cond = false};
			_cond
			", _x,_forEachIndex],-1
			];
		} foreach gangareas_array;
		
		{
			player addAction ["Захватить флаг", {(_this select 3) spawn fnc_gangAreaCapture;}, [_x], 1.5, true, true, "",
			format ["
			_cond = false;
			if (player distance %1 < 8) then {_cond = true};
			if ((call fnc_getMyGang) == 'none') then {_cond = false};
			if !((%1 getVariable ['flagowner','none']) in ['none',(call fnc_getMyGang)]) then {_cond = false};
			if !(((gangareas_owners select %2)=='none') or ((call fnc_getMyGang) == (gangareas_owners select %2))) then {_cond = false};
			if (((flagAnimationPhase %1)==1) and ((%1 getVariable ['flagowner','none']) == (call fnc_getMyGang))) then {_cond = false};
			_cond
			", _x,_forEachIndex],-1
			];
		} foreach gangareas_array;
		
		//if (flagAnimationPhase %1) 
		
		{
			player addAction ["Ограбить заправку", {(_this select 3) spawn fnc_robGasStation}, _x, 1.5, true, true, "",
			format ["
			_cond = false;
			if (player distance %1 < 3) then {_cond = true};
			_cond
			", _x],-1
			];
		} foreach gs_array;
		
		{
			player addAction [format ["%1", _x select 1], {_this spawn fnc_factoryDialog}, _x select 0, 1.5, true, true, "",
			format ["
			_cond = false;
			if ((player distance %1 < 5) and ((getPlayerUID player) in (%1 getVariable ['factory_owners',[]]))) then {_cond = true};
			_cond and (_target == player)
			", _x select 2, _x select 0],-1
			];
		} foreach factories_array;
		{
			player addAction [format ["Купить %1 за %2 CRK", _x select 1, [_x select 3] call fnc_numberToText], {_this spawn fnc_factoryBuy}, [_x select 0, _x select 3], 1.5, true, true, "",
			format ["
			_cond = false;
			if ((player distance %1 < 5) and !((getPlayerUID player) in (%1 getVariable ['factory_owners',[]]))) then {_cond = true};
			_cond and (_target == player)
			", _x select 2, _x select 0],-1
			];
		} foreach factories_array;
		{
			player addAction ["Касса работодателя", {_this spawn fnc_factoryWage}, _x select 0, 1.5, true, true, "",
			format ["
			_cond = false;
			if ((player distance %1 < 5) and ((getPlayerUID player) in (%1 getVariable ['factory_owners',[]]))) then {_cond = true};
			_cond and (_target == player)
			", _x select 2, _x select 0],-1
			];
		} foreach factories_array;
		{
			player addAction ["Работать", {_this spawn fnc_factoryWork}, _x select 0, 1.5, true, true, "",
			format ["
			_cond = false;
			if (player distance %1 < 5) then {_cond = true};
			_cond and (_target == player)
			", _x select 2],-1
			];
		} foreach factories_array;
		
		waitUntil {!isNil "licenses_array"};
		
		{
			player addAction [format ["%1 %2 CRK", _x select 1, [_x select 3] call fnc_numberToText], {_this spawn fnc_buyLicense}, [_x select 0, _x select 3, _x select 4], 1.5, true, true, "", 
			format ["
			_cond = false;
			{if (player distance _x < 5) then {_cond = true};} foreach %1;
			if ('%2' call fnc_playerHasLicense) then {_cond = false;}; 
			_cond and (_target == player)
			", _x select 2, _x select 0],-1
			];
		} foreach licenses_array;
		
		{
			
			//["iron_ingot",cocaine,4000,"cocaine"]
						
			player addAction [format ["Произвести %1 за %2 CRK", (_x select 0) call fnc_getItemName, [_x select 2] call fnc_numberToText], {_this spawn fnc_processItem}, [_x select 0, _x select 3, _x select 2], 1.5, true, true, "", 
			format ["
			_cond = false;
			{
				if (player distance _x < 5) then {_cond = true};
				if (_cond and ((str _x) in gangareas_array) and (((_x getVariable ['flagowner','none'])=='none') or ((_x getVariable ['flagowner','none'])!=(call fnc_getMyGang)))) then {				
					_cond = false;				
				};
			} foreach %1;
			_cond and (_target == player)
			", _x select 1],-1
			];
		} forEach processing_array;
		
		
		player addAction ["Научишь химичить?", {_this spawn fnc_samogonTeachMe}, [], 1.5, true, true, "", 
		format ["
		_cond = false;
		if (player distance %1 < 5) then {_cond = true;};
		if ('samogon' in licenses_illegal) then {_cond = false;};
		_cond and (_target == player)
		", samogon],-1
		];
		
		
		player addAction ["Собрать грибы", {_this spawn fnc_gribyPickup}, [], 1.5, true, true, "", 
		format ["
		_cond = false;
		if (count (nearestObjects [getpos player, ['Baseball'], 2]) < 1) then {
			_cond = false;
		} else {
			if (((nearestObjects [getpos player, ['Baseball'], 2]) select 0) getVariable ['grib',0] > 0) then {_cond = true;};
		};
		if ((vehicle player) != player) then {_cond = false;};
		_cond and (_target == player)
		", samogon],-1
		];
		
		//action73 = _role addaction ["Работа таксиста","taxi.sqf", ["getajob_taxi"],1,false,true,"","(player distance workplace_getjobflag_1 <= 5 or player distance workplace_getjobflag_2 <= 5 or player distance workplace_getjobflag_3 <= 5) and iscivCLR"];		
	//action74 = _role addaction ["Завершить работу таксиста","taxi.sqf", ["canceljob_taxi"],1,false,true,"","(player distance workplace_getjobflag_1 <= 5 or player distance workplace_getjobflag_2 <= 5 or player distance workplace_getjobflag_3 <= 5) and iscivCLR and workplacejob_taxi_active"];	
		{
			//[classname,object,income for workers,radius,income for owners,ownership cost]
			
			player addAction [format ["Купить предприятие за %1 CRK", [_x select 5] call fnc_numberToText], {(_this select 3) spawn fnc_buyWorkplace}, [_x select 0,_x select 5], 1.5, true, true, "", 
			format ["
			_cond = false;
			if (player distance %1 < 5) then {_cond = true};
			if ('%2' in my_workplaces) then {_cond = false};
			_cond and (_target == player)
			", _x select 1, _x select 0],-1
			];
			
		} forEach workplaces_array;
		{
			player addAction ["Работа таксиста", {(_this select 3) spawn fnc_jobTaxi}, ["start"], 1.5, true, true, "", 
			format ["
			_cond = false;
			if (player distance %1 < 5) then {_cond = true};
			if (taxijob) then {_cond = false};
			_cond and (_target == player)
			", _x select 1],-1
			];
			
		} forEach workplaces_array;
		
		{
			player addAction ["Завершить работу таксиста", {(_this select 3) spawn fnc_jobTaxi}, ["finish"], 1.5, true, true, "", 
			format ["
			_cond = false;
			if (player distance %1 < 5) then {_cond = true};
			if !(taxijob) then {_cond = false};
			_cond and (_target == player)
			", _x select 1],-1
			];
			
		} forEach workplaces_array;
		{
			player addAction ["Работа курьера", {(_this select 3) spawn fnc_jobCourier}, ["start"], 1.5, true, true, "", 
			format ["
			_cond = false;
			if (player distance %1 < 5) then {_cond = true};
			if (courierjob) then {_cond = false};
			_cond and (_target == player)
			", _x select 1],-1
			];
			
		} forEach workplaces_array;
		
		{
			player addAction ["Завершить работу курьера", {(_this select 3) spawn fnc_jobCourier}, ["finish"], 1.5, true, true, "", 
			format ["
			_cond = false;
			if (player distance %1 < 5) then {_cond = true};
			if !(courierjob) then {_cond = false};
			_cond and (_target == player)
			", _x select 1],-1
			];
			
		} forEach workplaces_array;
	
	};
		
	{
		player addAction ["Операции по вкладам", {[] spawn fnc_openATM}, [], 1.5, true, true, "", 
		format ["
		_cond = false;
		if (player distance %1 < 5) then {_cond = true};
		_cond and (_target == player)
		", _x],-1
		];		
		
		player addAction ["Купить страховку 5000 CRK", {(_this select 3) spawn fnc_buyBankInsurance}, [5000], 1.5, true, true, "", 
		format ["
		_cond = false;
		if (player distance %1 < 5) then {_cond = true};
		_cond and (_target == player)
		", _x],-1
		];		
		
	} forEach [banker_1];
	
	if !((str player) in cop_array) then {
			
		{
			player addAction ["Ограбить сейф", {(_this select 3) spawn fnc_robBankSafe}, [_x,"rob"], 1.5, true, true, "", 
			format ["
			_cond = false;
			if (player distance %1 < 5) then {_cond = true};
			_cond and (_target == player)
			", _x],-1
			];	
					
		} forEach bank_safe_array;
	
	};
	
	{
		player addAction ["Отремонтировать трансформатор (10'000 CRK)", {(_this select 3) spawn fnc_repairTransformer}, [_x,10000], 1.5, true, true, "", 
		format ["
		_cond = false;
		if (player distance [(getPos %1 select 0), (getPos %1 select 1), 0] < 8) then {_cond = true};
		if (alive %1) then {_cond = false};
		_cond and (_target == player)
		", _x],-1
		];	
	} forEach [power_1,power_2,power_3];
	
	if !((str player) in cop_array) then {
			
		{
			player addAction ["Вступить в ИГ", {(_this select 3) spawn fnc_becomeISMember}, [], 1.5, true, true, "", 
			format ["
			_cond = false;
			if (player distance %1 < 3) then {_cond = true};
			if ('ig_lic' in licenses_illegal) then {_cond = false};
			_cond and (_target == player)
			", _x],-1
			];	
					
		} forEach [ig_hq];
			
		{
			player addAction ["Покинуть ИГ", {(_this select 3) spawn fnc_leaveIS}, [], 1.5, true, true, "", 
			format ["
			_cond = false;
			if (player distance %1 < 3) then {_cond = true};
			if !('ig_lic' in licenses_illegal) then {_cond = false};
			_cond and (_target == player)
			", _x],-1
			];	
					
		} forEach [ig_hq];
			
		{
			player addAction ["Вступить в НаПа", {(_this select 3) spawn fnc_becomeNapaMember}, [], 1.5, true, true, "", 
			format ["
			_cond = false;
			if (player distance %1 < 3) then {_cond = true};
			if ('napa' in licenses_illegal) then {_cond = false};
			_cond and (_target == player)
			", _x],-1
			];	
					
		} forEach [terrorist_hq_1];
			
		{
			player addAction ["Покинуть НаПа", {(_this select 3) spawn fnc_leaveNapa}, [], 1.5, true, true, "", 
			format ["
			_cond = false;
			if (player distance %1 < 3) then {_cond = true};
			if !('napa' in licenses_illegal) then {_cond = false};
			_cond and (_target == player)
			", _x],-1
			];	
					
		} forEach [terrorist_hq_1];
			
		{
			player addAction ["Уничтожить наркотики", {(_this select 3) spawn fnc_destroyDrugsNapa}, [], 1.5, true, true, "", 
			format ["
			_cond = false;
			if (player distance %1 < 3) then {_cond = true};
			if !('napa' in licenses_illegal) then {_cond = false};
			_cond and (_target == player)
			", _x],-1
			];	
					
		} forEach [terrorist_missions_1];
	
	};
	
	
	
	//player addAction ["Биржа труда", "joblist.sqf", [], 1.5, true, true, "", "player distance birzha_truda < 5",-1];
	player addAction ["Набрать бочку воды", {[] spawn fnc_collectWater;}, [], 1.5, true, true, "", "(surfaceIsWater getpos player) and !(collectingwater) and (_target == player)",-1];
	
	//player addAction ["Перевернуть транспорт", {[cursorTarget] call fnc_unflipVehicle;}, [], 1.5, true, true, "", "(cursorTarget isKindOf 'AllVehicles') and (vectorUp cursorTarget vectorCos surfaceNormal getPos cursorTarget < 0.45) and (player distance cursorTarget < 5) and (alive player) and (alive cursorTarget)",-1];
	
	player addAction ["Перевернуть транспорт", {[(nearestobjects [getpos player, ['Air', 'Ship', 'LandVehicle'], 3]) select 0] call fnc_unflipVehicle;}, [], 1.5, true, true, "", 
	format ["
	_cond = false;
	if (count (nearestobjects [getpos player, ['Air', 'Ship', 'LandVehicle'], 3]) > 0) then {_cond=true;};
	if !(vectorUp ((nearestobjects [getpos player, ['Air', 'Ship', 'LandVehicle'], 3]) select 0) vectorCos surfaceNormal getPos ((nearestobjects [getpos player, ['Air', 'Ship', 'LandVehicle'], 3]) select 0) < 0.45) then {_cond=false;};
	if ((vehicle player) != player) then {_cond=false;};
	_cond
	", 12],-1
	];
	
	
	//player addAction ["Поставить транспорт в гараж", "puttogarage.sqf", [], 1.5, true, true, "", "(vehicle player != player) and (player distance garage1 < 10) and (_target == player)",-1];
	
	if !((str player) in cop_array) then {
	
		{
			
			player addAction ["Поставить транспорт в гараж", {(_this select 3) spawn fnc_storeVehicle}, [_x], 1.5, true, true, "", 
			format ["
			_cond = false;
			if (((vehicle player) != player) and ((vehicle player) distance %1 < 15)) then {_cond = true};
			_cond
			", _x],-1
			];
			
			player addAction ["Открыть гараж", {(_this select 3) spawn fnc_openGarage}, [_x], 1.5, true, true, "", 
			format ["
			_cond = false;
			if (((vehicle player) == player) and (player distance %1 < 15)) then {_cond = true};
			_cond
			", _x],-1
			];
		
		} forEach garages_array_classes;
		
		{			
			player addAction [("<t color=""#FF0000"">" + ("СТАТЬ ВЛАДЕЛЬЦЕМ ЗА 50000 CRK") + "</t>"), {(_this select 3) spawn fnc_becomeVehOwner}, [], 1.5, true, true, "", 
			format ["
			_cond = false;
			if (((vehicle player) != player) and ((vehicle player) distance %1 < 15)) then {_cond = true};
			_cond
			", _x],-1
			];			
			
		} forEach ["perebivka_1"];
		
		{
			player addAction [("<t color=""#00FF00"">" + ("Перекраска транспорта") + "</t>"), {(_this select 3) spawn fnc_paintJobMenu}, [], 1.5, true, true, "", 
			format ["
			_cond = false;
			if (((vehicle player) != player) and ((vehicle player) distance %1 < 15)) then {_cond = true};
			_cond
			", _x],-1
			];			
			
		} forEach ["paintjob_1","paintjob_2","paintjob_3","paintjob_4","paintjob_5","paintjob_6"];
		
		
		player addAction ["Купить раба за 50000 CRK", {(_this select 3) spawn fnc_buySlave}, [50000], 1.5, true, true, "", 
		format ["
		_cond = false;
		if (((vehicle player) == player) and (player distance slaves_buy < 15)) then {_cond = true};
		_cond
		", 12],-1
		];
		
		//action81 = _role addaction ["Вытащить из машины","noscript.sqf",'(nearestobjects [getpos player, ["Air", "Ship", "LandVehicle"], 3] select 0) execVM "pullout.sqf";',1,true,true,"",'_vcl = (nearestobjects [getpos player, ["Air", "Ship", "LandVehicle"], 3] select 0);player distance _vcl < 35 and count (crew _vcl) > 0 and _vcl in INV_ServerVclArray and (call INV_isArmed)'];
			
		//player addaction [("<t color=""#FF0000"">" + ("Взять в Заложники") + "</t>"),"hostage.sqf","attach_civ",1,false,true,"",'if(count (nearestobjects [getpos player, ["man"], 5]) > 1) then {((nearestobjects [getpos player, ["man"], 5] select 1) call ISSE_IsVictim) and iscivclr}'];
		//player addaction [("<t color=""#0000FF"">" + ("Отпустить Заложника") + "</t>"),"hostage.sqf","detach",1,false,true,"",'(((player getVariable "HostageStatus") select 0) == 2) and iscivclr'];
		//player addaction ["Посадить в Машину","noscript.sqf","if ((((player getvariable ""HostageStatus"") select 2) == nil) or ((nearestobjects [getpos player, [""LandVehicle""], 5]) select 0 == nil)) exitWith {hint ""Что-то пошло не так.""}; [((player getvariable ""HostageStatus"") select 2),(nearestobjects [getpos player, [""LandVehicle""], 5]) select 0] execVM ""gettoveh.sqf""",6,true,true,"","(((player getVariable ""HostageStatus"") select 0) == 2) and (count (nearestobjects [getpos player, [""LandVehicle""], 5])  >= 1)"];
		/*
action120 = _role addaction [("<t color=""#FF0000"">" + ("Взять в Заложники") + "</t>"),"hostage.sqf","attach_civ",1,false,true,"",'if(count (nearestobjects [getpos player, ["man"], 5]) > 1) then {((nearestobjects [getpos player, ["man"], 5] select 1) call ISSE_IsVictim) and iscivclr}'];
action121 = _role addaction [("<t color=""#0000FF"">" + ("Отпустить Заложника") + "</t>"),"hostage.sqf","detach",1,false,true,"",'(((player getVariable "HostageStatus") select 0) == 2) and iscivclr'];
action122 = _role addaction ["Посадить в Машину","noscript.sqf","if ((((player getvariable ""HostageStatus"") select 2) == nil) or ((nearestobjects [getpos player, [""LandVehicle""], 5]) select 0 == nil)) exitWith {hint ""Что-то пошло не так.""}; [((player getvariable ""HostageStatus"") select 2),(nearestobjects [getpos player, [""LandVehicle""], 5]) select 0] execVM ""gettoveh.sqf""",6,true,true,"","(((player getVariable ""HostageStatus"") select 0) == 2) and (count (nearestobjects [getpos player, [""LandVehicle""], 5])  >= 1)"];
action123 = _role addaction [("<t color=""#0000FF"">" + ("Взять Подозреваемого") + "</t>"),"hostage.sqf","attach_cop",1,false,true,"",'if(count (nearestobjects [getpos player, ["man"], 5]) > 1) then {((nearestobjects [getpos player, ["man"], 5] select 1) call ISSE_IsVictim) and iscopCLR}'];
action124 = _role addaction [("<t color=""#0000FF"">" + ("Отпустить Подозреваемого") + "</t>"),"hostage.sqf","detach",1,false,true,"",'(((player getVariable "HostageStatus") select 0) == 2) and iscopCLR'];
*/
	
	};
	
		player addAction ["Прекратить работу", {working = false}, [], 1.5, true, true, "", 
		format ["
		working
		", 12],-1
		];
	
		player addAction [("<t color=""#FF0000"">" + ("Эскортировать") + "</t>"), {(_this select 3) spawn fnc_takeHostage;}, [], 1.5, true, true, "", 
		format ["
		_cond = false;
		if (count (nearestobjects [getpos player, ['man'], 5]) > 1) then {if (((nearestobjects [getpos player, ['man'], 5] select 1) getVariable ['search',false]) or ((nearestobjects [getpos player, ['man'], 5] select 1) getVariable ['restrained',false])) then {_cond=true};};
		if ((player getVariable ['search',false]) or (player getVariable ['restrained',false])) then {_cond = false;};
		if ((player getVariable ['hostaged',dummy])!=dummy) then {_cond = false;};
		_cond
		", 12],-1
		];
		
		player addAction [("<t color=""#0000FF"">" + ("Отпустить") + "</t>"), {detach (player getVariable ["hostaged",dummy]); (player getVariable ["hostaged",dummy]) setVariable ["hostager",dummy,true]; player setVariable ["hostaged",dummy,true];}, [], 1.5, true, true, "", 
		format ["
		_cond = false;
		if ((player getVariable ['hostaged',dummy])!=dummy) then {_cond = true;};
		_cond
		", 12],-1
		];
		
		player addAction [("<t color=""#00FF00"">" + ("Посадить в машину") + "</t>"), {[] spawn fnc_putHostageIntoVeh;}, [], 1.5, true, true, "", 
		format ["
		_cond = false;
		if (count (nearestobjects [getpos player, ['LandVehicle'], 5]) > 0) then {if ((locked ((nearestobjects [getpos player, ['LandVehicle'], 5]) select 0))<2) then {_cond=true;};};
		if ((player getVariable ['hostaged',dummy])==dummy) then {_cond = false;};
		_cond
		", 12],-1
		];
		
		player addAction ["Вытащить из транспорта", {[] spawn fnc_pullOut;}, [], 1.5, true, true, "", 
		format ["
		_cond = false;
		if (count (nearestobjects [getpos player, ['Air', 'Ship', 'LandVehicle'], 3]) > 0) then {if ((count crew (nearestobjects ([getpos player, ['Air', 'Ship', 'LandVehicle'], 3]) select 0))>0) then {_cond=true;};};
		if ((vehicle player) != player) then {_cond=false;};
		_cond
		", 12],-1
		];
		
	if ((str player) in cop_array) then {
				
		player addAction [("<t color=""#FFFF00"">" + ("Осмотреть взрывное устройство") + "</t>"), {[] spawn fnc_examineCarbomb;}, [], 1.5, true, true, "", 
		format ["
		_cond = false;
		if ((cursorTarget isKindOf 'LandVehicle') and ((player distance cursorTarget) <= 3) and ((vehicle player) == player)) then {if ('police' in (cursorTarget getVariable ['spottedcarbomb',[]])) then {_cond=true;};};
		if (((vehicle player) isKindOf 'LandVehicle') and ((vehicle player) != player)) then {if ('police' in ((vehicle player) getVariable ['spottedcarbomb',[]])) then {_cond=true;};};
		_cond
		", 12],-1
		];		
				
		player addAction [("<t color=""#FF0000"">" + ("Попытаться обезвредить") + "</t>"), {[] spawn fnc_defuseCarbomb;}, [], 1.5, true, true, "", 
		format ["
		_cond = false;
		if ((cursorTarget isKindOf 'LandVehicle') and ((player distance cursorTarget) <= 3) and ((vehicle player) == player)) then {if ('police' in (cursorTarget getVariable ['spottedcarbomb',[]])) then {_cond=true;};};
		if (((vehicle player) isKindOf 'LandVehicle') and ((vehicle player) != player)) then {if ('police' in ((vehicle player) getVariable ['spottedcarbomb',[]])) then {_cond=true;};};
		_cond
		", 12],-1
		];		
	} else {
				
		player addAction [("<t color=""#FFFF00"">" + ("Осмотреть взрывное устройство") + "</t>"), {[] spawn fnc_examineCarbomb;}, [], 1.5, true, true, "", 
		format ["
		_cond = false;
		if ((cursorTarget isKindOf 'LandVehicle') and ((player distance cursorTarget) <= 3) and ((vehicle player) == player)) then {if ((getPlayerUID player) in (cursorTarget getVariable ['spottedcarbomb',[]])) then {_cond=true;};};
		if (((vehicle player) isKindOf 'LandVehicle') and ((vehicle player) != player)) then {if ((getPlayerUID player) in ((vehicle player) getVariable ['spottedcarbomb',[]])) then {_cond=true;};};
		_cond
		", 12],-1
		];
				
		player addAction [("<t color=""#FF0000"">" + ("Попытаться обезвредить") + "</t>"), {[] spawn fnc_defuseCarbomb;}, [], 1.5, true, true, "", 
		format ["
		_cond = false;
		if ((cursorTarget isKindOf 'LandVehicle') and ((player distance cursorTarget) <= 3) and ((vehicle player) == player)) then {if ((getPlayerUID player) in (cursorTarget getVariable ['spottedcarbomb',[]])) then {_cond=true;};};
		if (((vehicle player) isKindOf 'LandVehicle') and ((vehicle player) != player)) then {if ((getPlayerUID player) in ((vehicle player) getVariable ['spottedcarbomb',[]])) then {_cond=true;};};
		_cond
		", 12],-1
		];		
		
	};
	
	player addAction [("<t color=""#FFFF00"">" + ("Деактивировать постановщик помех") + "</t>"), {[] spawn fnc_takeJammer;}, [], 1.5, true, true, "", 
	format ["
	_cond = false;
	if ((cursorTarget isKindOf 'Land_SatellitePhone_F') and ((player distance cursorTarget) <= 2) and ((vehicle player) == player) and ((cursorTarget getVariable ['jamming',0])==1)) then {_cond=true;};
	_cond
	", 12],-1
	];	
	
	player addAction [("<t color=""#FFFF00"">" + ("Осмотреть взрывное устройство") + "</t>"), {[] spawn fnc_examineSatchelcharge;}, [], 1.5, true, true, "", 
	format ["
	_cond = false;
	if ((cursorObject isKindOf 'SatchelCharge_Remote_Ammo') and ((player distance cursorObject) <= 2) and ((vehicle player) == player)) then {_cond=true;};
	_cond
	", 12],-1
	];	
	
	player addAction [("<t color=""#FF0000"">" + ("Попытаться обезвредить") + "</t>"), {[] spawn fnc_defuseSatchelcharge;}, [], 1.5, true, true, "", 
	format ["
	_cond = false;
	if ((cursorObject isKindOf 'SatchelCharge_Remote_Ammo') and ((player distance cursorObject) <= 2) and ((vehicle player) == player)) then {_cond=true;};
	_cond
	", 12],-1
	];	
	
	player addAction ["Проголосовать", {[] spawn fnc_openElectionsMenu;}, [], 1.5, true, true, "", "(player distance mayor_guy)<5",-1];
	player addAction ["Меню губернатора", {[] spawn fnc_openGovMenu;}, [], 1.5, true, true, "", "((player distance mayor_guy)<5) and ((getPlayerUID player)==current_governor)",-1];
	
	player addAction [format ["<t color=""#0000FF"">Заправить машину %1 CRK/л</t>",round(50*(1+nds_tax))], {_this spawn fnc_refuelCar;}, [], 1.5, true, true, "", "(((vehicle player) distance ((getPos (vehicle player)) nearestObject 'Land_A_FuelStation_Feed'))<10) and ((vehicle player) != player) and ((driver (vehicle player)) == player)",-1];
	
	if !((str player) in cop_array) then {
		
		player addAction ["Подготовить к производству героина", {_lab = (nearestObjects [player, ['Land_tent_east'], 5]); if (count _lab == 0) exitWith {false}; _lab = _lab select 0; _lab setVariable ["labtype","heroin",true];}, [], 1.5, true, true, "", "_lab = (nearestObjects [player, ['Land_tent_east'], 5]); if (count _lab == 0) exitWith {false}; _lab = _lab select 0; if ((_lab getVariable ['labowner','none']) == 'none') exitWith {false};  if ((_lab getVariable ['labtype','none']) != 'none') exitWith {false}; if ((_lab getVariable ['labowner','none'])==(getPlayerUID player)) then {true}",-1];
		player addAction ["Подготовить к производству марихуаны", {_lab = (nearestObjects [player, ['Land_tent_east'], 5]); if (count _lab == 0) exitWith {false}; _lab = _lab select 0; _lab setVariable ["labtype","mari",true];}, [], 1.5, true, true, "", "_lab = (nearestObjects [player, ['Land_tent_east'], 5]); if (count _lab == 0) exitWith {false}; _lab = _lab select 0; if ((_lab getVariable ['labowner','none']) == 'none') exitWith {false};  if ((_lab getVariable ['labtype','none']) != 'none') exitWith {false}; if ((_lab getVariable ['labowner','none'])==(getPlayerUID player)) then {true}",-1];
		player addAction ["Подготовить к производству амфетамина", {_lab = (nearestObjects [player, ['Land_tent_east'], 5]); if (count _lab == 0) exitWith {false}; _lab = _lab select 0; _lab setVariable ["labtype","amphetamine",true];}, [], 1.5, true, true, "", "_lab = (nearestObjects [player, ['Land_tent_east'], 5]); if (count _lab == 0) exitWith {false}; _lab = _lab select 0; if ((_lab getVariable ['labowner','none']) == 'none') exitWith {false};  if ((_lab getVariable ['labtype','none']) != 'none') exitWith {false}; if ((_lab getVariable ['labowner','none'])==(getPlayerUID player)) then {true}",-1];
		player addAction ["Подготовить к производству МДМА", {_lab = (nearestObjects [player, ['Land_tent_east'], 5]); if (count _lab == 0) exitWith {false}; _lab = _lab select 0; _lab setVariable ["labtype","mdma",true];}, [], 1.5, true, true, "", "_lab = (nearestObjects [player, ['Land_tent_east'], 5]); if (count _lab == 0) exitWith {false}; _lab = _lab select 0; if ((_lab getVariable ['labowner','none']) == 'none') exitWith {false};  if ((_lab getVariable ['labtype','none']) != 'none') exitWith {false}; if ((_lab getVariable ['labowner','none'])==(getPlayerUID player)) then {true}",-1];
		player addAction ["Подготовить к производству ЛСД", {_lab = (nearestObjects [player, ['Land_tent_east'], 5]); if (count _lab == 0) exitWith {false}; _lab = _lab select 0; _lab setVariable ["labtype","lsd",true];}, [], 1.5, true, true, "", "_lab = (nearestObjects [player, ['Land_tent_east'], 5]); if (count _lab == 0) exitWith {false}; _lab = _lab select 0; if ((_lab getVariable ['labowner','none']) == 'none') exitWith {false};  if ((_lab getVariable ['labtype','none']) != 'none') exitWith {false}; if ((_lab getVariable ['labowner','none'])==(getPlayerUID player)) then {true}",-1];
				
		player addAction ["Производство героина", {_this spawn fnc_processItem}, ["heroin", "none", 0], 1.5, true, true, "", "_lab = (nearestObjects [player, ['Land_tent_east'], 5]); if (count _lab == 0) exitWith {false}; _lab = _lab select 0; if ((_lab getVariable ['labowner','none']) == 'none') exitWith {false};  if ((_lab getVariable ['labtype','none']) != 'heroin') exitWith {false}; if ((_lab getVariable ['labowner','none']) == (getPlayerUID player)) then {true}",-1];
		player addAction ["Производство марихуаны", {_this spawn fnc_processItem}, ["mari", "none", 0], 1.5, true, true, "", "_lab = (nearestObjects [player, ['Land_tent_east'], 5]); if (count _lab == 0) exitWith {false}; _lab = _lab select 0; if ((_lab getVariable ['labowner','none']) == 'none') exitWith {false};  if ((_lab getVariable ['labtype','none']) != 'mari') exitWith {false}; if ((_lab getVariable ['labowner','none']) == (getPlayerUID player)) then {true}",-1];
		player addAction ["Производство амфетамина", {_this spawn fnc_processItem}, ["amphetamine", "none", 0], 1.5, true, true, "", "_lab = (nearestObjects [player, ['Land_tent_east'], 5]); if (count _lab == 0) exitWith {false}; _lab = _lab select 0; if ((_lab getVariable ['labowner','none']) == 'none') exitWith {false};  if ((_lab getVariable ['labtype','none']) != 'amphetamine') exitWith {false}; if ((_lab getVariable ['labowner','none']) == (getPlayerUID player)) then {true}",-1];
		player addAction ["Производство МДМА", {_this spawn fnc_processItem}, ["mdma", "none", 0], 1.5, true, true, "", "_lab = (nearestObjects [player, ['Land_tent_east'], 5]); if (count _lab == 0) exitWith {false}; _lab = _lab select 0; if ((_lab getVariable ['labowner','none']) == 'none') exitWith {false};  if ((_lab getVariable ['labtype','none']) != 'mdma') exitWith {false}; if ((_lab getVariable ['labowner','none']) == (getPlayerUID player)) then {true}",-1];
		player addAction ["Производство ЛСД", {_this spawn fnc_processItem}, ["lsd", "none", 0], 1.5, true, true, "", "_lab = (nearestObjects [player, ['Land_tent_east'], 5]); if (count _lab == 0) exitWith {false}; _lab = _lab select 0; if ((_lab getVariable ['labowner','none']) == 'none') exitWith {false};  if ((_lab getVariable ['labtype','none']) != 'lsd') exitWith {false}; if ((_lab getVariable ['labowner','none']) == (getPlayerUID player)) then {true}",-1];
			
		player addAction ["Уничтожить лабораторию", {[] spawn fnc_destroyDrugLab;}, [], 1.5, true, true, "", "_lab = (nearestObjects [player, ['Land_tent_east'], 5]); if (count _lab == 0) exitWith {false}; _lab = _lab select 0; if ((_lab getVariable ['labowner','none']) == (getPlayerUID player)) then {true}",-1];
		
	} else {
		
		player addAction ["Уничтожить лабораторию", {[] spawn fnc_destroyDrugLab;}, [], 1.5, true, true, "", "_lab = (nearestObjects [player, ['Land_tent_east'], 5]); if (count _lab == 0) exitWith {false}; _lab = _lab select 0; if ((_lab getVariable ['labowner','none']) != 'none') then {true}",-1];
		
	};
	
	player addAction ["Принять суннизм", {[] spawn fnc_becomeSunni;}, [], 1.5, true, true, "", "((player distance sunni_man) < 5) and ((vehicle player)==player) and (religion!='sunni')",-1];
	player addAction ["Принять православие", {[] spawn fnc_becomeOrthodox;}, [], 1.5, true, true, "", "((player distance orthodox_man) < 5) and ((vehicle player)==player) and (religion!='orthodox')",-1];
	
	
	player addAction ["Помолиться", {[] spawn fnc_prayInTemple;}, [], 1.5, true, true, "", "((player distance orthodox_man) < 5) and ((vehicle player)==player) and (religion=='orthodox')",-1];
	player addAction ["Помолиться", {[] spawn fnc_prayInTemple;}, [], 1.5, true, true, "", "((player distance sunni_man) < 5) and ((vehicle player)==player) and (religion=='sunni')",-1];
	
	/*
	{
		//_x setFuelCargo 0;
		_x addAction [format ["Заправить машину %1$/л",round(50*(1+nds_tax))], {_this spawn fnc_refuelCar;}, [_x], 1.5, true, true, "", "(vehicle player != player)",5];
	} foreach ([0,0,0] nearObjects ["Land_A_FuelStation_Feed",100000]);
	*/
		
};
publicVariable "fnc_clientShopsInit";
[] spawn fnc_initializeServerVars;
_koke = [] spawn fnc_initializeItems;
waitUntil {scriptDone _koke};
[] spawn fnc_initializeFactories;
[] spawn fnc_initializeShops;
waitUntil {kokoko123};
//[] spawn fnc_clientShopsInit;
fnc_kekusiki = {
/*
	{
		
		private ["_items","_shopclass","_shopIndex"];
		
		_shopclass = _x;
		_shopIndex = _forEachIndex;
		_items = (global_shops_array_items select _shopIndex) select 0;
		
		{
		
			private ["_itemclass","_result","_code"];
			
			_itemclass = _x select 0;
			
			systemChat str _itemclass;
						
			_code = {
				
				("extDB3" callExtension format ["0:SQL:UPDATE shops_goods SET amount = %3 WHERE itemclass = '%1' AND shopclass = '%2'", str _itemclass, str _shopclass, _x select 1])
				
			};
			
			_x call _code;
				
		
		} forEach _items;		
	
	} forEach global_shops_array_classes;
*/
};
fnc_kekus = {
	{
	
		//_result = ("extDB3" callExtension format ["0:SQL:SELECT itemclass,classname,name,weight,legal,script,args,description,droppable,type,parts,trunk,wh From array_invitems WHERE id = %1",_i]);
		_result = ("extDB3" callExtension format ["0:SQL:SELECT COUNT(*) From array_invitems WHERE itemclass = '%1'", str (_x select 0)]);
		
		_result = (((call compile _result) select 1) select 0) select 0;
		
		//systemChat str _result;		
		
		if (_result==0) then {
			
			_code = {
			
				("extDB3" callExtension format ["0:SQL:INSERT INTO array_invitems (itemclass,classname,name,weight,legal,script,args,description,droppable,type,parts,trunk,wh) VALUES ('%1','%2','%3',%4,'%5','%6','%7','%8','%9','%10','%11',%12,%13)",str (_this select 0),str (_this select 1),str (_this select 2),_this select 3,str (_this select 4),str (_this select 5),str (_this select 6),str (_this select 7),str (_this select 8),str (_this select 9),str (_this select 10),_this select 11,_this select 12])
			
			};
		
			_x call _code;
			
		} else {
			
			
			_code = {
			
				("extDB3" callExtension format ["0:SQL:UPDATE array_invitems SET classname = '%2', name = '%3', weight = %4, legal = '%5', script = '%6', args = '%7', description = '%8', droppable = '%9', type = '%10', parts = '%11', trunk = %12, wh = %13 WHERE itemclass = '%1'",str (_this select 0),str (_this select 1),str (_this select 2),_this select 3,str (_this select 4),str (_this select 5),str (_this select 6),str (_this select 7),str (_this select 8),str (_this select 9),str (_this select 10),_this select 11,_this select 12])
			
			};
		
			_x call _code;
			
			
		};
		
	
	} forEach items_array;
};
//["money","Land_Money_F","ÐšÑ€Ð¾Ð½Ð°",0,true,"fnc_itemNoUse",[],"Ð§ÐµÑ€Ð½Ð¾Ñ€ÑƒÑÑÐºÐ°Ñ ÐºÑ€Ð¾Ð½Ð°, Ð¾Ñ„Ð¸Ñ†Ð¸Ð°Ð»ÑŒÐ½Ð°Ñ Ð²Ð°Ð»ÑŽÑ‚Ð° Ð§Ñ€ÐµÐ½Ð¾Ñ€ÑƒÑÑÐ¸Ð¸.",true,"item",[],0,0]
/*
comment "Exported from Arsenal by Bowman";
comment "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;
comment "Add containers";
this forceAddUniform "CUP_U_C_Policeman_01";
for "_i" from 1 to 2 do {this addItemToUniform "CUP_30Rnd_545x39_AK_M";};
this addItemToUniform "CUP_8Rnd_9x18_Makarov_M";
this addVest "CUP_V_C_Police_Holster";
for "_i" from 1 to 2 do {this addItemToVest "CUP_30Rnd_545x39_AK_M";};
for "_i" from 1 to 2 do {this addItemToVest "CUP_8Rnd_9x18_Makarov_M";};
this addHeadgear "CUP_H_C_Policecap_01";
comment "Add weapons";
this addWeapon "CUP_arifle_AKS74U";
this addPrimaryWeaponItem "CUP_optic_Kobra";
this addWeapon "CUP_hgun_Makarov";
this addWeapon "Binocular";
comment "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";
this linkItem "ItemWatch";
this linkItem "ItemRadio";
this linkItem "ItemGPS";
this linkItem "NVGoggles_OPFOR";
"\CUP\WheeledVehicles\CUP_WheeledVehicles_Lada\Data\lada_lm_co.paa"
comment "Set identity";
this setFace "GreekHead_A3_09";
this setSpeaker "male01eng";
items_array pushBack ["CUP_V_C_Police_Holster","CUP_V_C_Police_Holster","Пояс и кобура",0,true,"fnc_itemNoUse",[],"Кобура с поясом для ношения пистолета и прочего снаряжения.",true,"vest",[],0,0];
items_array pushBack ["CUP_hgun_Makarov","CUP_hgun_Makarov","ПМ",0,true,"fnc_itemNoUse",[],"Пистолет Макарова. Калибр 9х18 мм.",true,"weapon",[],0,0];
items_array pushBack ["CUP_arifle_AKS74U","CUP_arifle_AKS74U","АКС-74У",0,true,"fnc_itemNoUse",[],"Укороченный автомат калашникова. Калибр - 5,45х39 мм. Крепление для прицелов - ласточкин хвост.",true,"weapon",[],0,0];
items_array pushBack ["CUP_optic_Kobra","CUP_optic_Kobra","Коллиматор Кобра",0,true,"fnc_itemNoUse",[],"Коллиматорный прицел. Крепление - ласточкин хвост.",true,"gameitem",[],0,0];
items_array pushBack ["CUP_U_C_Policeman_01","CUP_U_C_Policeman_01","Полицейская униформа",0,true,"fnc_itemNoUse",[],"Полицейская униформа.",true,"uniform",[],0,0];
items_array pushBack ["CUP_H_C_Policecap_01","CUP_H_C_Policecap_01","Полицейская фуражка",0,true,"fnc_itemNoUse",[],"Полицейская фуражка с кокардой.",true,"gameitem",[],0,0];
items_array pushBack ["CUP_8Rnd_9x18_Makarov_M","CUP_8Rnd_9x18_Makarov_M","8 пат. 9х18 ПМ",0,true,"fnc_itemNoUse",[],"Магазин для ПМ на 8 патронов калибра 9х18 мм.",true,"magazine",[],0,0];
items_array pushBack ["CUP_30Rnd_545x39_AK_M","CUP_30Rnd_545x39_AK_M","30 пат. 5,45х39 АК",0,true,"fnc_itemNoUse",[],"Магазин для автомата Калашникова на 30 патронов калибра 5,45х39 мм.",true,"magazine",[],0,0];
*/
fnc_kekusok = {
	{
		
		private ["_object","_factory"];
		
		_factory = _x select 0;
		_object = _x select 2;
		
		{
			
			//systemChat str _x;
		
			_result = ("extDB3" callExtension format ["0:SQL:SELECT COUNT(*) From factories_owners WHERE factory = '%1' AND playerid = '%2'", str _factory, str _x]);
			
			_result = (((call compile _result) select 1) select 0) select 0;
			
			//systemChat str _result;
			
			if (_result==0) then {
				
				_code = {
				
					("extDB3" callExtension format ["0:SQL:INSERT INTO factories_owners (playerid,factory,kassa,wage,whs,factoryname) VALUES ('%1','%2',%3,%4,%5,'%6')", str _x, str _factory, (_object getVariable ["factory_money",[]]) select _forEachIndex, (_object getVariable ["factory_wages",[]]) select _forEachIndex, (_object getVariable ["factory_whs",[]]) select _forEachIndex, (str ((_object getVariable ["factory_names",[]]) select _forEachIndex))])
				
				};
			
				_x call _code;
				
			} else {
				
				
				_code = {
				
					//("extDB3" callExtension format ["0:SQL:INSERT INTO factories_owners (playerid,factory,kassa,wage,whs) VALUES ('%1','%2',%3,%4,%5)", str _x, str _factory, (_object getVariable ["factory_money",[]]) select _forEachIndex, (_object getVariable ["factory_wages",[]]) select _forEachIndex, (_object getVariable ["factory_whs",[]]) select _forEachIndex])
					
					("extDB3" callExtension format ["0:SQL:UPDATE factories_owners SET kassa = %3, wage = %4, whs = %5, factoryname = '%6' WHERE factory = '%1' AND playerid = '%2'", str _factory, str _x, (_object getVariable ["factory_money",[]]) select _forEachIndex, (_object getVariable ["factory_wages",[]]) select _forEachIndex, (_object getVariable ["factory_whs",[]]) select _forEachIndex, (str ((_object getVariable ["factory_names",[]]) select _forEachIndex))])
				
				};
			
				_x call _code;
				
				//systemChat str (str (_object getVariable ["factory_names",[]]));
				
			};
		
		} forEach (_object getVariable ["factory_owners",[]]);
	
	} forEach factories_array;
};
fnc_saveVehicleArray = {
	
	private ["_platestoremove"];
	
	_platestoremove = [];
	{
		
		private ["_vehicle","_result","_regplate","_args","_plt"];
		
		_vehicle = _x;
		
		if (!(isNil _vehicle)) then {
						
			_plt = _vehicle;
			_vehicle = call compile _vehicle;
				
			if !(_vehicle getVariable ["policevehicle",false]) then {
				_regplate = _vehicle getVariable ["regplate","none"];
				
				if !(alive _vehicle) then {
					
					("extDB3" callExtension format ["0:SQL:DELETE FROM vehicles WHERE regplate = %1", _regplate]);
					
					_platestoremove pushBack _plt;
					
				} else {
				
					
					_result = ("extDB3" callExtension format ["0:SQL:SELECT COUNT(*) From vehicles WHERE regplate = %1", _regplate]);
					
					_result = (((call compile _result) select 1) select 0) select 0;
					
					//systemChat str _result;
					
					if (_result==0) then {
						
						_code = {
							
							private ["_string"];
							
							_string = ["0:SQL:INSERT INTO vehicles (classname,owner,regplate,damage,fuel,upgrade_data,garage,shtraf,items,itemscargo,magazinescargo) VALUES ('",_this select 0,"','",str (_this select 10),"',",_this select 1,",",_this select 2,",",_this select 3,",'",str (_this select 4),"','",(_this select 5),"',",_this select 6,",'",_this select 7,"','",_this select 8,"','",_this select 9,"')"] joinString "";
										
							//copyToClipboard _string;
							
							//systemChat str (_vehicle getVariable ["tuning_data",["none",0]]);
						
							("extDB3" callExtension _string)
						
						};
						
						private ["_defgarage"];
						
						_defgarage = "garage_1";
						
						if (_vehicle isKindOf "Ship") then {_defgarage = "garage_boat_1";};
						
						_args = [str (typeOf _vehicle), _regplate, getDammage _vehicle, fuel _vehicle, toArray (str (_vehicle getVariable ["tuning_data",["none",0]])), str _defgarage, 0, [_vehicle getVariable ["trunkitems",[]],_vehicle getVariable ["trunkamounts",[]]], [weaponsItemsCargo _vehicle, itemCargo _vehicle, getBackpackCargo _vehicle], magazinesAmmoCargo _vehicle, _vehicle getVariable ["owner","server"]];
					
						_args call _code;
						
					} else {
						
						
						_code = {
							
							private ["_string"];
							
							_string = ["0:SQL:UPDATE vehicles SET damage = ", _this select 1, ", fuel = ",_this select 2,", upgrade_data = '",_this select 3,"', garage = '",_this select 4,"', shtraf = ",_this select 5, ", items = '", _this select 6, "', itemscargo = '", _this select 7, "', magazinescargo = '", _this select 8, "', owner = '", str (_this select 9),"' WHERE regplate = ", _this select 0] joinString "";
														
							//copyToClipboard _string;
						
							("extDB3" callExtension _string)
						
						};
						
						private ["_defgarage"];
						
						_defgarage = "garage_1";
						
						if (_vehicle isKindOf "Ship") then {_defgarage = "garage_boat_1";};
						
						_args = [_regplate, getDammage _vehicle, fuel _vehicle, toArray (str (_vehicle getVariable ["tuning_data",["none",0]])), str _defgarage, 0, [_vehicle getVariable ["trunkitems",[]],_vehicle getVariable ["trunkamounts",[]]], [weaponsItemsCargo _vehicle, itemCargo _vehicle, getBackpackCargo _vehicle], magazinesAmmoCargo _vehicle, _vehicle getVariable ["owner","server"]];
									
						_args call _code;				
						
					};
				
				};
			
			};
			
			
		} else {
			
			_platestoremove pushBack _vehicle;
			
		};
	
	} forEach servervehiclesarray;
	
	{
		
		servervehiclesarray = servervehiclesarray - [_x];
		
	} forEach _platestoremove;
};
fnc_saveServerVars = {
	
	{
		private ["_varname","_varvalue","_args","_code"];
		
		_varname = _x;
		_varvalue = [call compile _x];
		
		_code = {
					
			private ["_string"];
					
			_string = ["0:SQL:UPDATE servervars SET value = '", _this select 1 ,"' WHERE name = '", str (_this select 0),"'"] joinString "";
												
			//copyToClipboard _string;
				
			("extDB3" callExtension _string)
				
		};
				
		_args = [_varname, _varvalue];
							
		_args call _code;
		
	} forEach variables_to_save;
	
	
};
fnc_saveShopsAndFacs = {
	
	[] spawn fnc_kekusiki;
	
	sleep 5;
	
	[] spawn fnc_kekusok;
	
	sleep 5;
	
	[] spawn fnc_saveVehicleArray;
	
	sleep 5;
	
	[] spawn fnc_saveServerVars;
	
	sleep 5;
	
};
[] spawn {
	
	while {true} do {
		
		private ["_scr"];
		
		_scr = [] spawn fnc_saveShopsAndFacs;
		
		waitUntil {scriptDone _scr};
		
		sleep 5;		
		
	};
	
	
};
