
fnc_getItemAmount = {
	private ["_amount"];
	_amount = 0;
	_type = _this call fnc_getItemType;
	switch _type do {
		case "item": {
			if (inventory_items find _this > -1) then {
				_amount = inventory_amount select (inventory_items find _this);
			};
		};
		case "weapon": {
			_amount = 1;
		};
		case "magazine": {
			_magstosell = [];
			{
				if (_x == _this) then {_magstosell pushBack _x};
			} foreach (magazines player);
			_amount = count _magstosell;
		};
		case "gameitem": {
			_itemstosell = [];
			{
				if (_x == _this) then {_itemstosell pushBack _x};
			} foreach (items player);
			_amount = count _itemstosell;
		};
		case "uniform": {
			if (uniform player == _this) then {
				_amount = 1;
			};
		};
		case "vest": {
			if (vest player == _this) then {
				_amount = 1;
			};
		};
		case "backpack": {
			if (backpack player == _this) then {
				_amount = 1;
			};
		};
	};
	_amount
};
publicVariable "fnc_getItemAmount";
fnc_getInvWeight = {
	private ["_weight"];
	_weight = 0;
	{_weight = _weight + ((_x call fnc_getItemWeight)*(inventory_amount select _forEachIndex))} foreach inventory_items;
	_weight
};
publicVariable "fnc_getInvWeight";
fnc_getLicenseName = {
	private ["_license","_name"];
	_license = _this;
	_name = (licenses_array select (licensesclass_array find _license)) select 1;
	_name
};
publicVariable "fnc_getLicenseName";
fnc_getItemName = {
	private ["_class","_name"];
	_class = _this;
	_name = (items_array select (items_classes find _class)) select 2;
	_name
};
publicVariable "fnc_getItemName";
fnc_getItemLegal = {
	private ["_class","_info"];
	_class = _this;
	_info = (items_array select (items_classes find _class)) select 4;
	_info
};
publicVariable "fnc_getItemLegal";
fnc_getItemInfo = {
	private ["_class","_info"];
	_class = _this;
	_info = (items_array select (items_classes find _class)) select 7;
	_info
};
publicVariable "fnc_getItemInfo";
fnc_getItemWeight = {
	private ["_class","_weight"];
	_class = _this;
	_weight = (items_array select (items_classes find _class)) select 3;
	_weight
};
publicVariable "fnc_getItemWeight";
fnc_useItem = {
	private ["_index","_amount","_item","_params","_script"];
	_index = _this select 0;
	_amount = _this select 1;
	_minimum = 1;
	if (_index<0) exitWith {
		["Выберите предмет!","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	};
	if ((_amount<_minimum) or ((_amount/_minimum)!=round(_amount/_minimum))) exitWith {};
	_item = inventory_items select _index;
	if (_amount > (_item call fnc_getItemAmount)) then {_amount = _item call fnc_getItemAmount;};
	_params = (items_array select (items_classes find _item)) select 6;
	_script = (items_array select (items_classes find _item)) select 5;
	call compile format ["[%1,%2,'%3'] spawn (call compile '%4')", _amount, _params, _item, _script];	
};
publicVariable "fnc_useItem";
fnc_playerHasLicense = {
	private ["_hasLicense"];
	_hasLicense = false;
	if (_this in (licenses + licenses_illegal)) then {
		_hasLicense = true;
	};
	_hasLicense
};
publicVariable "fnc_playerHasLicense";
fnc_removeItem = {
	private ["_item","_amount","_index"];
	_item = _this select 0;
	_amount = _this select 1;
	_minimum = 1;
	if ((_amount<_minimum) or ((_amount/_minimum)!=round(_amount/_minimum))) exitWith {};
	if (_amount > (_item call fnc_getItemAmount)) then {_amount = (_item call fnc_getItemAmount);};
	_index = inventory_items find _item;
	inventory_amount set [_index, (inventory_amount select _index) - _amount];
	if ((inventory_amount select _index) <= 0) then {
		inventory_items deleteAt _index;
		inventory_amount deleteAt _index;
	};
	player setVariable ["invi",inventory_items,true];
	player setVariable ["inva",inventory_amount,true];
	["deposit", deposit] call ClientSaveVar;
		
	["inventory_items", inventory_items] call ClientSaveVar;
	["inventory_amount", inventory_amount] call ClientSaveVar;
};
publicVariable "fnc_removeItem";
fnc_addItem = {
	private ["_item","_amount","_index"];
	_item = _this select 0;
	_amount = _this select 1;
	_minimum = 1;
	if ((_amount<_minimum) or ((_amount/_minimum)!=round(_amount/_minimum))) exitWith {};
	if (_amount <1) exitWith {};
	if (inventory_items find _item < 0) then {
		inventory_items pushBack _item;
		inventory_amount pushBack _amount;
	} else {
		_index = inventory_items find _item;
		inventory_amount set [_index, (inventory_amount select _index)+_amount];
	};
	player setVariable ["invi",inventory_items,true];
	player setVariable ["inva",inventory_amount,true];
	["deposit", deposit] call ClientSaveVar;
		
	["inventory_items", inventory_items] call ClientSaveVar;
	["inventory_amount", inventory_amount] call ClientSaveVar;
};
publicVariable "fnc_addItem";
fnc_atm_deposit = {
	private ["_amount"];
	_amount = _this;
	_minimum = 1;
	if ((_amount<_minimum) or ((_amount/_minimum)!=round(_amount/_minimum))) exitWith {
		["Банкомат","Допустимы только целые числа",[1,1,1,1],[0,0.68,0.47,0.8]] spawn fnc_notifyMePls;
	};
	if (("money" call fnc_getItemAmount)>=_amount) then {
		["money", _amount] call fnc_removeItem;
		deposit = deposit+_amount;
		["Банкомат",format ["Вы положили %1 CRK на счёт", _amount],[1,1,1,1],[0,0.68,0.47,0.8]] spawn fnc_notifyMePls;
		(format ["[%1|%2|%4] has deposited %3 CRK to ATM", name player, getPlayerUID player, _amount, side player]) remoteExec ["fnc_logMyStuff",2];
	} else {
		["Банкомат","Недостаточно денег на счету.",[1,1,1,1],[0,0.68,0.47,0.8]] spawn fnc_notifyMePls;
	};
};
publicVariable "fnc_atm_deposit";
fnc_atm_withdraw = {
	private ["_amount"];
	_amount = _this;
	_minimum = 1;
	if ((_amount<_minimum) or ((_amount/_minimum)!=round(_amount/_minimum))) exitWith {
		["Банкомат","Допустимы только целые числа",[1,1,1,1],[0,0.68,0.47,0.8]] spawn fnc_notifyMePls;
	};
	if (deposit>=_amount) then {
		["money", _amount] call fnc_addItem;
		deposit = deposit-_amount;
		["Банкомат",format ["Вы сняли %1 CRK со своего счёта", _amount],[1,1,1,1],[0,0.68,0.47,0.8]] spawn fnc_notifyMePls;
		(format ["[%1|%2|%4] has withdrawn %3 CRK from ATM", name player, getPlayerUID player, _amount, side player]) remoteExec ["fnc_logMyStuff",2];
	} else {
		["Банкомат","Недостаточно денег на руках.",[1,1,1,1],[0,0.68,0.47,0.8]] spawn fnc_notifyMePls;
	};
};
publicVariable "fnc_atm_withdraw";
//shopclass,shopname,shopdescription,object,owner,kassa,crate,spawn,model,position,direction,spawn_position,spawn_direction,crate_position,crate_direction,buyshit
fnc_getShopCrate = {
	private ["_shop","_crate"];
	_shop = _this;
	_crate = (global_shops_array select (global_shops_array_classes find _shop)) select 6;
	_crate = call compile _crate;
	_crate
};
publicVariable "fnc_getShopCrate";
fnc_getShopSpawn = {
	private ["_shop","_spawn"];
	_shop = _this;
	_spawn = (global_shops_array select (global_shops_array_classes find _shop)) select 7;
	_spawn = call compile _spawn;
	_spawn
};
publicVariable "fnc_getShopSpawn";
fnc_getShopBuyshit = {
	private ["_shop", "_items"];
	_shop = _this;
	_items = (global_shops_array select (global_shops_array_classes find _shop)) select 15;
	_items
};
publicVariable "fnc_getShopBuyshit";
fnc_getShopItems = {
	private ["_shop", "_items"];
	_shop = _this;
	_items = (global_shops_array_items select (global_shops_array_classes find _shop));
	_items
};
publicVariable "fnc_getShopItems";
fnc_getItemType = {
	private ["_item", "_type"];
	_item = _this;
	_type = (items_array select (items_classes find _item)) select 9;
	_type
};
publicVariable "fnc_getItemType";
fnc_dropItem = {
	private ["_index", "_amount", "_item", "_droppable", "_hasItems", "_object"];
	_index = _this select 0;
	_amount = _this select 1;
	_minimum = 1;
	if (_index<0) exitWith {["Выберите предмет!","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	if ((_amount<_minimum) or ((_amount/_minimum)!=round(_amount/_minimum))) exitWith {["Неправильное число","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	_item = inventory_items select _index;
	if (isNil "_item") exitWith {};
	if (isNil "_amount") exitWith {};
	_droppable = (items_array select (items_classes find _item)) select 8;
	if (!_droppable) exitWith {["Этот предмет нельзя выбросить.","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	_hasItems = _item call fnc_getItemAmount;
	if (_amount > _hasItems) then {_amount = _hasItems};
	[_item, _amount] call fnc_removeItem;
	[_item, _amount, getPos player] call fnc_spawnItem;
	[format ["Вы выбросили %1 %2", [_amount] call fnc_numberToText, _item call fnc_getItemName]] spawn fnc_itemNotifyMePls;
	(format ["[%1|%2|%3] has dropped %4 %5", name player, getPlayerUID player, side player, _amount, _item]) remoteExec ["fnc_logMyStuff",2];
};
publicVariable "fnc_dropItem";
fnc_spawnItem = {
	private ["_item", "_amount", "_object", "_position", "_v"];
	_item = _this select 0;
	_amount = _this select 1;
	_position = _this select 2;
	_object = (items_array select (items_classes find _item)) select 1;
	_v = createVehicle [_object, _position, [], 1, "CAN_COLLIDE"];
	_v setVariable ["item", _item, true];
	_v setVariable ["amount", _amount, true];
};
publicVariable "fnc_spawnItem";
fnc_getShopStock = {
	private ["_item", "_shop", "_index", "_stock"];
	_item = _this select 0;
	_shop = global_shops_array_classes find (_this select 1);	
	_index = ((global_shops_array_items select _shop) select 1) find _item;
	_stock = (((global_shops_array_items select _shop) select 0) select _index) select 1;
	_stock
};
publicVariable "fnc_getShopStock";
fnc_getShopMaxStock = {
	private ["_item", "_shop", "_index", "_stock"];
	_item = _this select 0;
	_shop = global_shops_array_classes find (_this select 1);	
	_index = ((global_shops_array_items select _shop) select 1) find _item;
	_stock = (((global_shops_array_items select _shop) select 0) select _index) select 3;
	_stock
};
publicVariable "fnc_getShopMaxStock";
fnc_removeShopStock = {
	private ["_item", "_shop", "_amount", "_index", "_stock","_code","_args","_result"];
	_item = _this select 0;
	_amount = _this select 1;
	_minimum = 1;
	if ((_amount<_minimum) or ((_amount/_minimum)!=round(_amount/_minimum))) exitWith {};
	_shop = _this select 2;
	_index = ((global_shops_array_items select (global_shops_array_classes find _shop)) select 1) find _item;
	_stock = (((global_shops_array_items select (global_shops_array_classes find _shop)) select 0) select _index) select 1;
	(((global_shops_array_items select (global_shops_array_classes find _shop)) select 0) select _index) set [1, _stock-_amount];
	publicVariable "global_shops_array_items";
	
	_args = [_item, _shop, _stock-_amount];
	
	_args spawn {
		[fnc_getRes_remote_code_41,_this] call fnc_getResult;
	};
};
publicVariable "fnc_removeShopStock";
fnc_addShopStock = {
	
	private ["_item", "_shop", "_amount", "_index", "_stock","_code","_args","_result"];
	_item = _this select 0;
	_amount = _this select 1;
	_minimum = 1;
	if ((_amount<_minimum) or ((_amount/_minimum)!=round(_amount/_minimum))) exitWith {};
	_shop = _this select 2;
	_index = ((global_shops_array_items select (global_shops_array_classes find _shop)) select 1) find _item;
	_stock = (((global_shops_array_items select (global_shops_array_classes find _shop)) select 0) select _index) select 1;
	(((global_shops_array_items select (global_shops_array_classes find _shop)) select 0) select _index) set [1, _stock+_amount];
	publicVariable "global_shops_array_items";
	
	_args = [_item, _shop, _stock+_amount];
	
	_args spawn {
		[fnc_getRes_remote_code_42,_this] call fnc_getResult;
	};
	
};
publicVariable "fnc_addShopStock";
fnc_getItemResources = {
	private ["_item","_arr"];
	_item = _this;
	_arr = (items_array select (items_classes find _item)) select 10;
	_arr
};
publicVariable "fnc_getItemResources";
fnc_addFactoryItem = {
	private ["_item","_amount","_factory","_exit"];
	_item = _this select 0;
	_amount = _this select 1;
	_minimum = 1;
	if ((_amount<_minimum) or ((_amount/_minimum)!=round(_amount/_minimum))) exitWith {["Неправильное число","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	_factory = _this select 2;
	_exit = false;
	{
		if (_x select 0 == _item) then {(_x) set [1, (_x select 1)+_amount]; _exit = true;};	
	} foreach (my_factories_stock select (my_factories find _factory));
	if (_exit) exitWith {};
	(my_factories_stock select (my_factories find _factory)) pushBack [_item,_amount];
};
publicVariable "fnc_addFactoryItem";
fnc_removeFactoryItem = {
	private ["_item","_amount","_factory"];
	_item = _this select 0;
	_amount = _this select 1;
	_minimum = 1;
	if ((_amount<_minimum) or ((_amount/_minimum)!=round(_amount/_minimum))) exitWith {["Неправильное число","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	_factory = _this select 2;
	{
		if ((_x select 0) == _item) then {
			(_x) set [1, (_x select 1)-_amount];
			if ((_x select 1) <= 0) then {(my_factories_stock select (my_factories find _factory)) deleteAt _forEachIndex;};
		};	
	} foreach (my_factories_stock select (my_factories find _factory));
};
publicVariable "fnc_removeFactoryItem";
fnc_putToFactory = {
	private ["_item","_amount","_droppable","_object"];
	_item = _this select 0;
	_amount = _this select 1;
	_droppable = (items_array select (items_classes find _item)) select 8;
	_object = (factories_array select curfac) select 2;
	if (!_droppable) exitWith {["Завод","Этот предмет нельзя выбросить.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	if !(_item in (_object getVariable ["allowed_put",[]])) exitWith {["Завод","На завод можно класть только ресурсы требуемые для производства.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	_minimum = 1;
	if ((_amount<_minimum) or ((_amount/_minimum)!=round(_amount/_minimum))) exitWith {["Завод","Неправильное число.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	if (isNil "_item") exitWith {};
	if (isNil "_amount") exitWith {};
	_factory = factoryclass_array select curfac;
	if (_amount>(_item call fnc_getItemAmount)) then {_amount=(_item call fnc_getItemAmount)};
	if (_amount<0) then {_amount=0};
	[_item, _amount] call fnc_removeItem;
	[_item,_amount,_factory] call fnc_addFactoryItem;
	["Завод",format ["Вы положили %1 %2 на склад.",_amount,_item call fnc_getItemName],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
};
publicVariable "fnc_putToFactory";
fnc_getFactoryStock = {
	private ["_item","_factory","_stock","_storage"];
	_item = _this select 0;
	_factory = _this select 1;
	_stock = 0;
	_storage = my_factories_stock select (my_factories find _factory);
	if (!isNil "_storage") then {
		{
			if ((_x select 0) == _item) then {_stock = _x select 1;};
		} foreach _storage;
	};
	_stock	
};
publicVariable "fnc_getFactoryStock";
fnc_takeFromFactory = {
	private ["_item","_itemtype","_box","_amount","_stock","_vehname","_params"];
	_item = _this select 0;
	_itemtype = _item call fnc_getItemType;
	_amount = _this select 1;
	_minimum = 1;
	if ((_amount<_minimum) or ((_amount/_minimum)!=round(_amount/_minimum))) exitWith {["Завод","Неправильное число.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	if (isNil "_item") exitWith {};
	if (isNil "_amount") exitWith {};
	_factory = factoryclass_array select curfac;
	_box = (factories_array select curfac) select 5;
	_spawn = (factories_array select curfac) select 6;
	_stock = ([_item,_factory] call fnc_getFactoryStock);
	if (_amount>_stock) then {_amount=_stock};
	if (_amount<0) then {_amount=0};
	switch _itemtype do {
		case "backpack": {
			_box addBackpackCargoGlobal [_item, _amount];			
		};
		case "item": {
			[_item, _amount] call fnc_addItem;
		};
		case "vehicle": {
			
			_regplate = str currentplate;
			currentplate = currentplate + 1;
			publicVariable "currentplate";
			
			_vehname = format ["veh_%1",_regplate];
			
			call compile format ["%1 = createVehicle [_item, getPos _spawn, [], 3, ''];",_vehname];
			
			_veh = call compile _vehname;
		
			
			
			//_veh = createVehicle [_item, getPos _spawn, [], 3, ""];
			_veh lock true;
			_veh setDir (getDir _spawn);
			clearWeaponCargoGlobal _veh;
			clearMagazineCargoGlobal _veh;
			clearItemCargoGlobal _veh;
			clearBackpackCargoGlobal _veh;
	
			_veh remoteExec ["fnc_offroadSpeedLimit",2];
	
			//_regplate = format ["%1_%2", player, round(time)];
			/*_veh setVehicleVarName format ["veh%1",_regplate];
			call compile format ["%1 = %2;",format ["veh%1",_regplate],_vehname];*/
			
			[_veh,_regplate] remoteExec ["fnc_vehicleVarNameRemote",0,true];
			missionNamespace setVariable [format ["veh%1",_regplate],_veh,true];
			
			_params = ((items_array select (items_classes find _item)) select 6) select 0;
			
			_veh setVariable ["tuning_data",["none",0],true];
			_veh setVariable ["owner",getPlayerUID player,true];
						
			if ((count _params) == 1) then {
				
				//_params = _params select 0;
				{
					_veh setObjectTextureGlobal [_forEachIndex,_x];
				} forEach _params;
				_veh setVariable ["tuning_data",[_params,0],true];
				
			};
			publicVariable format ["veh%1",_regplate];
			servervehiclesarray pushBack format ["veh%1",_regplate];
			publicVariable "servervehiclesarray";
			_veh setVariable ["regplate", _regplate, true];
			_veh setVariable ["trunkitems", [], true];
			_veh setVariable ["trunkamounts", [], true];
			vehicle_keys pushBack _regplate;
		};
		default {
			_box addItemCargoGlobal [_item, _amount];
		};
	};
	[_item,_amount,_factory] call fnc_removeFactoryItem;
	["Завод",format ["Вы взяли %1 %2 со склада.",_amount,_item call fnc_getItemName],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
};
publicVariable "fnc_takeFromFactory";
fnc_produceFactoryItem = {
	private ["_item","_itemtype","_factory","_amount","_res","_wh","_lack","_minimum"];
	_item = _this select 0;
	if (isNil "_item") exitWith {};
	_amount = _this select 1;
	_factory = factoryclass_array select curfac;
	_res = _item call fnc_getItemResources;
	_wh = _item call fnc_getItemWH;
	_minimum = 1;
	{
		_newminimum = 0;
		if ((_x select 1) < 1) then {
			_newminimum = 1/(_x select 1);
			if (_newminimum>_minimum) then {
				_minimum=_newminimum;
			};
		};
	} foreach _res;
	if ((_amount<_minimum) or ((_amount/_minimum)!=round(_amount/_minimum))) exitWith {["Производство",format ["Количество данного продукта должно быть кратно %1", _minimum],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	_lack = false;
	{
		if (((_x select 1)*_amount)>([_x select 0, _factory] call fnc_getFactoryStock)) then {_lack = true};
	} foreach _res;
	if (_lack) exitWith {["Производство","Недостаточно ресурсов!",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	
	if ((_wh*_amount)>(my_factories_wh select (my_factories find _factory))) exitWith {["Производство","Недостаточно человекочасов!",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};	
	{
		[_x select 0,(_x select 1)*_amount,_factory] call fnc_removeFactoryItem;
	} foreach _res;
	my_factories_wh set [(my_factories find _factory),(my_factories_wh select (my_factories find _factory))-(_wh*_amount)];
	[_item,_amount,_factory] call fnc_addFactoryItem;
	["Производство",format ["Вы произвели %1 %2",_amount,_item call fnc_getItemName],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
};
publicVariable "fnc_produceFactoryItem";
fnc_produceFactoryItemSell = {
	if (antidupa and ((lastdupa+5)>time)) exitWith {hint "Неизвестная ошибка! Подождите 5 секунд!";};
	
	antidupa = true;
	lastdupa = time;
	
	private ["_item","_itemtype","_box","_amount","_stock","_vehname","_shops_allowed"];
	
	_item = _this select 0;
	_itemtype = _item call fnc_getItemType;
	
	if !(_itemtype in ["vehicle","gameitem","uniform","vest","backpack","weapon","magazine"]) exitWith {antidupa = false; ["Экспорт","Экспортировать можно только транспортные средства и реальные предметы.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	
	_amount = _this select 1;
	_minimum = 1;
	if ((_amount<_minimum) or ((_amount/_minimum)!=round(_amount/_minimum))) exitWith {antidupa = false; ["Экспорт","Неправильное число.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	
	if (isNil "_item") exitWith {antidupa = false;};
	if (isNil "_amount") exitWith {antidupa = false;};
	
	_factory = factoryclass_array select curfac;
	_stock = ([_item,_factory] call fnc_getFactoryStock);
	
	if (_amount>_stock) then {_amount=_stock};
	if (_amount<0) then {_amount=0};
	
	if (_amount==0) exitWith {antidupa = false; ["Экспорт","Нечего экспортировать.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	
	_shops_allowed = [];
	
	{
		if ((_item in (_x select 1)) and (((global_shops_array select _forEachIndex) select 15)==1)) then {
			_shops_allowed pushBack (global_shops_array_classes select _forEachIndex);
		};
		
	} foreach global_shops_array_items;
	
	if (count _shops_allowed > 0) then {
		
		private ["_items","_classnames","_shopname","_stock","_maxstock"];
		
		_demand = _shops_allowed select 0;
		_shopname = "error";
		{
			//if (([_item, _demand] call fnc_getShopStock)>([_item, _x] call fnc_getShopStock)) then {
				
			if ((([_item, _demand] call fnc_getShopStock)/([_item, _demand] call fnc_getShopMaxStock))>(([_item, _x] call fnc_getShopStock)/([_item, _x] call fnc_getShopMaxStock))) then {				
				
				_demand = _x;
			};
			
		} foreach _shops_allowed;
		
		_shopname = (global_shops_array select (global_shops_array_classes find _demand)) select 1;
		_items = _demand call fnc_getShopItems;
		_classnames = _items select 1;
		_items = _items select 0;
		_price = round(((_items select (_classnames find _item)) select 2)/2);
		
		_stock = [_item, _demand] call fnc_getShopStock;
		_maxstock = [_item, _demand] call fnc_getShopMaxStock;
		
		if (_stock>=0) then {
			_price = ([_stock,_maxstock,_price] call fnc_getItemStockPrice);
		};		
		
		if (_amount>(([_item,_demand] call fnc_getShopMaxStock)-([_item,_demand] call fnc_getShopStock))) then {
			_amount = (([_item,_demand] call fnc_getShopMaxStock)-([_item,_demand] call fnc_getShopStock));
		};
		
		_cost = floor((_price*_amount));	
				
		[_item,_amount,_factory] call fnc_removeFactoryItem;
		["money", _cost] call fnc_addItem;
		[_item, _amount, _demand] spawn fnc_addShopStock;
		["Экспорт",format ["Вы продали %1 %2 в магазин %3 за %4 CRK", _amount, _item call fnc_getItemName, _shopname, [_cost] call fnc_numberToText],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
		closeDialog 0;
	} else {
		["Экспорт","Данный товар не имеет спроса в магазинах.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	};
		
	antidupa = false;
	
};
publicVariable "fnc_produceFactoryItemSell";
fnc_getItemWH = {
	private ["_itemus", "_whs"];
	_itemus = _this;
	_whs = (items_array select (items_classes find _itemus)) select 12;
	_whs
};
publicVariable "fnc_getItemWH";
fnc_factorySetWage = {
	private ["_factory","_amount","_index","_object","_wages"];
	_amount = _this;
	_minimum = 1;
	if ((_amount<_minimum) or ((_amount/_minimum)!=round(_amount/_minimum))) exitWith {["Допустимы только целые числа","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	if (_amount<0) then {_amount=0};
	_factory = factoryclass_array select curfac;
	_object = (factories_array select curfac) select 2;
		
	_index = (_object getVariable ["factory_owners",[]]) find (getPlayerUID player); //todouid
	
	_wages = _object getVariable ["factory_wages",[]];
	_wages set [_index,_amount];
	_object setVariable ["factory_wages",_wages,true];
	
	_names = _object getVariable ["factory_names",[]];
	_names set [_index,name player];
	_object setVariable ["factory_names",_names,true];
	
	["Завод",format ["Вы установили зарплату в %1 CRK", _amount],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	publicVariable "factory_wages";
};
publicVariable "fnc_factorySetWage";
fnc_factoryPutMoney = {
	private ["_factory","_amount","_index","_object"];
	_amount = _this;
	_minimum = 1;
	if ((_amount<_minimum) or ((_amount/_minimum)!=round(_amount/_minimum))) exitWith {["Допустимы только целые числа","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	if (_amount<0) then {_amount=0};
	if (_amount>("money" call fnc_getItemAmount)) then {_amount=("money" call fnc_getItemAmount)};
	_factory = factoryclass_array select curfac;
	_object = (factories_array select curfac) select 2;
	
	_index = (_object getVariable ["factory_owners",[]]) find (getPlayerUID player); //todouid
	
	["money", _amount] call fnc_removeItem;
	
	_money = _object getVariable ["factory_money",[]];
	_money set [_index,(_money select _index)+_amount];
	_object setVariable ["factory_money",_money,true];
	
	["Завод",format ["Вы положили %1 CRK в кассу", _amount],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	publicVariable "factory_money";
};
publicVariable "fnc_factoryPutMoney";
fnc_factoryTakeMoney = {
	private ["_factory","_amount","_index","_minimum","_factory","_object"];
	_amount = _this;
	_minimum = 1;
	if ((_amount<_minimum) or ((_amount/_minimum)!=round(_amount/_minimum))) exitWith {["Завод","Допустимы только целые числа.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	if (_amount<0) then {_amount=0};
	_factory = factoryclass_array select curfac;
	_object = (factories_array select curfac) select 2;
	
	_index = (_object getVariable ["factory_owners",[]]) find (getPlayerUID player); //todouid
	
	_money = _object getVariable ["factory_money",[]];
	
	if (_amount>(_money select _index)) then {_amount=(_money select _index)};
	
	_money set [_index,(_money select _index)-_amount];
	_object setVariable ["factory_money",_money,true];
	
	["money", _amount] call fnc_addItem;
	["Завод",format ["Вы взяли %1 CRK из кассы", _amount],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	publicVariable "factory_money";
};
publicVariable "fnc_factoryTakeMoney";
fnc_getItemTrunk = {
	private ["_class","_trunk"];
	_class = _this;	
	_trunk = (items_array select (items_classes find _class)) select 11;
	_trunk
};
publicVariable "fnc_getItemTrunk";
fnc_addTrunkItem = {
	private ["_veh","_item","_amount"];
	_veh = _this select 0;
	_item = _this select 1;
	_amount = _this select 2;
	_trunkitems = _veh getVariable "trunkitems";
	_trunkamounts = _veh getVariable "trunkamounts";
	if ((_amount<1) or ((_amount/1)!=round(_amount/1))) exitWith {["Багажник","Неправильное число",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	if (_amount <1) exitWith {};
	if (_trunkitems find _item < 0) then {
		_trunkitems pushBack _item;
		_trunkamounts pushBack _amount;
	} else {
		_index = _trunkitems find _item;
		_trunkamounts set [_index, (_trunkamounts select _index)+_amount];
	};	
	_veh setVariable ["trunkitems",_trunkitems,true];
	_veh setVariable ["trunkamounts",_trunkamounts,true];
	
};
publicVariable "fnc_addTrunkItem";
fnc_removeTrunkItem = {
	private ["_veh","_item","_amount"];
	_veh = _this select 0;
	_item = _this select 1;
	_amount = _this select 2;
	_trunkitems = _veh getVariable "trunkitems";
	_trunkamounts = _veh getVariable "trunkamounts";
	if ((_amount<1) or ((_amount/1)!=round(_amount/1))) exitWith {["Багажник","Неправильное число",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	if (_amount <1) exitWith {};
	_index = 0;
	if !(_trunkitems find _item < 0) then {
		_index = _trunkitems find _item;
		_trunkamounts set [_index, (_trunkamounts select _index)-_amount];
	};	
	if ((_trunkamounts select _index) <= 0) then {
		_trunkitems deleteAt _index;
		_trunkamounts deleteAt _index;
	};
	_veh setVariable ["trunkitems",_trunkitems,true];
	_veh setVariable ["trunkamounts",_trunkamounts,true];
	
};
publicVariable "fnc_removeTrunkItem";
fnc_takeItemFromTrunk = {
	private ["_veh","_item","_amount","_invamount","_avail","_trunkitems","_trunkamounts", "_maxweight","_weight"];
	_veh = _this select 0;
	_item = _this select 1;
	_amount = _this select 2;
	if (isNil "_item") exitWith {};
	if (isNil "_amount") exitWith {};
	if ((_amount<1) or ((_amount/1)!=round(_amount/1))) exitWith {["Багажник","Неправильное число",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	if (_amount <1) exitWith {};
	//_invamount = _item call fnc_getItemAmount;
	_trunkitems = _veh getVariable "trunkitems";
	_trunkamounts = _veh getVariable "trunkamounts";
	
	if (_amount>(_trunkamounts select (_trunkitems find _item))) then {_amount=(_trunkamounts select (_trunkitems find _item))};
	
	[_veh,_item,_amount] call fnc_removeTrunkItem;
	[_item,_amount] call fnc_addItem;
	["Багажник",format ["Вы взяли %1 %2 из багажника",_amount,_item call fnc_getItemName],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	(format ["[%1|%2|%3] took %4 %5 from %6 trunk", name player, getPlayerUID player, side player, _amount, _item, str _veh]) remoteExec ["fnc_logMyStuff",2];
	
};
publicVariable "fnc_takeItemFromTrunk";
fnc_gatherToTrunk = {
	private ["_veh","_item","_amount","_invamount","_avail","_trunkitems","_trunkamounts", "_maxweight","_weight","_droppable"];
	_veh = _this select 0;
	_item = _this select 1; //inventory_items select (_this select 1)
	_amount = _this select 2;
	if (isNil "_item") exitWith {};
	if (isNil "_amount") exitWith {};
	//if ((_amount<1) or ((_amount/1)!=round(_amount/1))) exitWith {["Багажник","Неправильное число",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	if (_amount <1) exitWith {};
	_trunkitems = _veh getVariable "trunkitems";
	_trunkamounts = _veh getVariable "trunkamounts";
	_maxweight = (typeOf _veh) call fnc_getItemTrunk;
	_itemweight = (_item call fnc_getItemWeight);
	_weight = 0;
	{
		_weight = _weight + (_x call fnc_getItemWeight)*(_trunkamounts select _forEachIndex);
	} foreach _trunkitems;
	_avail = 0;
	if (_itemweight == 0) then {
		_avail = _amount;
	} else {
		_avail = floor((_maxweight - _weight)/_itemweight);
	};
	if (_amount>_avail) then {_amount=_avail};
	//if (_amount>_invamount) then {_amount=_invamount};
	[_veh,_item,_amount] call fnc_addTrunkItem;
	//[_item,_amount] call fnc_removeItem;
	//["Багажник",format ["Вы выложили %1 %2 в багажник",_amount,_item call fnc_getItemName],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	//(format ["[%1|%2|%3] has put %4 %5 to %6 trunk", name player, getPlayerUID player, side player, _amount, _item, str _veh]) remoteExec ["fnc_logMyStuff",2];
	
};
publicVariable "fnc_gatherToTrunk";
fnc_putItemToTrunk = {
	private ["_veh","_item","_amount","_invamount","_avail","_trunkitems","_trunkamounts", "_maxweight","_weight","_droppable"];
	_veh = _this select 0;
	_item = _this select 1; //inventory_items select (_this select 1)
	_droppable = (items_array select (items_classes find _item)) select 8;
	if (!_droppable) exitWith {["Багажник","Этот предмет нельзя выбросить.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	_amount = _this select 2;
	if (isNil "_item") exitWith {};
	if (isNil "_amount") exitWith {};
	if ((_amount<1) or ((_amount/1)!=round(_amount/1))) exitWith {["Багажник","Неправильное число",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	if (_amount <1) exitWith {};
	_invamount = _item call fnc_getItemAmount;
	_trunkitems = _veh getVariable "trunkitems";
	_trunkamounts = _veh getVariable "trunkamounts";
	_maxweight = (typeOf _veh) call fnc_getItemTrunk;
	_itemweight = (_item call fnc_getItemWeight);
	_weight = 0;
	{
		_weight = _weight + (_x call fnc_getItemWeight)*(_trunkamounts select _forEachIndex);
	} foreach _trunkitems;
	_avail = 0;
	if (_itemweight == 0) then {
		_avail = _amount;
	} else {
		_avail = floor((_maxweight - _weight)/_itemweight);
	};
	if (_amount>_avail) then {_amount=_avail};
	if (_amount>_invamount) then {_amount=_invamount};
	[_veh,_item,_amount] call fnc_addTrunkItem;
	[_item,_amount] call fnc_removeItem;
	["Багажник",format ["Вы выложили %1 %2 в багажник",_amount,_item call fnc_getItemName],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	(format ["[%1|%2|%3] has put %4 %5 to %6 trunk", name player, getPlayerUID player, side player, _amount, _item, str _veh]) remoteExec ["fnc_logMyStuff",2];
	
};
publicVariable "fnc_putItemToTrunk";
fnc_getNatName = {
	
	(nat_array select (nat_array_classes find _this)) select 1
	
};
publicVariable "fnc_getNatName";
fnc_getNatReligions = {
	
	(nat_array select (nat_array_classes find _this)) select 2
	
};
publicVariable "fnc_getNatReligions";
fnc_getNatNames = {
	
	(nat_array select (nat_array_classes find _this)) select 3
	
};
publicVariable "fnc_getNatNames";
fnc_getNatLastNames = {
	
	(nat_array select (nat_array_classes find _this)) select 4
	
};
publicVariable "fnc_getNatLastNames";
fnc_getNatFaces = {
	
	(nat_array select (nat_array_classes find _this)) select 5
	
};
publicVariable "fnc_getNatFaces";
fnc_getRelName = {
	
	(rel_array select (rel_array_classes find _this)) select 1
	
};
publicVariable "fnc_getRelName";
fnc_openCharacterRollDialog = {
	
	skillpts = 100;
	
	createDialog "char_roll_dialog";
	
	(findDisplay 1488228) displaySetEventHandler ["KeyDown","if((_this select 1) == 1) then {true}"]; //Block the ESC menu
	
	private ["_nation","_religion","_background","_face","_dialog","_natregskills","_chartext","_photo"];
	
	_nation = selectRandom ["chernorussian","chernorussian","chernorussian","chernorussian","chernorussian","russian","russian","russian","russian","zagortatar"];	
	_religion = selectRandom (_nation call fnc_getNatReligions);
	_face = selectRandom (_nation call fnc_getNatFaces);
	_background = selectRandom ["exmilitary","factoryworker","sportsman","engineer"];
	
	nationality = _nation;
	religion = _religion;
	
	addiction = [];
	addiction_level = [];
	
	switch _background do {	
		case "exmilitary": {		
			shootingskill = round (random 20) + 20;
			battleskill = round (random 20) + 10;
			lockpickskill = 0;
			engskill = round (random 10);
			strengthskill = round (random 10);
			staminaskill = round (random 10);
		};
		case "factoryworker": {		
			shootingskill = round (random 5) + 5;
			battleskill = round (random 5) + 5;
			lockpickskill = round (random 5) + 5;
			engskill = round (random 10) + 10;
			strengthskill = round (random 30) + 10;
			staminaskill = round (random 10);			
		};
		case "sportsman": {		
			shootingskill = round (random 5) + 5;
			battleskill = round (random 5) + 5;
			lockpickskill = 0;
			engskill = round (random 10);
			strengthskill = round (random 5) + 30;
			staminaskill = round (random 5) + 30;			
		};
		case "engineer": {		
			shootingskill = round (random 5) + 5;
			battleskill = round (random 5) + 5;
			lockpickskill = 0;
			engskill = round (random 30) + 30;
			strengthskill = round (random 5) + 5;
			staminaskill = round (random 5) + 5;
		};	
	};
	
	if ((str player) in cop_array) then {
	
		if (shootingskill<50) then {shootingskill=50};
	
	};
	
	_dialog = findDisplay 1488228;
	_natregskills = _dialog displayCtrl 1101;
	_chartext = _dialog displayCtrl 1102;
	
	ctrlSetText [1100, format ["szag_data\pics\faces\%1.paa",_face]];
	
	_natregskills ctrlSetStructuredText parseText format ["Национальность: <t color='#00ff00'>%1</t><br/>Вероисповедание: <t color='#00ff00'>%2</t><br/>Навыки:<br/>Стрельба: <t color='#00ff00'>%3</t>/<t color='#00ff00'>100</t><br/>Боевой опыт: <t color='#00ff00'>%4</t>/<t color='#00ff00'>100</t><br/>Взлом: <t color='#00ff00'>%5</t>/<t color='#00ff00'>100</t><br/>Инженерное дело: <t color='#00ff00'>%6</t>/<t color='#00ff00'>100</t><br/>Сила: <t color='#00ff00'>%7</t>/<t color='#00ff00'>100</t><br/>Выносливость: <t color='#00ff00'>%8</t>/<t color='#00ff00'>100</t>",_nation call fnc_getNatName,_religion call fnc_getRelName,shootingskill,battleskill,lockpickskill,engskill,strengthskill,staminaskill];
	
	rp_face = _face;
	player setVariable ["rp_face_var",rp_face,true];
	[player, rp_face] remoteExec ["setFace"];
			
	charname = selectRandom (nationality call fnc_getNatNames);
	charlastname = selectRandom (nationality call fnc_getNatLastNames);
	role_id = currentchar;
	currentchar = currentchar + 1;
	publicVariable "currentchar";
	
	player setVariable ["charname",charname,true];
	player setVariable ["charlastname",charlastname,true];
	player setVariable ["role_id",role_id,true];
	
	rp_firsttimewakeup = 0;
	
	waitUntil {(rp_firsttimewakeup == 0) and (isNull (findDisplay 1488228))};
	
	[] spawn fnc_openRespawnDialog;
	/*
	{
		lbAdd [2100, _x call fnc_getNatName];
		lbSetData [2100, (lbSize 2100)-1, _x];
		//systemChat str (lbData [2100, (lbSize 2100)-1]);
	} forEach nat_array_classes;
	
	lbSetCurSel [2100,0];
	
	ctrlSetText [1003,format ["Доступно очков для распределения: %1",skillpts]];
	
	sliderSetRange [1100, 0, 100];
	sliderSetRange [1101, 0, 100];
	sliderSetRange [1102, 0, 100];
	sliderSetRange [1103, 0, 100];
	sliderSetRange [1104, 0, 100];
	sliderSetRange [1105, 0, 100];
		
	sliderSetSpeed [1100, 1, 10];
	sliderSetSpeed [1101, 1, 10];
	sliderSetSpeed [1102, 1, 10];
	sliderSetSpeed [1103, 1, 10];
	sliderSetSpeed [1104, 1, 10];
	sliderSetSpeed [1105, 1, 10];
	
	waitUntil {isNull (findDisplay 1488228)};*/
	
	/*if (rp_firsttimewakeup==1) then {
		
		hint "Вы должны нажать кнопку START!";
		[] spawn fnc_openCharacterRollDialog;
		
	};*/
	
};
publicVariable "fnc_openCharacterRollDialog";
fnc_characterRolled = {
		
	nationality = lbData [2100, lbCurSel 2100];
	religion = lbData [2101, lbCurSel 2101];
	
	//systemChat format ["123 %1",religion];
	addiction = [];
	addiction_level = [];
	shootingskill = (parseNumber (ctrlText 1010));
	battleskill = (parseNumber (ctrlText 1011));
	lockpickskill = (parseNumber (ctrlText 1012));
	engskill = (parseNumber (ctrlText 1013));
	strengthskill = (parseNumber (ctrlText 1014));
	staminaskill = (parseNumber (ctrlText 1015));
		
	charname = selectRandom (nationality call fnc_getNatNames);
	charlastname = selectRandom (nationality call fnc_getNatLastNames);
	
	player setVariable ["charnames",[charname,charlastname],true];
	
	rp_firsttimewakeup = 0;
	
	closeDialog 0;	
	
};
publicVariable "fnc_characterRolled";
fnc_charNatChanged = {
	
	private ["_combobox","_value","_rels"];
	
	_combobox = _this select 0;
	_value = _this select 1;
	_rels = [];
	
	lbClear 2101;
		
	{
		if !(_x in _rels) then {
			lbAdd [2101, _x call fnc_getRelName];		
			lbSetData [2101, (lbSize 2101)-1, _x];
			_rels pushBack _x;
		};
	} forEach ((_combobox lbData _value) call fnc_getNatReligions);
	
	lbSetCurSel [2101,0];
	
};
publicVariable "fnc_charNatChanged";
fnc_skillValueChanged = {
	
	private ["_slider","_value","_number","_difference","_olddata","_newskillpts"];
	
	_slider = _this select 0;
	_value = _this select 1;
	_value = (round (_value/1))*1;
	_number = _this select 2;
	_olddata = (parseNumber (ctrlText _number));
	_difference = (_value - _olddata);
	_newskillpts = (skillpts - _difference);
	
	if !(_newskillpts < 0) then {
		_slider sliderSetPosition _value;
		ctrlSetText [_number,str _value];
		skillpts = _newskillpts;
		ctrlSetText [1003,format ["Доступно очков для распределения: %1",skillpts]];
	} else {
		_slider sliderSetPosition _olddata;
	};
	
};
publicVariable "fnc_skillValueChanged";
fnc_paintJobMenu = {
	
	private ["_vehicle"];
	
	_vehicle = vehicle player;
	
	if (_vehicle==player) exitWith {};
	if ((driver _vehicle)!=player) exitWith {["Покраска","Вы должны быть на месте водителя.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};	
	if ((vehicle_colors_classes find (typeOf _vehicle))<0) exitWith {["Покраска","Данный транспорт нельзя перекрасить.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	
	createDialog "paintjob_dialog";
	
	{
		
		if (call compile (_x select 3)) then {
			
			lbAdd [1500,format ["%1 %2 CRK", _x select 0, _x select 2]];
			lbSetData [1500, (lbSize 1500)-1, str (_x select 1)];
			lbSetValue [1500, (lbSize 1500)-1, _x select 2];
			
		};
		
	} forEach ((vehicle_colors select (vehicle_colors_classes find (typeOf _vehicle))) select 1);
	
};
publicVariable "fnc_paintJobMenu";
fnc_paintJobDoIt = {
	
	private ["_vehicle", "_index", "_texture", "_price"];
	
	_vehicle = vehicle player;
	
	if (_vehicle==player) exitWith {};
	if ((driver _vehicle)!=player) exitWith {["Покраска","Вы должны быть на месте водителя.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	
	_texture = call compile (lbData [1500, lbCurSel 1500]);
	_price = lbValue [1500, lbCurSel 1500];
	
	if (("money" call fnc_getItemAmount)<_price) exitWith {closeDialog 0; ["Покраска","Недостаточно денег!",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	
	closeDialog 0;
	
	["money",_price] call fnc_removeItem;
	
	{
		_vehicle setObjectTextureGlobal [_forEachIndex,_x];
	} forEach _texture;
	//_vehicle setObjectTextureGlobal [0,_texture];
	_vehicle setVariable ["tuning_data",[_texture,0],true];
	
};
publicVariable "fnc_paintJobDoIt";
fnc_becomeVehOwner = {
	
	private ["_vehicle"];
	
	_vehicle = vehicle player;
	
	if ((driver _vehicle)!=player) exitWith {["Перебивка транспорта","Вы должны быть на месте водителя.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	if (("money" call fnc_getItemAmount)<50000) exitWith {["Перебивка транспорта","Недостаточно денег.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	if (((_vehicle getVariable ["owner","server"])==(getPlayerUID player)) and !(_vehicle getVariable ["policevehicle",false])) exitWith {["Перебивка транспорта","Вы и так владелец этой техники.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	
	["money",50000] call fnc_removeItem;
	
	_vehicle setVariable ["owner", getPlayerUID player, true];
	_vehicle setVariable ["policevehicle", false, true];
	
	["Перебивка транспорта","Теперь это ваша техника. До новых встреч!",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	
};
publicVariable "fnc_becomeVehOwner";
fnc_impoundVehicle = {
	
	private ["_vehicle","_regplate","_result","_garage","_allowedTypes","_allow"];
	
	_vehicle = vehicle player;
	
	_regplate = _vehicle getVariable ["regplate","none"];
			
	_result = ("extDB3" callExtension format ["0:SQL:SELECT COUNT(*) From vehicles WHERE regplate = %1", _regplate]);
			
	_result = (((call compile _result) select 1) select 0) select 0;
	
	if (_result==0) then {
		
		private ["_code","_args"];
				
		_code = {
					
			private ["_string"];
					
			_string = ["0:SQL:INSERT INTO vehicles (classname,owner,regplate,damage,fuel,upgrade_data,garage,shtraf,items,itemscargo,magazinescargo) VALUES ('",_this select 0,"','",str (_this select 10),"',",_this select 1,",",_this select 2,",",_this select 3,",'",str (_this select 4),"','",(_this select 5),"',",_this select 6,",'",_this select 7,"','",_this select 8,"','",_this select 9,"')"] joinString "";
												
			("extDB3" callExtension _string)
				
		};
				
		_args = [str (typeOf _vehicle), _regplate, getDammage _vehicle, fuel _vehicle, toArray (str (_vehicle getVariable ["tuning_data",["none",0]])), str _garage, 0, [_vehicle getVariable ["trunkitems",[]],_vehicle getVariable ["trunkamounts",[]]], [weaponsItemsCargo _vehicle, itemCargo _vehicle], magazinesAmmoCargo _vehicle, _vehicle getVariable ["owner","server"]];
			
		_args call _code;
				
	} else {
				
				
		_code = {
					
			private ["_string"];
				
			_string = ["0:SQL:UPDATE vehicles SET damage = ", _this select 1, ", fuel = ",_this select 2,", upgrade_data = '",_this select 3,"', garage = '",_this select 4,"', shtraf = ",_this select 5, ", items = '", _this select 6, "', itemscargo = '", _this select 7, "', magazinescargo = '", _this select 8,  "' WHERE regplate = ", _this select 0] joinString "";
												
			//copyToClipboard _string;
				
			("extDB3" callExtension _string)
				
		};
				
		_args = [_regplate, getDammage _vehicle, fuel _vehicle, toArray (str (_vehicle getVariable ["tuning_data",["none",0]])), str _garage, 0, [_vehicle getVariable ["trunkitems",[]],_vehicle getVariable ["trunkamounts",[]]], [weaponsItemsCargo _vehicle, itemCargo _vehicle], magazinesAmmoCargo _vehicle];
							
		_args call _code;				
				
	};
	
	servervehiclesarray = servervehiclesarray - [str _vehicle];
	publicVariable "servervehiclesarray";
			
	deleteVehicle _vehicle;
	
	["Эвакуация","Транспорт эвакуирован.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	
};
publicVariable "fnc_impoundVehicle";
fnc_storeVeh_remote_1 = {
					
			private ["_string"];
					
			_string = ["0:SQL:INSERT INTO vehicles (classname,owner,regplate,damage,fuel,upgrade_data,garage,shtraf,items,itemscargo,magazinescargo) VALUES ('",_this select 0,"','",str (_this select 10),"',",_this select 1,",",_this select 2,",",_this select 3,",'",str (_this select 4),"','",(_this select 5),"',",_this select 6,",'",_this select 7,"','",_this select 8,"','",_this select 9,"')"] joinString "";
												
			("extDB3" callExtension _string)
				
		};
publicVariable "fnc_storeVeh_remote_1";
fnc_storeVeh_remote_2 = {
					
			private ["_string"];
				
			_string = ["0:SQL:UPDATE vehicles SET damage = ", _this select 1, ", fuel = ",_this select 2,", upgrade_data = '",_this select 3,"', garage = '",_this select 4,"', shtraf = ",_this select 5, ", items = '", _this select 6, "', itemscargo = '", _this select 7, "', magazinescargo = '", _this select 8,  "' WHERE regplate = ", _this select 0] joinString "";
																
			("extDB3" callExtension _string)
				
		};
publicVariable "fnc_storeVeh_remote_2";
fnc_storeVeh_zapros = {
	("extDB3" callExtension format ["0:SQL:SELECT COUNT(*) From vehicles WHERE regplate = %1", _this select 0])
};
publicVariable "fnc_storeVeh_zapros";
fnc_storeVehicle = {
	
	private ["_vehicle","_regplate","_result","_garage","_allowedTypes","_allow"];
	
	_garage = _this select 0;
	
	_allowedTypes = _garage call fnc_getGarageTypes;
	_allow = false;
	
	_vehicle = vehicle player;
	
	{
	
		if (_vehicle isKindOf _x) then {_allow = true;};
	
	} forEach _allowedTypes;
	
	if !(_allow) exitWith {["Гараж","Данный гараж не предназначен для вашей техники.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	
	if ((_vehicle getVariable ["owner","none"])!=(getPlayerUID player)) exitWith {["Гараж","Вы не можете сохранить эту машину. Сначала овладейте ей во ВСЕХ смыслах.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	if (_vehicle getVariable ["policevehicle",false]) exitWith {["Гараж","Вы не можете сохранить эту машину. Сначала овладейте ей во ВСЕХ смыслах.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	
	_regplate = _vehicle getVariable ["regplate","none"];
			
	_result = [fnc_storeVeh_zapros,[_regplate]] call fnc_getResult;
	
	_result = (((call compile _result) select 1) select 0) select 0;
	
	if (_result==0) then {
		
		private ["_code","_args"];
				
		_args = [str (typeOf _vehicle), _regplate, getDammage _vehicle, fuel _vehicle, toArray (str (_vehicle getVariable ["tuning_data",["none",0]])), str _garage, 0, [_vehicle getVariable ["trunkitems",[]],_vehicle getVariable ["trunkamounts",[]]], [weaponsItemsCargo _vehicle, itemCargo _vehicle, getBackpackCargo _vehicle], magazinesAmmoCargo _vehicle, _vehicle getVariable ["owner","server"]];
			
		_args remoteExec ["fnc_storeVeh_remote_1",2];
				
	} else {
	
		private ["_code","_args"];
								
		_args = [_regplate, getDammage _vehicle, fuel _vehicle, toArray (str (_vehicle getVariable ["tuning_data",["none",0]])), str _garage, 0, [_vehicle getVariable ["trunkitems",[]],_vehicle getVariable ["trunkamounts",[]]], [weaponsItemsCargo _vehicle, itemCargo _vehicle, getBackpackCargo _vehicle], magazinesAmmoCargo _vehicle];
							
		_args remoteExec ["fnc_storeVeh_remote_2",2];		
				
	};
	
	servervehiclesarray = servervehiclesarray - [str _vehicle];
	publicVariable "servervehiclesarray";
			
	deleteVehicle _vehicle;
	
	["Гараж","Транспорт поставлен в гараж.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	
};
publicVariable "fnc_storeVehicle";
fnc_retrieveVehicle = {
	
	private ["_array","_vplate","_vtype","_vtrunkitems","_vcargobackpacks","_vtrunkamounts","_vcargo","_veh","_params","_spawn","_vehname","_vtuning"];
	_array = garage_array select _this;
	if (isNil "_array") exitWith {};
	
	//_spawn = call compile "garage_1_spawn";
	_spawn = call compile garagespawn;
	
	//classname,regplate,damage,fuel,upgrade_data,items,itemscargo,magazinescargo
	
	//garage_array deleteAt _this;	
	
	_vtype = (_array select 0);
	_vplate = str (_array select 1);
	_vtuning = call compile (toString (_array select 4));
	_vtrunkitems = (_array select 5) select 0;
	_vtrunkamounts = (_array select 5) select 1;
	_vcargowep = (_array select 6) select 0;
	_vcargoitems = (_array select 6) select 1;
	_vcargobackpacks = (_array select 6) select 2;
	_vcargomag = (_array select 7);
		
	//systemChat str _vtuning;
		
	_vehname = format ["veh_%1",_vplate];
			
	call compile format ["%1 = createVehicle [_vtype, getPos _spawn, [], 15, ''];",_vehname];		
			
	_veh = call compile _vehname;
			
	/*
	_veh setVehicleVarName format ["veh%1",_vplate];
	call compile format ["%1 = %2;",format ["veh%1",_vplate],_vehname];
	*/
	
	[_veh,_vplate] remoteExec ["fnc_vehicleVarNameRemote",0,true];
	missionNamespace setVariable [format ["veh%1",_vplate],_veh,true];
	
	_veh remoteExec ["fnc_offroadSpeedLimit",2];
			
	_params = [];
	
	_veh setVariable ["tuning_data",["none",0],true];
			/*
	if ((count _params) == 1) then {
				
		//_params = _params select 0;
		{
			_veh setObjectTextureGlobal [_forEachIndex,_x];
		} forEach _params;
		_veh setVariable ["tuning_data",[_params,0],true];
				
	};*/			
	
	_veh setVariable ["owner",getPlayerUID player,true];
	
	publicVariable format ["veh%1",_vplate];
	servervehiclesarray pushBack format ["veh%1",_vplate];
	publicVariable "servervehiclesarray";
	
	//[_veh, format ["veh%1",_vplate]] remoteExec ["fnc_eternalVehicleReport",0,true];
	
			
	_veh lock true;
	_veh setDir (getDir _spawn);
	clearWeaponCargoGlobal _veh;
	clearMagazineCargoGlobal _veh;
	clearItemCargoGlobal _veh;
	clearBackpackCargoGlobal _veh;
	_veh setVariable ["regplate", _vplate, true];
	_veh setVariable ["trunkitems", _vtrunkitems, true];
	_veh setVariable ["trunkamounts", _vtrunkamounts, true];
	
	//[[["hgun_Pistol_Signal_F","","","",[],""]],["CUP_U_C_Citizen_02"]]
	//[[["CUP_arifle_AK74","","","",[],""],["CUP_arifle_AK74","","","",[],""],["CUP_arifle_AK74","","","",[],""],["hgun_P07_F","","","",[],""]],[]]
	
	{
		_veh addItemCargoGlobal [_x select 0, 1];	
		if ((_x select 1)!="") then {
			_veh addItemCargoGlobal [_x select 1, 1];
		};
		if ((_x select 2)!="") then {
			_veh addItemCargoGlobal [_x select 2, 1];
		};
		if ((_x select 3)!="") then {
			_veh addItemCargoGlobal [_x select 3, 1];
		};
		//systemChat str (_x select 4);
		if (count (_x select 4)>0) then {
			_veh addMagazineAmmoCargo [(_x select 4) select 0, 1, (_x select 4) select 1];
		};
		
		//todo - добавить сохранение сошек		
		
	} forEach _vcargowep;
	
	{
		_veh addItemCargoGlobal [_x, 1];		
	} forEach _vcargoitems;
	
	{
		_veh addBackpackCargoGlobal [_x, (_vcargobackpacks select 1) select _forEachIndex];
	} forEach (_vcargobackpacks select 0);
	
	{
		_veh  addMagazineAmmoCargo [_x select 0, 1, _x select 1];
	} foreach _vcargomag;
	
	["Гараж","Ваш транспорт готов, мсье.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	
	sleep 0.5;
	
	_veh setVariable ["tuning_data",_vtuning,true];
	
	if !(((_vtuning select 0) select 0)=="none") then {
		{
			_veh setObjectTextureGlobal [_forEachIndex,_x];
		} forEach (_vtuning select 0);
	};
	
};
publicVariable "fnc_retrieveVehicle";
fnc_jobList = {
	
	private ["_jobs","joblist","_temp","_i","_i","_i","_i"];
	
	if (!(createDialog "joblist_dialog")) exitWith {hint "Dialog Error!";};
	_jobs = [];
	joblist = [];
	_temp = [];
/*
	for "_i" from 0 to (count factories_array - 1) do {
		{
			if ((_x>0) and ((((factory_money select _i) select _forEachIndex)>=_x) or ((factory_wagers select _i) select _forEachIndex == "server"))) then {
				_jobs pushBack [_i,_forEachIndex,_x];
			};
		} foreach (factory_wages select _i);
	};
	if (count _jobs > 0) then {
		for "_i" from 0 to ((count _jobs) - 1) do {
			for "_m" from 0 to ((count _jobs) - 1) do {
				if (((_jobs select _m) select 2) < ((_jobs select (_m+1)) select 2)) then {
					_temp = _jobs select (_m+1);
					_jobs set [_m+1,_jobs select _m];
					_jobs set [_m,_temp];
				};
			};
		};
	};
	{
		lbAdd [1500, format ["%1$/мин %2",(_x select 2)*60, (factories_array select (_x select 0)) select 1]];
	} foreach _jobs;
	*/
	
};
publicVariable "fnc_jobList";
fnc_collectWater = {
	
	if (collectingwater) exitWith {};
	collectingwater = true;
	player playMove "AinvPknlMstpSlayWrflDnon_medic";
	sleep 10;
	["saltwater",1] call fnc_addItem;
	["Вы набрали бочку воды.","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	collectingwater = false;
	
};
publicVariable "fnc_collectWater";
fnc_buyWorkplace = {
	
	private ["_workplace","_price"];
	
	_workplace = _this select 0;
	_price = _this select 1;
	
	if (_workplace in my_workplaces) exitWith {
		["Предприятие","Вы уже владеете этим предприятием.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	};
	if (("money" call fnc_getItemAmount)<_price) exitWith {["Предприятие","Недостаточно денег.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	
	["money", _price] call fnc_removeItem;
	
	my_workplaces pushBack _workplace;
	
	["Предприятие","Предприятие успешно куплено! Теперь вы получаете увеличенный доход.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	
};
publicVariable "fnc_buyWorkplace";
fnc_dropAllItems = {
	
	private ["_droppable"];
	
	while {count inventory_amount > 0} do {
		
		_droppable = (items_array select (items_classes find (inventory_items select 0))) select 8;
		
		if (!_droppable) then {
			
			inventory_items deleteAt 0;
			inventory_amount deleteAt 0;
			
		} else {
	
			[0,inventory_amount select 0] call fnc_dropItem;
		
		};
		
	};
	
	_holder = dummy;
	if (count ((getPos player) nearObjects ["GroundWeaponHolder",2]) < 1) then {
		_holder = createVehicle ["GroundWeaponHolder", getPosATL player, [], 0, "CAN_COLLIDE"];
	} else {
		_holder = ((getPos player) nearObjects ["GroundWeaponHolder",2]) select 0;
	};
	_holder addItemCargoGlobal [holsterGun, 1];
	_holder addMagazineAmmoCargo [holsterGunMagazine, 1, holsterGunRounds];
	holsterGun = "";
	holsterGunMagazine = "";
	holsterGunRounds = 0;	
};
publicVariable "fnc_dropAllItems";
fnc_dropAllWeapons = {
	private ["_uniform","_vest","_backpack","_assigned_items","_weps","_mags","_items"];
	_uniform = uniform player;
	_vest = vest player;
	_backpack = backpack player;
	_weps = ([primaryWeapon player, secondaryWeapon player, handgunWeapon player]);
	_assigned_items = assignedItems player;
	
	_mags = magazinesAmmoFull player;
	//_items = (items player);
	_items = [];
	
	if (_uniform != "") then {
		_items = _items + (itemCargo (uniformContainer player));
	};
	if (_vest != "") then {
		_items = _items + (itemCargo (vestContainer player));
	};
	if (_backpack != "") then {
		_items = _items + (itemCargo (backpackContainer player));
	};
		
	_holder = dummy;
	if (count ((getPos player) nearObjects ["GroundWeaponHolder",2]) < 1) then {
		_holder = createVehicle ["GroundWeaponHolder", getPosATL player, [], 0, "CAN_COLLIDE"];
	} else {
		_holder = ((getPos player) nearObjects ["GroundWeaponHolder",2]) select 0;
	};
	{
		_holder addItemCargoGlobal [_x, 1];
	} foreach (_assigned_items+_weps+_items);
	{
		_holder addMagazineAmmoCargo [_x select 0, 1, _x select 1];
	} foreach (_mags);
	
	removeAllItems player;
	removeAllAssignedItems player;
	removeAllWeapons player;
	
	
};
publicVariable "fnc_dropAllWeapons";
fnc_dropAllDress = {
	private ["_uniform","_vest","_backpack","_helmet","_ochki","_assigned_items","_weps","_mags","_items"];
	_uniform = uniform player;
	_vest = vest player;
	_backpack = backpack player;
	_helmet = headgear player;
	_ochki = goggles player;
	_assigned_items = assignedItems player;
	_weps = ([primaryWeapon player, secondaryWeapon player, handgunWeapon player]);
	
	_mags = magazinesAmmoFull player;
	//_items = (items player);
	_items = [];
	
	if (_uniform != "") then {
		_items = _items + (itemCargo (uniformContainer player));
	};
	if (_vest != "") then {
		_items = _items + (itemCargo (vestContainer player));
	};
	if (_backpack != "") then {
		_items = _items + (itemCargo (backpackContainer player));
	};
		
	_holder = dummy;
	if (count ((getPos player) nearObjects ["GroundWeaponHolder",2]) < 1) then {
		_holder = createVehicle ["GroundWeaponHolder", getPosATL player, [], 0, "CAN_COLLIDE"];
	} else {
		_holder = ((getPos player) nearObjects ["GroundWeaponHolder",2]) select 0;
	};
	{
		_holder addItemCargoGlobal [_x, 1];
	} foreach ([_uniform,_vest,_backpack,_helmet,_ochki]+_assigned_items+_weps+_items);
	{
		_holder addMagazineAmmoCargo [_x select 0, 1, _x select 1];
	} foreach (_mags);
	
	removeUniform player;
	removeVest player;
	removeBackpack player;
	removeAllAssignedItems player;
	removeHeadgear player;
	removeGoggles player;
	removeAllWeapons player;
	
	
};
publicVariable "fnc_dropAllDress";
fnc_govManKilled_remoteMessage = {
				
				["СРОЧНОЕ СООБЩЕНИЕ!",format ["Губернатор %1 был убит! Все голоса были сброшены!",_this select 0],[1,1,1,1],[0,0,0.5,0.8]] spawn fnc_notifyMePls;
				
			};
			
publicVariable "fnc_govManKilled_remoteMessage";
fnc_killed = {
	
	private ["_gang","_playerid","_gangowner","_gangdeputies","_gangmembers","_gangmembersnames","_index","_gangindex","_killer","_code","_args"];
	
	call fnc_dropAllItems;
	removeAllActions player;
	
	respawntime = respawntime+jailtimeleft;
	timetorespawn = respawntime;
	isdead = true;
	
	player setVariable ["search",false,true];
	player setVariable ["restrained",false,true];
	
	restrained_punish = 0;
	
	_killer = _this select 1;
	
	(format ["[%1|%2|%3] has killed [%4|%5|%6] at %7 while being at %8", name _killer, getPlayerUID _killer, side _killer, name player, getPlayerUID player, side player, getPos player, getPos _killer]) remoteExec ["fnc_logMyStuff",2];
	
	//if (_killer!=player) then {
	if true then {
		
		//if ((player distance (getMarkerPos "rp_kill_marker") <= 100) and ((getPlayerUID player) in execute_players_array)) then {
		if ((player distance (getMarkerPos "rp_kill_marker") <= 100)) then {
		
			private ["_mycheck"];
		
			_mycheck = true;
			
			rp_firsttimewakeup = 1;
			
			//_index = execute_players_array find (getPlayerUID player);
			
			//execute_players_array deleteAt _index;
			//execute_players_array_names deleteAt _index;
				
			//если есть лица террориста
			
			if (("terrorist" in (licenses+licenses_illegal)) or ("napa" in (licenses+licenses_illegal)) or ("ig_lic" in (licenses+licenses_illegal))) then {
				
				rp_firsttimewakeup = 1;
				
				licenses_illegal = licenses_illegal - ["terrorist"];
				
				licenses_illegal = [];
				if (((cooldown_array select 0) find "gun_cd")<0) then {
					
					(cooldown_array select 0) pushBack "gun_cd";
					(cooldown_array select 1) pushBack 30;
					
				} else {
					
					(cooldown_array select 1) set [(cooldown_array select 0) find "gun_cd", 30];
					
				};
				
				[getPlayerUID player] spawn fnc_setPlayerUnWanted;
				
				_mycheck = false;
				
			};
			
			//если игрок губернатор
			
			if (current_governor==(getPlayerUID player)) then {
				
				rp_firsttimewakeup = 1;
				
				licenses_illegal = [];
							
				_args = [[player,true] call fnc_getRealName];
				
				_args remoteExec ["fnc_govManKilled_remoteMessage"];
				
				current_governor = "server";
				publicVariable "current_governor";
				current_governor_name = "никто";
				publicVariable "current_governor_name";
				people_voted = [];
				publicVariable "people_voted";
				people_votes = [];
				publicVariable "people_votes";
				people_votes_names = [];
				publicVariable "people_votes_names";
				
				[getPlayerUID player] spawn fnc_setPlayerUnWanted;
				
				_mycheck = false;
				
			};
			
			//если игрок кого-то убивал
			if (killed_players_pts>1) then {
				
				licenses_illegal = [];
							
				if (((cooldown_array select 0) find "gun_cd")<0) then {
					
					(cooldown_array select 0) pushBack "gun_cd";
					(cooldown_array select 1) pushBack 30;
					
				} else {
					
					(cooldown_array select 1) set [(cooldown_array select 0) find "gun_cd", 30];
					
				};
				
				killed_players_pts = 0;
				
				_mycheck = false;
				
			};
		
			//разбираемся с группировкой
		
			if ((call fnc_getMyGang)!="none") then {
				
				licenses_illegal = [];
				rp_firsttimewakeup = 1;
				
				_playerid = getPlayerUID player;
				
				_gang = gangs_online select (gangs_online_players find _playerid);
				
				_gangowner = (global_gangs_array select (global_gangs_array_names find _gang)) select 1;
				
				if (_gangowner==_playerid) then {
					
					_gangdeputies = (global_gangs_array select (global_gangs_array_names find _gang)) select 2;
					_gangmembers = (global_gangs_array select (global_gangs_array_names find _gang)) select 3;
					_gangmembersnames = (global_gangs_array select (global_gangs_array_names find _gang)) select 4;
					
					{
						_index = (gangs_online_players find _x);
						
						if (_index > -1) then {
							
							gangs_online deleteAt _index;
							publicVariable "gangs_online";
							gangs_online_players deleteAt _index;
							publicVariable "gangs_online_players";
						
						};
						
					} forEach _gangmembers;
					
					
					_gangindex = global_gangs_array_names find _gang;
					
					global_gangs_array deleteAt _gangindex;
					publicVariable "global_gangs_array";
					
					global_gangs_array_names deleteAt _gangindex;
					publicVariable "global_gangs_array_names";
					
					systemChat "Группировка удалена!";
				
				} else {
					
					[] spawn fnc_leaveGang;
					
				};
				
				if (((cooldown_array select 0) find "gang_cd")<0) then {
					
					(cooldown_array select 0) pushBack "gang_cd";
					(cooldown_array select 1) pushBack 30;
					
				} else {
					
					(cooldown_array select 1) set [(cooldown_array select 0) find "gang_cd", 30];
					
				};
				
				if (((cooldown_array select 0) find "gun_cd")<0) then {
					
					(cooldown_array select 0) pushBack "gun_cd";
					(cooldown_array select 1) pushBack 30;
					
				} else {
					
					(cooldown_array select 1) set [(cooldown_array select 0) find "gun_cd", 30];
					
				};
				
				[getPlayerUID player] spawn fnc_setPlayerUnWanted;
				
				_mycheck = false;
				
			};
			
			
			if _mycheck then {
			
				//systemChat "чекаем";
					
				if ((isPlayer _killer) and (_killer!=player) and !((getPlayerUID player) in wanted_players_list) and (holsterGun == "") and ((primaryWeapon player) == "") and ((secondaryWeapon player) == "") and ((handgunWeapon player) == "")) then {
				
					if !(((typeOf (vehicle player)) in ["QIN_Octavia_POLICIE_rdsciv","QIN_SUV_POLICIE","QIN_Offroad_POLICIE"]) and (player == (driver (vehicle player))) and ((str _killer) in cop_array)) then {
				
						systemChat "Вы были убиты будучи безоружным и не находясь в розыске, вы получаете компенсацию в размере 50'000 CRK.";
						
						deposit = deposit + 50000;
						
						_killer remoteExec ["fnc_punishForBadKill"];
					
					};
				
				};
			
			};
				
			[getPlayerUID player] spawn fnc_setPlayerUnWanted;
			
		};		
	};
	
	if ((_killer!=player) and ((str player) in cop_array)) then {
			
		if !((str _killer) in cop_array) then {		
			[getPlayerUID _killer, "Убийство", 200000, [_killer,true] call fnc_getRealName] call fnc_setPlayerWanted;
		};
	};
	
	private ["_nearVehicles"];
	
	_nearVehicles = nearestObjects [getpos player, ["LandVehicle"], 5];
	
	if (_killer==player) then {
	
		
	};
	
	if ((_killer!=player) and (_killer!=(driver (vehicle player))) and !((str player) in cop_array) and ((player distance (getMarkerPos "rp_kill_marker") > 100))) then {
	
		private ["_mycheck"];
		
		_mycheck = true;
		
		if !((str _killer) in cop_array) then {		
			if (isPlayer _killer) then {
				[getPlayerUID _killer, "Убийство", 200000, [_killer,true] call fnc_getRealName] call fnc_setPlayerWanted;
				[_killer] remoteExec ["fnc_addKillPts"];
			};
		};
	
		if (((str _killer) in cop_array) and ((wanted_players_list find (getPlayerUID player))>-1)) then {
		
			[getPlayerUID player, _killer] remoteExec ["fnc_gimmeBounty"];
		
			if (((cooldown_array select 0) find "gun_cd")<0) then {
						
				(cooldown_array select 0) pushBack "gun_cd";
				(cooldown_array select 1) pushBack 30;
						
			} else {
						
				(cooldown_array select 1) set [(cooldown_array select 0) find "gun_cd", 30];
						
			};
			//[getPlayerUID player] spawn fnc_setPlayerUnWanted;
			
		};
		
		//_killer remoteExec ["fnc_removeGunLicense"];
		
		if(typename _nearVehicles == "STRING") then  {
		
			_killer remoteExec ["fnc_removeGunLicense"];
		
		} else {
		
			private ["_yass"];
			
			_yass = true;
			{
				if (  (speed _x > 10) and (!(isNull(driver _x)))  and (isPlayer _killer) and (player!=_killer)) then 
				{
					_yass = false;
					_killer		 = driver _x;
					_killedByVehicle = true;
					_vehicle         = typeof _x;
					//_infos           = _vehicle call INV_getitemArray;
					//_killerlicense    = (_infos select 4) select 1;
					//_killerstring 	 = format["%1", _killer];
					
					_killer remoteExec ["fnc_removeCarLicense"];
				
					/*if (!((getPlayerUID player) in wanted_players_array) and (holsterGun == "") and ((primaryWeapon player) == "") and ((secondaryWeapon player) == "") and ((handgunWeapon player) == "")) then {
					
						systemChat "Вы были убиты будучи безоружным и не находясь в розыске, вы получаете компенсацию в размере 50'000 CRK.";
						
						deposit = deposit + 50000;
						
						_killer remoteExec ["fnc_punishForBadKill"];
					
					};*/
				
				};
			} forEach _nearVehicles;
			
			if _yass then {_killer remoteExec ["fnc_removeGunLicense"];};
			
		};
		
		//если есть лица террориста
		if (("terrorist" in (licenses+licenses_illegal)) or ("napa" in (licenses+licenses_illegal)) or ("ig_lic" in (licenses+licenses_illegal))) then {
			
			rp_firsttimewakeup = 1;
			
			licenses_illegal = licenses_illegal - ["terrorist"];
			
			licenses_illegal = [];
						
			if (((cooldown_array select 0) find "gun_cd")<0) then {
				
				(cooldown_array select 0) pushBack "gun_cd";
				(cooldown_array select 1) pushBack 30;
				
			} else {
				
				(cooldown_array select 1) set [(cooldown_array select 0) find "gun_cd", 30];
				
			};
			
			[getPlayerUID player] spawn fnc_setPlayerUnWanted;
			
			_mycheck = false;
			
		};
		
		//если игрок губернатор
		
		if (current_governor==(getPlayerUID player)) then {
			
			rp_firsttimewakeup = 1;
			
			licenses_illegal = [];
						
			_args = [[player,true] call fnc_getRealName];
			
			_args remoteExec ["fnc_govManKilled_remoteMessage"];
			
			current_governor = "server";
			publicVariable "current_governor";
			current_governor_name = "никто";
			publicVariable "current_governor_name";
			people_voted = [];
			publicVariable "people_voted";
			people_votes = [];
			publicVariable "people_votes";
			people_votes_names = [];
			publicVariable "people_votes_names";
			
			[getPlayerUID player] spawn fnc_setPlayerUnWanted;
			
			_mycheck = false;
			
		};
		
		//если игрок кого-то убивал
		if (killed_players_pts>1) then {
			
			licenses_illegal = [];
						
			if (((cooldown_array select 0) find "gun_cd")<0) then {
				
				(cooldown_array select 0) pushBack "gun_cd";
				(cooldown_array select 1) pushBack 30;
				
			} else {
				
				(cooldown_array select 1) set [(cooldown_array select 0) find "gun_cd", 30];
				
			};
			
		};
	
		//разбираемся с группировкой
	
		if ((call fnc_getMyGang)!="none") then {
			
			licenses_illegal = [];
			rp_firsttimewakeup = 1;
			
			_playerid = getPlayerUID player;
			
			_gang = gangs_online select (gangs_online_players find _playerid);
			
			_gangowner = (global_gangs_array select (global_gangs_array_names find _gang)) select 1;
			
			if (_gangowner==_playerid) then {
				
				_gangdeputies = (global_gangs_array select (global_gangs_array_names find _gang)) select 2;
				_gangmembers = (global_gangs_array select (global_gangs_array_names find _gang)) select 3;
				_gangmembersnames = (global_gangs_array select (global_gangs_array_names find _gang)) select 4;
				
				{
					_index = (gangs_online_players find _x);
					
					if (_index > -1) then {
						
						gangs_online deleteAt _index;
						publicVariable "gangs_online";
						gangs_online_players deleteAt _index;
						publicVariable "gangs_online_players";
					
					};
					
				} forEach _gangmembers;
				
				
				_gangindex = global_gangs_array_names find _gang;
				
				global_gangs_array deleteAt _gangindex;
				publicVariable "global_gangs_array";
				
				global_gangs_array_names deleteAt _gangindex;
				publicVariable "global_gangs_array_names";
				
				systemChat "Группировка удалена!";
			
			} else {
				
				[] spawn fnc_leaveGang;
				
			};
			
			if (((cooldown_array select 0) find "gang_cd")<0) then {
				
				(cooldown_array select 0) pushBack "gang_cd";
				(cooldown_array select 1) pushBack 30;
				
			} else {
				
				(cooldown_array select 1) set [(cooldown_array select 0) find "gang_cd", 30];
				
			};
			
			if (((cooldown_array select 0) find "gun_cd")<0) then {
				
				(cooldown_array select 0) pushBack "gun_cd";
				(cooldown_array select 1) pushBack 30;
				
			} else {
				
				(cooldown_array select 1) set [(cooldown_array select 0) find "gun_cd", 30];
				
			};
			
			[getPlayerUID player] spawn fnc_setPlayerUnWanted;
			
			_mycheck = false;
			
		};
		
		if _mycheck then {
		
			//systemChat "чекаем";
				
			if ((isPlayer _killer) and (player!=_killer) and !((getPlayerUID player) in wanted_players_array) and (holsterGun == "") and ((primaryWeapon player) == "") and ((secondaryWeapon player) == "") and ((handgunWeapon player) == "")) then {
			
				if !(((typeOf (vehicle player)) in ["QIN_Octavia_POLICIE_rdsciv","QIN_SUV_POLICIE","QIN_Offroad_POLICIE"]) and (player == (driver (vehicle player))) and ((str _killer) in cop_array)) then {
				
					systemChat "Вы были убиты будучи безоружным и не находясь в розыске, вы получаете компенсацию в размере 50'000 CRK.";
					
					deposit = deposit + 50000;
					
					_killer remoteExec ["fnc_punishForBadKill"];
				
				};
			
			};
		
		};
		
	};
	
};
publicVariable "fnc_killed";
fnc_addKillPts = {
	private ["_killer"];
	
	_killer = _this select 0;
	
	if (player==_killer) then {
	
		killed_players_pts = killed_players_pts + 1;
	
	};
};
publicVariable "fnc_addKillPts";
fnc_gimmeBounty = {
	private ["_uid","_killer","_crimelist","_bounty"];
	_uid = _this select 0;
	_killer = _this select 1;
	
	if (player == _killer) then {
	
		_crimelist = wanted_players_array select (wanted_players_list find _uid);
		
		_bounty = 0;
		
		(format ["[%1|%2|%3] has bountyhunted [%4|%5|%6] for %7 minutes, he had %8", name player, getPlayerUID player, side player, name cursearch, getPlayerUID cursearch, side cursearch, _time, _crimelist]) remoteExec ["fnc_logMyStuff",2];
		
		{		
			_bounty = _bounty + (_x select 1);
			
		} forEach _crimelist;
		
		_bounty = round (_bounty/2);
		
		["Нейтрализация",format ["Вы получили половину награды в размере %1 CRK за нейтрализацию преступника!", _bounty],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
		
		[_uid] spawn fnc_setPlayerUnWanted;
		
		deposit = deposit + _bounty;
	
	};
};
publicVariable "fnc_gimmeBounty";
fnc_punishForBadKill = {
	if (player == _this) then {
	
		systemChat "ВЫ УБИЛИ БЕЗОРУЖНОГО ИГРОКА БЕЗ РОЗЫСКА! ШТРАФ 50'000 CRK!";
		
		deposit = deposit - 50000;
		
		//roleplay_pts = roleplay_pts - 300;
		
		[300,false] call fnc_removeRPP;
	
	};
};
publicVariable "fnc_punishForBadKill";
fnc_removeGunLicense = {
	if (player == _this) then {
	
		licenses = licenses - ["huntingweapons"];
		
		systemChat "Вы лишились лицензии на оружие.";
	
	};
};
publicVariable "fnc_removeGunLicense";
fnc_removeCarLicense = {
	if (player == _this) then {
	
		licenses = licenses - ["car","truck"];
		
		systemChat "Вы лишились лицензии на вождение.";
	
	};
};
publicVariable "fnc_removeCarLicense";
fnc_fired = {
	
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
	
	if ("gun_cd" in (cooldown_array select 0)) exitWith {
		deleteVehicle _projectile;
		hint format ["Вы не можете использовать оружие ещё %1 минут!",((cooldown_array select 1) select ((cooldown_array select 0) find "gun_cd"))];
	};
	
	if (roleplay_pts<0) exitWith {
		deleteVehicle _projectile;
		hint "Вы не можете применять оружие, RPP меньше нуля!";
	};
	
	if shootingskill_cd exitWith {};
	
	[] spawn {
	
		shootingskill_cd = true;
		sleep 1;
		shootingskill_cd = false;
	
	};
	
	if ((random 1) > (shootingskill/100)) then {
	
		if ((random 1)<=0.25) then {
			shootingskill = shootingskill + 1;
		};
		
		if (shootingskill > 100) then {shootingskill = 100};
	
	};
	
	if ((random 1) > (battleskill/100)) then {
	
		battleskill = battleskill + 1;
		if (battleskill > 100) then {battleskill = 100};
	
	};
	/*shootingskill = shootingskill + 0.01;
	if (shootingskill>100) then {shootingskill=100;};*/
	
	/*battleskill = battleskill + 0.01;
	if (battleskill>100) then {battleskill=100;};*/
	
};
publicVariable "fnc_fired";
fnc_openATM = {
	if (allowuseatm>0) exitWith {
	
		["Банкомат","Ваша карта не принята!",[1,1,1,1],[0,0.68,0.47,0.8]] spawn fnc_notifyMePls;
		
	};
	
	if !(isNull (findDisplay 50001)) exitWith {};
	call fnc_closeAllShit;
	waitUntil {closedshit};
	if (!(createDialog "atm_dialog")) exitWith {hint "Dialog Error!";};			
	//ctrlSetText [1000, name player];
	((findDisplay 50001) displayCtrl 1001) ctrlSetStructuredText parseText format ["На счету<br/>%1 CRK", [deposit] call fnc_numberToText];
	
	{
	
		lbAdd [2100, name _x];
	
	} forEach playableUnits;
	//ctrlSetText [1002, format ["На руках - %1 CRK", [("money" call fnc_getItemAmount)] call fnc_numberToText]];
	
};
publicVariable "fnc_openATM";
fnc_atmTransferMoney_remote = {
	params ["_player","_money","_transferer"];
	
	if ((name player)==_player) then {
	
		deposit = deposit + _money;
		
		["Банкомат",format ["%1 совершил банковский перевод на ваше имя суммой %2 CRK.", _transferer, _money],[1,1,1,1],[0,0.68,0.47,0.8]] spawn fnc_notifyMePls;
	
	};
};
publicVariable "fnc_atmTransferMoney_remote";
fnc_atmTransferMoney = {
	private ["_player","_amount","_lb"];
	
	_lb = lbCurSel 2100;
	if (_lb<0) exitWith {hint "Выберите игрока.";};
	_player = lbText [2100, _lb];
	_amount = parseNumber (ctrlText 1400);
	
	if (deposit<_amount) then {_amount=deposit;};
	
	deposit = deposit - _amount;
	
	[_player,_amount,name player] remoteExec ["fnc_atmTransferMoney_remote"];
	
	["Банкомат","Перевод совершён.",[1,1,1,1],[0,0.68,0.47,0.8]] spawn fnc_notifyMePls;
	
	closeDialog 0;
};
publicVariable "fnc_atmTransferMoney";
fnc_buyBankInsurance = {
	
	if (("money" call fnc_getItemAmount)<(_this select 0)) exitWith {
		["Банк","Недостаточно денег.",[1,1,1,1],[0,0.68,0.47,0.8]] spawn fnc_notifyMePls;
	};
	
	["money",(_this select 0)] call fnc_removeItem;
	["bank_insurance",1] call fnc_addItem;
	
	["Банк","Вы купили банковскую страховку.",[1,1,1,1],[0,0.68,0.47,0.8]] spawn fnc_notifyMePls;
	
};
publicVariable "fnc_buyBankInsurance";
fnc_robBankSafe = {
	
	private ["_safe","_number","_action","_percentlost","_stolenmoney","_lostmoney"];
	
	_action = _this select 1;
	
	if (_action=="rob") then {
	
		if (lockpickskill<30) exitWith {["Банк","Навык взлома должен быть минимум 30.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
		if (("tub_lockpick" call fnc_getItemAmount) < 1) exitWith {["Банк","Вам нужна тубулярная отмычка. Купите её в магазине банды или сделайте на заводе снаряжения.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
		
		_safe = _this select 0;
		_action = _this select 1;
		_number = (bank_safe_array find _safe) + 1;
	
		call compile format["local_cash = robpoolsafe%1", _number];
		if (local_cash < 10000) exitwith {
			["Банк","Этот сейф был недавно ограблен, сейчас он пуст.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
		};
		
		if !(((currentWeapon player)!="") and ((currentWeapon player) in [primaryWeapon player, handgunWeapon player, secondaryWeapon player])) exitWith {
			["Банк","А угрожать чем будешь? Своим стручком?",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
		};
		
		if !(bankrobenable) exitWith {["Банк","Не удалось вскрыть сейф.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
			
		player playmove "Acts_carFixingWheel";
		
		[local_cash,"effect"] remoteExec ["fnc_robBankSafe"];
		
		sleep 17;
		
		if !(alive player) exitWith {};
		
		if (("tub_lockpick" call fnc_getItemAmount) < 1) exitWith {["Банк","Вам нужна тубулярная отмычка. Купите её в магазине банды или сделайте на заводе снаряжения.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
		
		if ((random 1)<((100-lockpickskill)/100)) then {
		
			["tub_lockpick",1] call fnc_removeItem;
			["Банк","Отмычка сломалась!",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
		
		};
		
		call compile format["local_cash = robpoolsafe%1", _number];
		if (local_cash < 10000) exitwith {
			["Банк","Этот сейф был недавно ограблен, сейчас он пуст.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
		};
		
		call compile format["robpoolsafe%1 = 0;publicvariable ""robpoolsafe%1"";", _number];
		
		bankrobenable = true;		
		["money",local_cash] call fnc_addItem;
		["Банк",format ["Вы успешно ограбили сейф на сумму %1 CRK",local_cash],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
				
		stolencash = stolencash + local_cash;
		allowuseatm = round(allowuseatm + ((local_cash/10000)*60));
		
		[local_cash,"moneyloss"] remoteExec ["fnc_robBankSafe"];
	};
	
	if (_action=="effect") then {
		
		titleText ["ВНИМАНИЕ!!! ИДЁТ ОГРАБЛЕНИЕ БАНКА!!!", "plain"];
		playSound "bank_alarm";
		
	};
	
	if (_action=="moneyloss") then {
		
		_stolenmoney = _this select 0;
		//["Bank", "civilian", _stolenmoney] spawn Isse_AddCrimeLogEntry;
		["ОГРАБЛЕНИЕ БАНКА",format["Грабитель похитил %1 CRK!", _stolenmoney],[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;
		sleep 4;
		
		_percentlost = _stolenmoney/2000000;
		if(_percentlost > 0.1)then{_percentlost == 0.1};
		_lostmoney = round(deposit*_percentlost); 
		
		if ((deposit <= _lostmoney) and (deposit >= 1) and (('bank_insurance' call fnc_getItemAmount) == 0)) then 
			{
																						
			deposit = 0;
			["ОГРАБЛЕНИЕ БАНКА","Вы потеряли последние деньги...",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
			};
							
		if ((deposit >  _lostmoney) and (('bank_insurance' call fnc_getItemAmount) == 0)) then 
			{ 
															
			deposit = deposit - _lostmoney;
			["ОГРАБЛЕНИЕ БАНКА",format["Вы потеряли %1 CRK, на вашем счету осталось %2 CRK.", _lostmoney, deposit],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
			};
																	
		if (('bank_insurance' call fnc_getItemAmount) > 0) then 
			{		
				["ОГРАБЛЕНИЕ БАНКА","Вы не потеряли деньги, но потеряли страховку.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
				['bank_insurance', 1] call fnc_removeItem;
			};
		
	};
	
};
publicVariable "fnc_robBankSafe";
/*
fnc_respawnMeOLD = {
	if ((str player) in cop_array) then {
		[] spawn fnc_initCopLoadout;
	} else {
		[] spawn fnc_initCivLoadout;
	};
	
	respawntime = 10;
	private ["_markers"];
	
	_markers = ["civrespawn_1","civrespawn_2","civrespawn_3","civrespawn_4","civrespawn_5","civrespawn_6","civrespawn_7"];
	
	if ((str player) in cop_array) then {	
		_markers = ["coprespawn_1"];
	};
	player setpos (getMarkerPos (selectRandom _markers));
	isdead = false;
	timetorespawn = respawntime;
	//call fnc_actions;
	
	hunger = 0;
	thirst = 0;
	
	blood_array = [[],[]];
	
	[] spawn fnc_clientShopsInit;
	
	if (rp_firsttimewakeup==1) then {
		
		killed_players_pts = 0;
		[] spawn fnc_openCharacterRollDialog;
	};
	
};
publicVariable "fnc_respawnMeOLD";*/
fnc_disconnect = {	
		
	private ["_unit","_id","_uid","_name","_position","_side","_alive"];
	
	_unit = _this select 0;
	deleteVehicle _unit;
	
};
publicVariable "fnc_disconnect";
fnc_govMenuSliderChanged = {
	
	private ["_slider","_value","_number","_difference","_olddata","_newskillpts"];
	
	_slider = _this select 0;
	_value = _this select 1;
	_value = (round (_value/1))*1;
	_number = _this select 2;
	
	_slider sliderSetPosition _value;
	ctrlSetText [_number, format ["%1%2",_value,"%"]];
	
};
publicVariable "fnc_govMenuSliderChanged";
fnc_govMenuSliderChanged2 = {
	
	private ["_slider","_value","_number","_difference","_olddata","_newskillpts"];
	
	_slider = _this select 0;
	_value = _this select 1;
	_value = (round (_value/5))*5;
	_number = _this select 2;
	
	_slider sliderSetPosition _value;
	ctrlSetText [_number, format ["%1 км/ч",_value]];
	
};
publicVariable "fnc_govMenuSliderChanged2";
fnc_govMenuApply = {
	
	nds_tax = (parseNumber (ctrlText 1003))/100;
	publicVariable "nds_tax";
	inc_tax = (parseNumber (ctrlText 1004))/100;
	publicVariable "inc_tax";
	town_speedlimit = parseNumber (ctrlText 1007);
	publicVariable "town_speedlimit";
	nottown_speedlimit = parseNumber (ctrlText 1008);
	publicVariable "nottown_speedlimit";
	
	handgun_legal = [false,true] select (lbCurSel 2100);
	
	closeDialog 0;
	
};
publicVariable "fnc_govMenuApply";
fnc_openGovMenu = {
	
	createDialog "gov_menu_dialog";
	
	sliderSetRange [1100, 0, 40];
	sliderSetRange [1101, 0, 40];
	sliderSetRange [1102, 50, 200];
	sliderSetRange [1103, 50, 200];
		
	sliderSetSpeed [1100, 1, 1];
	sliderSetSpeed [1101, 1, 1];
	sliderSetSpeed [1102, 1, 5];
	sliderSetSpeed [1103, 1, 5];
	
	sliderSetPosition [1100,nds_tax*100];
	sliderSetPosition [1101,inc_tax*100];
	sliderSetPosition [1102,town_speedlimit];
	sliderSetPosition [1103,nottown_speedlimit];
	
	ctrlSetText [1003,format ["%1%2",nds_tax*100,"%"]];
	ctrlSetText [1004,format ["%1%2",inc_tax*100,"%"]];
	ctrlSetText [1007,format ["%1 км/ч",town_speedlimit]];
	ctrlSetText [1008,format ["%1 км/ч",nottown_speedlimit]];
	
	lbAdd [2100,"нелегально"];
	lbAdd [2100,"легально"];
	
	ctrlSetText [1009,format ["Казна: %1 CRK", gov_money]];
	
	switch handgun_legal do {
	
		case false: {
			lbSetCurSel [2100,0];
		};
		case true: {
			lbSetCurSel [2100,1];
		};
	
	};
	
	
/*
fnc_charNatChanged = {
	
	private ["_combobox","_value","_rels"];
	
	_combobox = _this select 0;
	_value = _this select 1;
	_rels = [];
	
	lbClear 2101;
		
	{
		if !(_x in _rels) then {
			lbAdd [2101, _x call fnc_getRelName];		
			lbSetData [2101, (lbSize 2101)-1, _x];
			_rels pushBack _x;
		};
	} forEach ((_combobox lbData _value) call fnc_getNatReligions);
	
	lbSetCurSel [2101,0];
	*/
	
};
publicVariable "fnc_openGovMenu";
fnc_openElectionsMenu = {
	
	createDialog "elections_dialog";
	
	{
		
		lbAdd [1500, name _x];
		lbSetData [1500, (lbSize 1500) - 1, getPlayerUID _x];
		
	} forEach playableUnits;
	
};
publicVariable "fnc_openElectionsMenu";
fnc_voteGovernor = {
	
	private ["_uid","_index"];
	
	if ((lbCurSel 1500)==-1) exitWith {hint "Против всех!";};
	
	_uid = (lbData [1500,lbCurSel 1500]);
	
	if ((getPlayerUID player) in people_voted) then {
		people_votes set [people_voted find (getPlayerUID player),_uid];
		publicVariable "people_votes";
	} else {
		people_voted pushBack (getPlayerUID player);
		publicVariable "people_voted";
		people_votes pushBack _uid;
		publicVariable "people_votes";
		people_votes_names pushBack (lbText [1500, lbCurSel 1500]);
		publicVariable "people_votes_names";
	};
	
	hint format ["Вы успешно отдали свой голос за %1.", lbText [1500, lbCurSel 1500]];
	
	closeDialog 0;
	
};
publicVariable "fnc_voteGovernor";
fnc_searchPlayer = {
	
	if !(isNull (findDisplay 50018)) exitWith {};
	
	private ["_is","_as"];
	
	if ((cursearch distance player) >3) exitWith {closeDialog 0}; 
	
	_is = (cursearch getVariable "invi");
	_as = (cursearch getVariable "inva");
	if (!(createDialog "search_dialog")) exitWith {hint "Dialog Error!";};
	{
		lbAdd [1500, format ["%1", _x call fnc_getItemName]];
	} foreach (((weapons cursearch) + (itemsWithMagazines cursearch)) - ["av_knife_swing"]);
	{
		lbAdd [1500, format ["%1 %2шт.", _x call fnc_getItemName, _as select _forEachIndex]];
	} foreach _is;
};
publicVariable "fnc_searchPlayer";
fnc_restrainAction = {
	
	private ["_target","_anim","_code","_args","_call"];
	
	//Acts_ExecutionVictim_Loop
	//Acts_AidlPsitMstpSsurWnonDnon01
	
	closeDialog 0;
	
	if !(cursearch getVariable ["search",false]) exitWith {hint "Человек должен поднять руки или быть оглушён!";};
	
	if !(cursearch getVariable ["restrained",false]) then {
		
		_anim = "Acts_AidlPsitMstpSsurWnonDnon01";
		//_anim = "InBaseMoves_HandsBehindBack1";
		
		//if !((str player) in cop_array) then {_anim = "Acts_ExecutionVictim_Loop";};
		if !((str player) in cop_array) then {_anim = "Acts_AidlPsitMstpSsurWnonDnon01";};
		
		if (!((str player) in cop_array) and (("handcuffs" call fnc_getItemAmount)<1)) exitWith {systemChat "Нужны наручники.";};
		
		_target = cursearch;
		
		_target setVariable ["animstate",_anim,true];
		_target setVariable ["restrained", true, true];
		[_target,_anim] remoteExec ["fnc_playerPlayMove_remote"];
		
		_args = [cursearch,_anim];
		
		_args remoteExec ["fnc_restrainAction_remote_code1"];
		
		(format ["[%1|%2|%6] has restrained [%3|%4|%7] at %5", name player, getPlayerUID player, name _target, getPlayerUID _target, getPosATL _target, side player, side _target]) remoteExec ["fnc_logMyStuff",2];
						
	} else {
				
		if (!((str player) in cop_array) and (("handcuffs" call fnc_getItemAmount)<1)) then {["handcuffs",1] call fnc_addItem;};
		
		_target = cursearch;
		
		_target setVariable ["restrained", false, true];
		_target setVariable ["search", false, true];
		
		systemChat format ["Вы освободили %1!",[_target,false] call fnc_getRealName];
		
		(format ["[%1|%2|%6] has unrestrained [%3|%4|%7] at %5", name player, getPlayerUID player, name _target, getPlayerUID _target, getPosATL _target, side player, side _target]) remoteExec ["fnc_logMyStuff",2];
	};
	
};
publicVariable "fnc_restrainAction";
fnc_restrainAction_remote_code1 = {
			
			private ["_target","_call"];
			
			_target = _this select 0;
			
			if !(player==_target) exitWith {};
			
			//systemChat "anim track";
			
			_anim = _this select 1;
			
			{inGameUISetEventHandler [_x, "true"]} forEach ["PrevAction", "NextAction","Action"];
			while {player getVariable ["restrained",false]} do { //animationState 
								
				if (((vehicle player)==player) and ((animationState player)!="acts_aidlpsitmstpssurwnondnon01")) then {
					[player,_anim] remoteExec ["fnc_playerSwitchMove_remote"];
				};
				
				if restartsoon then {
				
					restrained_punish = 0;
				
				} else {
				
					restrained_punish = 1;
				
				};
				
				if !(alive player) exitWith {};
				
				uiSleep 0.1;
			};
			[player,""] remoteExec ["fnc_playerSwitchMove_remote"];
			
			player setVariable ["animstate","",true];
			
			{inGameUISetEventHandler [_x, "false"]} forEach ["PrevAction", "NextAction","Action"];
						
		};
publicVariable "fnc_restrainAction_remote_code1";
fnc_takeHostage = {
	
	private ["_victim"];
	
	_victim = (nearestobjects [getpos player, ["man"], 5] select 1);
	
	if !(_victim getVariable ["search",false]) exitWith {};
	
	_victim attachTo [player, [1,1,0]];
	
	player setVariable ["hostaged",_victim,true];
	
	//hint str _victim;
	
	_victim setVariable ["hostager",player,true];
	
	systemChat "Вы взяли заложника.";
	
};
publicVariable "fnc_takeHostage";
fnc_moveInCargo_remote = {
		(_this select 0) moveInCargo (_this select 1);	
	};
publicVariable "fnc_moveInCargo_remote";
fnc_putHostageIntoVeh = {
	
	private ["_victim","_vehicle","_code"];
	
	_vehicle = ((nearestobjects [getpos player, ['LandVehicle'], 5]) select 0);
	_victim = (player getVariable ["hostaged",dummy]);
	
	systemChat format ["%1 %2",_vehicle,_victim];
	
	detach _victim;
		
	[_victim,_vehicle] remoteExec ["fnc_moveInCargo_remote"];
	
	player setVariable ["hostaged",dummy,true];	
	_victim setVariable ["hostager",dummy,true];
	
};
publicVariable "fnc_putHostageIntoVeh";
fnc_pullOut = {
	
	private ["_veh","_target","_n","_i","_exitvar"];
	
	_veh = (nearestobjects [getpos player, ['Air', 'Ship', 'LandVehicle'], 3] select 0);
	_target = (crew _veh) select 0;
	_n 	= 10;
	_exitvar = false;
	
	if ((locked _veh)==2) then {systemChat "Транспорт закрыт. Это займет некоторое время."; _n = 16;};
	
	systemChat format ["Вы вытаскиваете из машины %1, оставайтесь рядом!", [_target,false] call fnc_getRealName];
	
	for [{_i=0}, {_i < _n}, {_i=_i+1}] do {if (player distance _target > 3) exitWith {systemChat "Слишком далеко."; _exitvar = true;};sleep 0.3;};
	
	if(_exitvar)exitwith{};
			
	_veh lock 0;
	player switchMove "AmovPercMstpSnonWnonDnon_AcrgPknlMstpSnonWnonDnon_getInLow";
	
	sleep 0.4;
	
	_target action ["eject", _veh];
	
	
	
	/*
	_target = (crew _this) select 0;
_n 	= 10;
_exitvar = false;
if (locked _this) then {player groupChat "Транспорт закрыт. Это займет некоторое время."; _n = 16;};
			
player groupChat format ["Вы вытаскиваете из машины %1. Оставайтесь поблизости!", _target];
format['if(player == %1)then{player groupChat "%2 вытащил вас из машины!"}', _target, player] call broadcast;
	
for [{_i=0}, {_i < _n}, {_i=_i+1}] do {if (player distance _target > 3) exitWith {player groupChat "Слишком далеко."; _exitvar = true;};sleep 0.3;};
if(_exitvar)exitwith{};
		
_this lock false;
player switchMove "AmovPercMstpSnonWnonDnon_AcrgPknlMstpSnonWnonDnon_getInLow";
sleep 0.4;
format['if(player == %2)then{player action["eject", vehicle player]}; server globalChat "%1 вытащил %2 из машины!";', player, _target] call broadcast;
*/
};
publicVariable "fnc_pullOut";
fnc_copInteractionArrestSliderChanged = {
	
	private ["_slider","_value","_number","_difference","_olddata","_newskillpts"];
	
	_slider = _this select 0;
	_value = _this select 1;
	_value = round (_value);
	_number = _this select 2;
	
	ctrlSetText [_number,format ["Арестовать на %1 минут",_value]];
};
publicVariable "fnc_copInteractionArrestSliderChanged";
fnc_setWantedRemote_code1 = {
		
		//systemChat format ["%1 объявил в розыск %2 за ""%3""!", _this select 0, _this select 1, _this select 2];
	
	};
	
publicVariable "fnc_setWantedRemote_code1";
fnc_setPlayerWanted = {
	
	private ["_uid","_reason","_bounty","_code","_args","_name"];
	
	_uid = _this select 0;
	_reason = _this select 1;
	_bounty = _this select 2;
	_name = _this select 3;
	_args = [_uid, _name, [_reason],_bounty];
		
	_result = [fnc_getRes_remote_code_43,_args] call fnc_getResult;
		
	_args = [[player,true] call fnc_getRealName, _name, _reason];
	
	_args remoteExec ["fnc_setWantedRemote_code1"];
	
	if ((wanted_players_list find _uid) < 0) then {
		
		private ["_arrw"];
		
		_arrw = [[_reason,_bounty]];
		
		wanted_players_names pushBack _name;
		publicVariable "wanted_players_names";
		wanted_players_list pushBack _uid;
		publicVariable "wanted_players_list";
		wanted_players_array pushBack _arrw;
		publicVariable "wanted_players_array";
		
	} else {
		
		private ["_arrw","_index"];
		
		_index = wanted_players_list find _uid;
		_arrw = wanted_players_array select _index;
		
		_arrw pushBack [_reason,_bounty];
		wanted_players_array set [_index,_arrw];
		publicVariable "wanted_players_array";
	};	
	
};
publicVariable "fnc_setPlayerWanted";
fnc_setPlayerUnWanted = {
	
	private ["_uid","_code","_args","_target"];
	
	_uid = _this select 0;
	_args = [_uid];
		
	_result = [fnc_getRes_remote_code_44,_args] call fnc_getResult;	
	
	if ((wanted_players_list find _uid) >= 0) then {
		
		private ["_arrw","_index"];
		
		_index = wanted_players_list find _uid;
		
		wanted_players_names deleteAt _index;
		publicVariable "wanted_players_names";
		wanted_players_array deleteAt _index;
		publicVariable "wanted_players_array";
		wanted_players_list deleteAt _index;
		publicVariable "wanted_players_list";
				
	};
	
};
publicVariable "fnc_setPlayerUnWanted";
fnc_wantedListMenu = {
	if !(isNull (findDisplay 50122)) exitWith {};
	call fnc_closeAllShit;
	waitUntil {closedshit};
	createDialog "wantedlist_dialog";
	
	{
		
		if ((getPlayerUID _x) in wanted_players_list) then {
			lbAdd [1500, [_x,true] call fnc_getRealName];
			lbSetData [1500, (lbSize 1500)-1, getPlayerUID _x];
		};
		
	//} forEach [player];
	} forEach playableUnits;
	
	if !((str player) in cop_array) then {ctrlShow [1601,false];};
	if !((str player) in cop_array) then {ctrlShow [1602,false];};
	
};
publicVariable "fnc_wantedListMenu";
fnc_askRobbed = {
	
	private ["_gs","_gsMoney","_gsRobbers","_gsRobbersNames","_gsMasks"];
	
	_gs = call compile _this;
	_gsRobbers = _gs getVariable ["gsrobbers",[]];
	_gsRobbersNames = _gs getVariable ["gsrobbersnames",[]];
	_gsMasks = _gs getVariable ["gsmasks",[]];
	
	{
	
		if !(_gsMasks select _forEachIndex) then {
	
			[_x,"Вооружённое ограбление",60000,_gsRobbersNames select _forEachIndex] call fnc_setPlayerWanted;
		
		} else {
		
			["Ограбление АЗС","АЗС ограбил преступник в маске, установить его личность не получилось.",[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;
		
		};
	
	} forEach _gsRobbers;
	
	["Ограбление АЗС","Вы допросили потерпевшего.",[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;
	
	_gs setVariable ["gsrobbers",[],true];
	_gs setVariable ["gsrobbersnames",[],true];
	_gs setVariable ["gsmasks",[],true];
	
};
publicVariable "fnc_askRobbed";
fnc_robGS_remote_code1 = {
		
		private ["_gs"];
		
		_gs = _this select 0;
		
		sleep 600;
		
		_gs setVariable ["gsmoney",15000,true];
		
	};
	
publicVariable "fnc_robGS_remote_code1";
fnc_robGS_remote_code2 = {
		
		private ["_gs"];
		
		_gs = _this select 0;
		
		//systemChat format ["КТО-ТО ОГРАБИЛ ЗАПРАВКУ НОМЕР %1", _gs];
		["Ограбление АЗС",format ["Кто-то ограбил АЗС номер %1!", _gs],[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;
		
	};
	
publicVariable "fnc_robGS_remote_code2";
fnc_robGasStation = {
	
	private ["_gs","_gsMoney","_gsRobbers","_gsRobbersNames","_gsMasks","_code","_args"];
	
	_gs = call compile _this;
	_gsMoney = _gs getVariable ["gsmoney",15000];
	_gsRobbers = _gs getVariable ["gsrobbers",[]];
	_gsRobbersNames = _gs getVariable ["gsrobbersnames",[]];
	_gsMasks = _gs getVariable ["gsmasks",[]];
	
	if !(((currentWeapon player) != "") and ((currentWeapon player) in [primaryWeapon player, secondaryWeapon player, handgunWeapon player])) exitWith {
	
		["Ограбление АЗС","Вам нужно оружие чтобы ограбить.",[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;
	
	};
	
	if (_gsMoney<10000) exitWith {
	
		["Ограбление АЗС","Заправка уже недавно была ограблена, сейчас в кассе нет денег.",[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;
	
	};
	
	_gsRobbers pushBack (getPlayerUID player);
	_gsRobbersNames pushBack ([player,true] call fnc_getRealName);
	if ((goggles player) in masks_array) then {
		_gsMasks pushBack true;
	} else {
		_gsMasks pushBack false;
	};
	["money",_gsMoney] call fnc_addItem;
	_gs setVariable ["gsmoney",0,true];
	_gs setVariable ["gsrobbers",_gsRobbers,true];
	_gs setVariable ["gsrobbersnames",_gsRobbersNames,true];
	_gs setVariable ["gsmasks",_gsMasks,true];
		
	_args = [_gs];
	
	_args remoteExec ["fnc_robGS_remote_code1",2];
	["Ограбление АЗС",format ["Вы ограбили заправку на сумму %1 CRK!", _gsMoney],[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;
	hint "Забирайте всё, только не трогайте меня!";
	
	(format ["[%1|%2|%3] has robbed gasstation at %4", name player, getPlayerUID player, side player, getPos player]) remoteExec ["fnc_logMyStuff",2];
		
	_args = [(gs_array find _this) + 1];
	
	_args remoteExec ["fnc_robGS_remote_code2"];
		
};
publicVariable "fnc_robGasStation";
fnc_wantedSetMenu = {
	
	if !(isNull (findDisplay 50123)) exitWith {};
	
	createDialog "wantedset_dialog";
	
	{
		if !((str _x) in cop_array) then {
			lbAdd [2100, [_x,true] call fnc_getRealName];
			lbSetData [2100, (lbSize 2100)-1, getPlayerUID _x];
		};
		
	} forEach playableUnits;
	
	lbSetCurSel [2100,0];
	
	//if !((str player) in cop_array) then {ctrlShow [1601,false];};
	
};
publicVariable "fnc_wantedSetMenu";
fnc_wantedLbChanged = {
	
	private ["_uid","_crimelist","_crimes","_display","_text","_bounty"];
	
	_uid = lbData [1500,lbCurSel 1500];
	
	_crimelist = wanted_players_array select (wanted_players_list find _uid);
	_crimes = "";
	_bounty = 0;
	
	{		
		_crimes = _crimes + format ["%3. ""%1"" [%2 CRK]<br/>", _x select 0, [_x select 1] call fnc_numberToText,_forEachIndex+1];
		_bounty = _bounty + (_x select 1);
		
	} forEach _crimelist;
	
	_crimes = format ["%1 имеет награду за поимку в размере %2 CRK за следующие преступления...<br/>----------<br/>%3", lbText [1500,lbCurSel 1500], [_bounty] call fnc_numberToText, _crimes];
	
	_display = findDisplay 50122;
	_text = _display displayCtrl 1100;
	_text ctrlSetStructuredText (parseText _crimes);
	
	
};
publicVariable "fnc_wantedLbChanged";
fnc_createGang = {
	
	private ["_gangname","_code","_args","_result"];
	
	_gangname = _this select 0;
	
	if (((cooldown_array select 0) find "gang_cd")>=0) exitWith {
		["Группировка",format ["Подождите ещё %1 минут для создания группировки.",((cooldown_array select 1) select ((cooldown_array select 0) find "gang_cd"))],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	};
	
	if ((count (toArray _gangname) < 3) or (count (toArray _gangname) > 20)) exitWith {
		["Группировка","Название должно быть не короче 3 и не длиннее 20 символов!",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	};
	
	if (("money" call fnc_getItemAmount)<50000) exitWith {systemChat "Недостаточно денег.";};
	
	["money",50000] call fnc_removeItem;
	
	if ((global_gangs_array_names find _gangname)!=-1) exitWith {
		["Группировка","Группировка с таким названием уже существует!",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	};
				
	_args = [_gangname, getPlayerUID player, [], [getPlayerUID player], [[player,true] call fnc_getRealName], 0];
	global_gangs_array pushBack _args;
	publicVariable "global_gangs_array";
	
	global_gangs_array_names pushBack _gangname;
	publicVariable "global_gangs_array_names";
	
	gangs_online pushBack _gangname;
	publicVariable "gangs_online";
	
	gangs_online_players pushBack (getPlayerUID player);
	publicVariable "gangs_online_players";
	
};
publicVariable "fnc_createGang";
fnc_gangListMenuOpen = {
		
	if ((getPlayerUID player) in gangs_online_players) exitWith {[] spawn fnc_myGangMenuOpen;};
	
	if !(isNull (findDisplay 50008)) exitWith {};
	call fnc_closeAllShit;
	waitUntil {closedshit};
	createDialog "ganglist_menu_dialog";
	
	{
		if ((_x select 5)==0) then {
			lbAdd [1500, format ["%1", _x select 0]];
			lbSetData [1500, (lbSize 1500)-1, _x select 0];
		} else {
			lbAdd [1500, format ["%1 [ИДЁТ НАБОР]", _x select 0]];
			lbSetData [1500, (lbSize 1500)-1, _x select 0];
		};
	} forEach global_gangs_array;
	
};
publicVariable "fnc_gangListMenuOpen";
fnc_joinGang = {
	
	private ["_gangname","_cursel","_playerid"];
	
	_cursel = (lbCurSel 1500);
	
	if (_cursel < 0) exitWith {
		["Группировка","Выберите группировку!",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	};
	
	if (((cooldown_array select 0) find "gang_cd")>=0) exitWith {
		["Группировка",format ["Подождите ещё %1 минут для вступления.",((cooldown_array select 1) select ((cooldown_array select 0) find "gang_cd"))],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	};
	
	_gangname = lbData [1500, _cursel];
	
	if (((global_gangs_array select (global_gangs_array_names find _gangname)) select 5)==0) exitWith {
		["Группировка","Набор закрыт!",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	};
	
	_playerid = getPlayerUID player;
	
	hint _gangname;
	
	gangs_online pushBack _gangname;
	publicVariable "gangs_online";
	gangs_online_players pushBack _playerid;
	publicVariable "gangs_online_players";
	
	(global_gangs_array select (global_gangs_array_names find _gangname)) set [3, ((global_gangs_array select (global_gangs_array_names find _gangname)) select 3) + [_playerid]];
	(global_gangs_array select (global_gangs_array_names find _gangname)) set [4, ((global_gangs_array select (global_gangs_array_names find _gangname)) select 4) + [[player,true] call fnc_getRealName]];
	publicVariable "global_gangs_array";
	
};
publicVariable "fnc_joinGang";
fnc_gangAreaNeutralize = {
	
	private ["_flag","_gangarea","_index","_flaganim","_owner"];
	
	_flag = call compile (_this select 0);
	_gangarea = _this select 0;
	_index = gangareas_array find _gangarea;
	_flaganim = (flagAnimationPhase _flag);
	
	if neutralizing_flag exitWith {
		["Захват территории","Подождите немного.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	};
	
	neutralizing_flag = true;
	
	player playMove "AinvPknlMstpSlayWrflDnon_medic";
	
	sleep 8;
	
	neutralizing_flag = false;
	_owner = _flag getVariable ["flagowner","none"];
	if ((_owner == (call fnc_getMyGang)) and (_owner!="none")) exitWith {
		["Захват территории","Вы не можете нейтрализовать свой флаг.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	};
	
	if (_flaganim <= 0.1) then {
		[_flag, (_flaganim-0.1), true] call BIS_fnc_animateFlag;
		_flag setVariable ["flagowner","none",true];
		
		_args = [(call fnc_getMyGang), _index];
		
		_args remoteExec ["fnc_gangAreaNeutralize_remote_code1"];
		
	} else {
		[_flag, (_flaganim-0.1), true] call BIS_fnc_animateFlag;
	};
	
};
publicVariable "fnc_gangAreaNeutralize";
fnc_gangAreaNeutralize_remote_code1 = {
			
			["Захват территории",format ["Группировка %1 нейтрализовала территорию банды %2!",_this select 0,(_this select 1)+1],[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;
			
		};
publicVariable "fnc_gangAreaNeutralize_remote_code1";
fnc_gangAreaCapture = {
	
	private ["_flag","_gangarea","_index","_flaganim","_owner","_code","_args"];
	
	_flag = call compile (_this select 0);
	_gangarea = _this select 0;
	_index = gangareas_array find _gangarea;
	_flaganim = (flagAnimationPhase _flag);
	
	if neutralizing_flag exitWith {
		["Захват территории","Подождите немного.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	};
	
	neutralizing_flag = true;
	
	player playMove "AinvPknlMstpSlayWrflDnon_medic";
	
	sleep 8;
	
	neutralizing_flag = false;
	_owner = _flag getVariable ["flagowner","none"];
	//if (_owner!=(call fnc_getMyGang)) exitWith {systemChat "Вы не можете захватить флаг не своей группировки.";};
	
	if (_flaganim <0.9) then {
		[_flag, (_flaganim+0.1), true] call BIS_fnc_animateFlag;
	} else {
		[_flag, (_flaganim+0.1), true] call BIS_fnc_animateFlag;
		_flag setVariable ["flagowner",(call fnc_getMyGang),true];
		
		_args = [(call fnc_getMyGang), _index];
		
		_args remoteExec ["fnc_gangAreaCapture_remote_code1"];
		
	};
	
};
publicVariable "fnc_gangAreaCapture";
fnc_gangAreaCapture_remote_code1 = {
			
			["Захват территории",format ["Группировка %1 захватила территорию банды %2!",_this select 0,(_this select 1)+1],[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;
			
		};
publicVariable "fnc_gangAreaCapture_remote_code1";
fnc_getMyGang = {
	
	private ["_gang","_find"];
	
	_find = (gangs_online_players find (getPlayerUID player));
	
	if (_find<0) exitWith {"none"};
	
	_gang = gangs_online select _find;
	
	_gang
	
};
publicVariable "fnc_getMyGang";
fnc_applyGangInvite = {
	
	private ["_gangname","_playerid"];
	
	_gangname = _this select 0;
	
	//if (((global_gangs_array select (global_gangs_array_names find _gangname)) select 5)==0) exitWith {hint "Набор закрыт!";};
	
	_playerid = getPlayerUID player;
	
	//hint _gangname;
	_gangmembers = (global_gangs_array select (global_gangs_array_names find _gangname)) select 3;
	
	if (((cooldown_array select 0) find "gang_cd")>=0) exitWith {
		["Группировка",format ["Подождите ещё %1 минут для вступления в банду.",((cooldown_array select 1) select ((cooldown_array select 0) find "gang_cd"))],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	};
	
	if (_playerid in _gangmembers) exitWith {
		["Группировка","Вы уже есть в этой группировке.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	};
	
	gangs_online pushBack _gangname;
	publicVariable "gangs_online";
	gangs_online_players pushBack _playerid;
	publicVariable "gangs_online_players";
	
	(global_gangs_array select (global_gangs_array_names find _gangname)) set [3, ((global_gangs_array select (global_gangs_array_names find _gangname)) select 3) + [_playerid]];
	(global_gangs_array select (global_gangs_array_names find _gangname)) set [4, ((global_gangs_array select (global_gangs_array_names find _gangname)) select 4) + [[player,true] call fnc_getRealName]];
	publicVariable "global_gangs_array";
	
};
publicVariable "fnc_applyGangInvite";
	
fnc_leaveGang = {
	
	private ["_playerid","_cursel","_gang","_gangowner","_gangdeputies","_gangmembers","_gangmembersnames","_kickid","_index"];
	
	_playerid = getPlayerUID player;
	
	_gang = gangs_online select (gangs_online_players find _playerid);
	
	_gangowner = (global_gangs_array select (global_gangs_array_names find _gang)) select 1;
	_gangdeputies = (global_gangs_array select (global_gangs_array_names find _gang)) select 2;
	_gangmembers = (global_gangs_array select (global_gangs_array_names find _gang)) select 3;
	_gangmembersnames = (global_gangs_array select (global_gangs_array_names find _gang)) select 4;
	
	if (_gangowner==_playerid) exitWith {
		["Группировка","Вы не можете покинуть группировку, будучи её главарём.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	};
	
	_index = _gangmembers find _playerid;
	_gangdeputies = _gangdeputies - [_playerid];
	_gangmembers = _gangmembers - [_playerid];
	_gangmembersnames deleteAt _index;
	
	systemChat format ["%1 %2 %3", _gangdeputies, _gangmembers, _gangmembersnames];
	
	(global_gangs_array select (global_gangs_array_names find _gang)) set [2,_gangdeputies];
	(global_gangs_array select (global_gangs_array_names find _gang)) set [3,_gangmembers];
	(global_gangs_array select (global_gangs_array_names find _gang)) set [4,_gangmembersnames];
	
	_index = gangs_online_players find _playerid;
	gangs_online deleteAt _index;
	gangs_online_players deleteAt _index;
	publicVariable "global_gangs_array";
	publicVariable "gangs_online";
	publicVariable "gangs_online_players";
	
};
publicVariable "fnc_leaveGang";
fnc_kickPlayerFromGang = {
	
	private ["_playerid","_cursel","_gang","_gangowner","_gangdeputies","_gangmembers","_gangmembersnames","_kickid","_index"];
	
	_cursel = lbCurSel 1500;
	_playerid = getPlayerUID player;
	
	if (_cursel<0) exitWith {
		["Группировка","Выберите игрока!",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	};
		
		
	_gang = gangs_online select (gangs_online_players find _playerid);
	
	_gangowner = (global_gangs_array select (global_gangs_array_names find _gang)) select 1;
	_gangdeputies = (global_gangs_array select (global_gangs_array_names find _gang)) select 2;
	_gangmembers = (global_gangs_array select (global_gangs_array_names find _gang)) select 3;
	_gangmembersnames = (global_gangs_array select (global_gangs_array_names find _gang)) select 4;
	
	_kickid = lbData [1500, _cursel];
	
	if (_gangowner==_kickid) exitWith {
		["Группировка","Вы не можете исключить главаря.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	};
	
	if (_gangowner==_playerid) then {
		
		_index = _gangmembers find _kickid;
		_gangdeputies = _gangdeputies - [_kickid];
		_gangmembers = _gangdeputies - [_kickid];
		_gangmembersnames deleteAt _index;
		
		(global_gangs_array select (global_gangs_array_names find _gang)) set [2,_gangdeputies];
		(global_gangs_array select (global_gangs_array_names find _gang)) set [3,_gangmembers];
		(global_gangs_array select (global_gangs_array_names find _gang)) set [4,_gangmembersnames];
		publicVariable "global_gangs_array";
		
	};
	
	if (_playerid in _gangdeputies) then {
		
		if (_kickid in (_gangdeputies+[_gangowner])) exitWith {["Группировка","Вы не можете исключить главаря.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
		_index = _gangmembers find _kickid;
		_gangdeputies = _gangdeputies - [_kickid];
		_gangmembers = _gangdeputies - [_kickid];
		_gangmembersnames deleteAt _index;
		
		(global_gangs_array select (global_gangs_array_names find _gang)) set [2,_gangdeputies];
		(global_gangs_array select (global_gangs_array_names find _gang)) set [3,_gangmembers];
		(global_gangs_array select (global_gangs_array_names find _gang)) set [4,_gangmembersnames];
		publicVariable "global_gangs_array";
		
	};
	
};
publicVariable "fnc_kickPlayerFromGang";
fnc_deleteGang = {
	
	private ["_playerid","_gang","_gangowner","_gangdeputies","_gangmembers","_gangmembersnames","_gangindex","_index"];
	
	_confirmMsg = "Вы действительно хотите удалить свою группировку?";
	
	if !([parseText _confirmMsg, "Confirm", "Удалить", true] call BIS_fnc_guiMessage) exitWith {};
	
	_playerid = getPlayerUID player;
	
	_gang = gangs_online select (gangs_online_players find _playerid);
	
	_gangowner = (global_gangs_array select (global_gangs_array_names find _gang)) select 1;
	_gangdeputies = (global_gangs_array select (global_gangs_array_names find _gang)) select 2;
	_gangmembers = (global_gangs_array select (global_gangs_array_names find _gang)) select 3;
	_gangmembersnames = (global_gangs_array select (global_gangs_array_names find _gang)) select 4;
	
	{
		_index = (gangs_online_players find _x);
		
		if (_index > -1) then {
			
			gangs_online deleteAt _index;
			publicVariable "gangs_online";
			gangs_online_players deleteAt _index;
			publicVariable "gangs_online_players";
		
		};
		
	} forEach _gangmembers;
	
	
	_gangindex = global_gangs_array_names find _gang;
	
	global_gangs_array deleteAt _gangindex;
	publicVariable "global_gangs_array";
	
	global_gangs_array_names deleteAt _gangindex;
	publicVariable "global_gangs_array_names";
	
	["Группировка","Группировка удалена!",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	
};
publicVariable "fnc_deleteGang";
fnc_invitePlayerToGang = {
	
	private ["_invitedPlayer","_cursel","_code","_args","_gang"];
	
	_cursel = lbCurSel 2101;
	
	if (_cursel<0) exitWith {["Группировка","Выберите игрока!",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	
	_invitedPlayer = lbData [2101, _cursel];
	_gang = gangs_online select (gangs_online_players find (getPlayerUID player));
		
	_args = [_invitedPlayer,_gang];
	
	_args remoteExec ["fnc_invitePlayerToGang_remote"];
	
	["Группировка","Вы пригласили игрока.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	
	closeDialog 0;
	
};
publicVariable "fnc_invitePlayerToGang";
fnc_invitePlayerToGang_remote = {
		
		private ["_uid","_gang","_action1","_action2"];
		
		_uid = _this select 0;
		_gang = _this select 1;
		
		if !(_uid==(getPlayerUID player)) exitWith {};
		
		if ((isNil "ganginviteaction1") and (isNil "ganginviteaction2")) then {
		
			ganginviteaction1 = player addAction [format ["Вступить в %1",_gang], {(_this select 3) spawn fnc_applyGangInvite; {player removeAction _x} forEach [ganginviteaction1,ganginviteaction2]; ganginviteaction1 = nil; ganginviteaction2 = nil;}, [_gang], 1.5, true, true, "", ""];
			ganginviteaction2 = player addAction [format ["Отказаться от вступления в %1",_gang], {{player removeAction _x} forEach [ganginviteaction1,ganginviteaction2]; ganginviteaction1 = nil; ganginviteaction2 = nil;}, [], 1.5, true, true, "", ""];
		
		} else {
			
			["Группировка","Вам пришло ещё одно приглашение в группировку, но сначала разберитесь с текущим.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
			
		};
		
	};
publicVariable "fnc_invitePlayerToGang_remote";
fnc_myGangMenuOpen = {
	
	if !(isNull (findDisplay 50009)) exitWith {};
	
	
	private ["_gang","_gangdeputies","_gangmembers","_gangowner","_gangopen","_peopleonline","_playerid","_gangmembersnames"];
	
	_peopleonline = [];
	_playerid = getPlayerUID player;
	
	{
		_peopleonline pushBack (getPlayerUID _x);
	//} forEach [player];
	} forEach playableUnits;
	
	_gang = gangs_online select (gangs_online_players find _playerid);
	
	_gangowner = (global_gangs_array select (global_gangs_array_names find _gang)) select 1;
	_gangdeputies = (global_gangs_array select (global_gangs_array_names find _gang)) select 2;
	_gangmembers = (global_gangs_array select (global_gangs_array_names find _gang)) select 3;
	_gangmembersnames = (global_gangs_array select (global_gangs_array_names find _gang)) select 4;
	_gangopen = (global_gangs_array select (global_gangs_array_names find _gang)) select 5;
	
	call fnc_closeAllShit;
	waitUntil {closedshit};
	createDialog "gang_menu_dialog";
	
	if (_gangowner in _peopleonline) then {
		lbAdd [1500, format ["%1 [ВЛАДЕЛЕЦ] [В ИГРЕ]", _gangmembersnames select (_gangmembers find _gangowner)]];
		lbSetData [1500, (lbSize 1500)-1, _gangowner];
	} else {
		lbAdd [1500, format ["%1 [ВЛАДЕЛЕЦ]", _gangmembersnames select (_gangmembers find _gangowner)]];
		lbSetData [1500, (lbSize 1500)-1, _gangowner];
	};
	
	{
		if (_x in _peopleonline) then {
			lbAdd [1500, format ["%1 [РУКОВОДИТЕЛЬ] [В ИГРЕ]", _gangmembersnames select (_gangmembers find _x)]];
			lbSetData [1500, (lbSize 1500)-1, _x];
		} else {
			lbAdd [1500, format ["%1 [РУКОВОДИТЕЛЬ]", _gangmembersnames select (_gangmembers find _x)]];
			lbSetData [1500, (lbSize 1500)-1, _x];
		};
		
	} forEach _gangdeputies;
	
	{
		if (_x in _peopleonline) then {
			lbAdd [1500, format ["%1 [В ИГРЕ]", _gangmembersnames select (_gangmembers find _x)]];
			lbSetData [1500, (lbSize 1500)-1, _x];
		} else {
			lbAdd [1500, format ["%1", _gangmembersnames select (_gangmembers find _x)]];
			lbSetData [1500, (lbSize 1500)-1, _x];
		};
		
	} forEach (_gangmembers-_gangdeputies-[_gangowner]);
	
	{
		if (!((str _x) in cop_array) and ((_x distance player)<5)) then {
			lbAdd [2101,[_x,false] call fnc_getRealName];
			lbSetData [2101, (lbSize 2101)-1, getPlayerUID _x];
		};
	//} forEach [player];
	} forEach playableUnits;
	
	//lbSetCurSel [2101, 0];
	
	lbAdd [2100, "запрещено"];
	lbAdd [2100, "разрешено"];
	
	lbSetCurSel [2100, _gangopen];
	
	if !(_playerid == _gangowner) then {
		
		ctrlSetText [1605,"Покинуть группировку"];
		buttonSetAction [1605,"[] spawn fnc_leaveGang; closeDialog 0;"];
		ctrlShow [2100,false];
		ctrlShow [1000,false];
		ctrlShow [1603,false];
		ctrlShow [1604,false];
		
		if !(_playerid in _gangdeputies) then {
			ctrlShow [1602,false];
			ctrlShow [2101,false];
			ctrlShow [1601,false];
		};
		
	};
		
	/*
	
	_query = format ["SELECT id FROM gangs WHERE members LIKE '%2%1%2' AND side='%3' AND active='1'",_uid,"%",_checkside];
	*/
	
	
};
publicVariable "fnc_myGangMenuOpen";
fnc_gangAllowJoin = {
	private ["_playerid","_gang","_gangopen"];
	_playerid = getPlayerUID player;
	
	_gang = gangs_online select (gangs_online_players find _playerid);
	
	_gangopen = (global_gangs_array select (global_gangs_array_names find _gang)) select 5;
	
	(global_gangs_array select (global_gangs_array_names find _gang)) set [5, _this];
};
publicVariable "fnc_gangAllowJoin";
fnc_openCopInteractionMenu = {
	
	if !(isNull (findDisplay 50003)) exitWith {};
			
	createDialog "copsearch_dialog";
	
	sliderSetRange [1100,1,60];
	sliderSetSpeed [1100,1,1];
	
};
publicVariable "fnc_openCopInteractionMenu";
fnc_sitInJail_remote_code1 = {
					
					["ПОБЕГ ИЗ ТЮРЬМЫ",format ["%1 сбежал из тюрьмы!", [_this select 0,true] call fnc_getRealName],[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;
					
				};
publicVariable "fnc_sitInJail_remote_code1";
fnc_sitInJail = {
	
	private ["_code","_args","_exitme"];
	
	while {jailed} do {
	
		_exitme = false;
		
		jailtimeleft = jailtimeleft - 1;
		
		hintSilent format ["Осталось %1 секунд", jailtimeleft];
		
		if (player distance (getMarkerPos "prison_spawn") > 100) then {
			
			if allowjailescape then {
			
				_exitme = true;
			
				jailed = false;
				jailtimeleft = 0;
				["ПОБЕГ ИЗ ТЮРЬМЫ","Вы сбежали из тюрьмы!",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
				
				_args = [player];
				
				_args remoteExec ["fnc_sitInJail_remote_code1"];
			
			} else {
				
				["ПОБЕГ ИЗ ТЮРЬМЫ","Вы не можете сбежать из-за невероятного чувства стыда.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
				player setPos (getMarkerPos "prison_spawn");
				
			};
		};
		
		if _exitme exitWith {};
		
		if (jailtimeleft<1) exitWith {
			jailed = false;
			jailtimeleft = 0;
			["Тюрьма","Вы освобождены! Ведите себя хорошо!",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
			allowjailescape = true;
			player setPos (getMarkerPos "prison_exit");
		};
		
		if !(alive player) exitWith {
		
			jailed = false; jailtimeleft = 0;
		
		};
		
		sleep 1;
	};
	
};
publicVariable "fnc_sitInJail";
fnc_arrestAction_remote_code1 = {
		
		private ["_target","_cop","_time"];
		
		_target = _this select 0;
		_cop = _this select 1;
		_time = _this select 2;
		
		systemChat format ["%1 был отправлен в тюрьму полицейским %2 на %3 минут!", [_target,true] call fnc_getRealName, [_cop,true] call fnc_getRealName, _time];
		
		if !(player==_target) exitWith {};
		
		if jailed exitWith {};
		
		["Тюрьма","Вы попали в тюрьму! Выбраться можно только по воздуху. Или не только.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
		
		jailed = true;
		jailtimeleft = _time*60;
		
		systemChat str jailtimeleft;
		
		player setPos (getMarkerPos "prison_spawn");
		
		[] spawn fnc_sitInJail;
		
	};
publicVariable "fnc_arrestAction_remote_code1";
fnc_arrestAction = {
	
	if !(cursearch getVariable ["search",false]) exitWith {
		["Арест","Человек должен быть связан или без сознания.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	};
	
	private ["_code","_args","_time","_prisoner","_bounty","_crimelist","_target"];
	
	_time = round (_this select 0);
	_prisoner = _this select 1;
	
	_target = cursearch;
		
	_target setVariable ["restrained", false, true];
	_target setVariable ["search", false, true];
		
	_args = [cursearch,player,_time];
	
	_args remoteExec ["fnc_arrestAction_remote_code1"];
	
	_crimelist = wanted_players_array select (wanted_players_list find (getPlayerUID cursearch));
	_bounty = 0;
	
	(format ["[%1|%2|%3] has arrested [%4|%5|%6] for %7 minutes, he had %8", name player, getPlayerUID player, side player, name cursearch, getPlayerUID cursearch, side cursearch, _time, _crimelist]) remoteExec ["fnc_logMyStuff",2];
	
	{		
		_bounty = _bounty + (_x select 1);
		
	} forEach _crimelist;
	
	["Арест",format ["Вы получили награду в размере %1 CRK за поимку преступника!", _bounty],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	
	deposit = deposit + _bounty;
	
	[getPlayerUID cursearch] spawn fnc_setPlayerUnWanted;
	
};
publicVariable "fnc_arrestAction";
fnc_fineAction_remote_code1 = {
				
				private ["_cop","_target","_money"];
				
				_cop = _this select 0;
				_target = _this select 1;
				_money = _this select 2;
				
				if !(player==_cop) exitWith {};
				
				["Штраф",format ["У %1 не хватает средств чтобы оплатить штраф на сумму %2 CRK!", [_target,false] call fnc_getRealName, _money],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
				
			};
publicVariable "fnc_fineAction_remote_code1";
fnc_fineAction_remote_code2 = {
					
					private ["_cop","_target","_money"];
					
					_cop = _this select 0;
					_target = _this select 1;
					_money = _this select 2;
					
					if ((str player) in cop_array) then {
						
						deposit = deposit + round(_money/(count cop_array));
						
						["Штраф",format ["%1 оплатил штраф, вы получили %2 CRK.", [_target,true] call fnc_getRealName, round(_money/(count cop_array))],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
						
					};
					
					systemChat format ["%1 оплатил штраф на сумму %2 CRK, выписанный полицейским %3!", [_target,true] call fnc_getRealName, _money, [_cop,true] call fnc_getRealName];
					
				};
publicVariable "fnc_fineAction_remote_code2";
fnc_fineAction_remote_code3 = {
					
					private ["_cop","_target","_money"];
					
					_cop = _this select 0;
					_target = _this select 1;
					_money = _this select 2;
					
					if !(player==_cop) exitWith {};
					
					["Штраф",format ["%1 отказался платить штраф на сумму %2 CRK!", [_target,false] call fnc_getRealName, _money],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
					
				};
publicVariable "fnc_fineAction_remote_code3";
fnc_getRealName = {
	private ["_unit","_namebypass","_add"];
	
	_unit = _this select 0;
	_namebypass = _this select 1;
	_add = "";
	
	if (count _this < 3) then {
	
		_add = _unit getVariable ["role_id",1398];
	
	};
	
	if _namebypass exitWith {
	
		(format ["%1 %2 [%3]",_unit getVariable ["charname","noner"],_unit getVariable ["charlastname","noner"],_add])
	
	};
	if ((goggles _unit) in masks_array) then {
	
		"НЕИЗВЕСТНЫЙ"
	
	} else {
	
		(format ["%1 %2 [%3]",_unit getVariable ["charname","noner"],_unit getVariable ["charlastname","noner"],_add])
	
	};
};
publicVariable "fnc_getRealName";
fnc_fineAction_remote_code4 = {
		
		private ["_target","_money","_code","_args","_left","_cop","_confirmMsg"];
		
		_target = _this select 0;
		
		if !(player==_target) exitWith {};
		
		_money = _this select 1;
		_cop = _this select 2;
		_left = 0;
		
		if ((("money" call fnc_getItemAmount)+deposit)<_money) then {
			
			["Штраф",format ["У вас не хватает денег для оплаты штрафа на сумму %1 CRK!",_money],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
						
			_args = [_cop,_target,_money];
			
			_args remoteExec ["fnc_fineAction_remote_code1"];
			
		} else {
			
			_confirmMsg = format ["%1 выписал вам штраф на сумму %2 CRK. Оплатить?", [_cop,true] call fnc_getRealName,_money];
			
			if ([parseText _confirmMsg, "Confirm", "Оплатить", true] call BIS_fnc_guiMessage) then
			
			{
				//если в банке достаточно средств
				
				//если в банке не хватает, доплачиваем налом
				
				if (_money<=deposit) then {
					
					deposit = deposit - _money;				
					
				} else {
					
					if (deposit>0) then {
					
						_left = _money - deposit;
						deposit = 0;
						["money",_left] call fnc_removeItem;					
					
					} else {
						
						["money",_money] call fnc_removeItem;
						
					};
					
				};
							
				_args = [_cop,_target,_money];
				
				_args remoteExec ["fnc_fineAction_remote_code2"];
								
				[getPlayerUID player] spawn fnc_setPlayerUnWanted;
				
				
			} else {
				
				["Штраф","Вы отказались платить.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
				
				_args = [_cop,_target,_money];
				
				_args remoteExec ["fnc_fineAction_remote_code3"];
				
			};
			
		};
		
		
	};
publicVariable "fnc_fineAction_remote_code4";
fnc_fineAction = {
	
	private ["_money","_code","_args"];
	
	_money = parseNumber (ctrlText 1400);
		
	_args = [cursearch,_money,player];
	
	_args remoteExec ["fnc_fineAction_remote_code4"];
	
};
publicVariable "fnc_fineAction";
fnc_searchAction_remote_code1 = {
			
			private ["_cop","_money","_target","_uid"];
			
			_cop = _this select 0;
			_money = _this select 1;
			_target = _this select 2;
			_uid = _this select 3;
			
			if !(player==_cop) exitWith {};
			
			if (_money>0) then {
				[_uid,"Хранение запрещённых предметов",round(_money*1.5),[player,true] call fnc_getRealName] call fnc_setPlayerWanted;
			};
			["Изъятие",format ["Вы изъяли нелегальных предметов у игрока %1 на сумму %2 CRK.",[_target,false] call fnc_getRealName,_money],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
			
		};
publicVariable "fnc_searchAction_remote_code1";
fnc_searchAction_remote_code2 = {
		
		private ["_target","_cop","_money","_amount","_code","_args","_toremove"];
		
		_target = _this select 0;
		
		if !(player==_target) exitWith {};
		
		_cop = _this select 1;
		_money = 0;		
		_toremove = [];
		{
			if !(_x call fnc_getItemLegal) then {
				_amount = _x call fnc_getItemAmount;
				_money = _money + 1000*_amount;
				[format ["Изъято %1 %2",_x call fnc_getItemName,_amount]] spawn fnc_itemNotifyMePls;
				_toremove pushBack [_x,_amount];
			};
		} forEach inventory_items;
		
		{
			_x call fnc_removeItem;
		} forEach _toremove;
				
		_args = [_cop,_money,_target,getPlayerUID _target];
		
		_args remoteExec ["fnc_searchAction_remote_code1"];
	
	};
publicVariable "fnc_searchAction_remote_code2";
fnc_searchAction = {
	
	private ["_code","_args"];
	
	closeDialog 0;
	
	if !(cursearch getVariable ["search",false]) exitWith {};
		
	_args = [cursearch,player];
	
	_args remoteExec ["fnc_searchAction_remote_code2"];
};
publicVariable "fnc_searchAction";
fnc_searchPlayerCop = {
	
	if !(isNull (findDisplay 50018)) exitWith {};
	
	private ["_is","_as","_lics"];
	
	if ((cursearch distance player) >3) exitWith {closeDialog 0}; 
	
	_is = (cursearch getVariable "invi");
	_as = (cursearch getVariable "inva");
	_lics = (cursearch getVariable "licenses_array");
	if (!(createDialog "search_dialog")) exitWith {hint "Dialog Error!";};
	{
		lbAdd [1500, format ["%1", _x call fnc_getLicenseName]];
	} foreach _lics;
	{
		if !(_x=="") then {
			lbAdd [1500, format ["%1", _x call fnc_getItemName]];
		};
	} foreach (((weapons cursearch) + (itemsWithMagazines cursearch)) - ["av_knife_swing"]);
	{
		lbAdd [1500, format ["%1 %2шт.", _x call fnc_getItemName, _as select _forEachIndex]];
	} foreach _is;
};
publicVariable "fnc_searchPlayerCop";
fnc_closeAllShit = {
	
	closedshit = false;
	
	{
		(findDisplay _x) closeDisplay 0;
		waitUntil {isNull (findDisplay _x)};
	} forEach [50100,50101,50122,50123,50001,50002,50003,50004,50005,50006,50007,50008,50009,50010,50011,50012,50013,50014,50015,50016,50017,50018,50019,50020,50021,50022];
	
	closedshit = true;	
	
};
publicVariable "fnc_closeAllShit";
fnc_openKeyMenu = {
	
	if !(isNull (findDisplay 50015)) exitWith {};
	
	call fnc_closeAllShit;
	waitUntil {closedshit};
	
	private["_playersnear"];
	
	current_keys = [];
	
	if !(createDialog "keys_menu") exitWith {hint "Dialog error!"};
	
	{
		
		if ((format ["veh%1",_x]) in servervehiclesarray) then {
			
			current_keys pushBack _x;
			lbAdd [1500, format ["%1 р/н %2",(typeOf (call compile format ["veh%1",_x])) call fnc_getItemName,_x]];
			
		};
		
	} forEach vehicle_keys;
	
	_playersnear = [];	
	
	{
		if ((isPlayer _x) and (alive _x)) then {_playersnear pushBack [([_x,false] call fnc_getRealName),getPlayerUID _x]};
	} foreach (nearestObjects [player,["Man"],5]);
	
	{
		lbAdd [2100, _x select 0];
		lbSetData [2100, (lbSize 2100)-1, _x select 1];
	} foreach _playersnear;
	
};
publicVariable "fnc_openKeyMenu";
fnc_dropKey = {
	private ["_name","_key","_togive","_call"];
	_key = current_keys select (_this select 0);
	if ((_this select 0)<0) exitWith {};
	vehicle_keys = vehicle_keys - [_key];
	["Ключи",format ["Вы выбросили ключи от %1", (typeOf (call compile format ["veh%1",_key])) call fnc_getItemName],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	closeDialog 0;
};
publicVariable "fnc_dropKey";
fnc_giveKey_remote_code1 = {
	private ["_name","_key"];
	
	_name = _this select 0;
	_key = _this select 1;
	if ((getPlayerUID player) == _name) then {
		if !(_key in vehicle_keys) then {
			vehicle_keys pushBack _key;
		};
		["Ключи","Вам передали ключи от транспортного средства.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	};
};
publicVariable "fnc_giveKey_remote_code1";
fnc_giveKey = {
	private ["_name","_key","_togive","_call"];
	_name = _this select 0;
	_key = current_keys select (_this select 1);
	if ((_this select 1)<0) exitWith {};
	if (((count current_keys) - 1)<(_this select 1)) exitWith {};
	_togive = [];
	{
		if (((getPlayerUID _x) == _name) and (alive _x)) then {_togive pushBack (getPlayerUID _x)};
	} foreach (nearestObjects [player,["Man"],5]);
	if (count _togive == 1) then {
		[_name,_key] remoteExec ["fnc_giveKey_remote_code1"];
		["Ключи",format ["Вы передали игроку %1 ключи от %2",_name, (typeOf (call compile format ["veh%1",_key])) call fnc_getItemName],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	} else {
		["Ключи",format ["Игрок %1 слишком далеко или мёртв",_name],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	};
	closeDialog 0;
};
publicVariable "fnc_giveKey";
fnc_giveItem_remote_code1 = {
	private ["_name","_item","_amount"];
	
	_name = _this select 0;
	_item = _this select 1;
	_amount = _this select 2;
	if ((getPlayerUID player) == _name) then {
		[_item,_amount] call fnc_addItem;
		[format ["Вам передали %1 %2",[_amount] call fnc_numberToText,_item call fnc_getItemName]] spawn fnc_itemNotifyMePls;
		(format ["[%1|%2|%3] has recieved %4 %5", name player, getPlayerUID player, side player, _amount, _item]) remoteExec ["fnc_logMyStuff",2];
	};
};
publicVariable "fnc_giveItem_remote_code1";
fnc_giveItem = {
	private ["_name","_item","_amount","_realamount","_togive","_call","_realname"];
	closeDialog 0;
	_name = _this select 0;
	_realname = "";
	_item = _this select 1;
	_amount = _this select 2;
	_realamount = _item call fnc_getItemAmount;
	if (_amount>_realamount) then {_amount = _realamount};
	if (_amount==0) exitWith {};
	_togive = [];
	{
		if (((getPlayerUID _x) == _name) and (alive _x)) then {_togive pushBack (getPlayerUID _x); _realname = [_x,false] call fnc_getRealName;};
	} foreach (nearestObjects [player,["Man"],5]);
	if (count _togive == 1) then {
		[_item,_amount] call fnc_removeItem;
		[_name,_item,_amount] remoteExec ["fnc_giveItem_remote_code1"];
		["Передача предмета",format ["Вы передали игроку %1 %2 %3",_realname,[_amount] call fnc_numberToText,_item call fnc_getItemName],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
		(format ["[%1|%2|%3] gave [%4|%5|%6] %7 %8", name player, getPlayerUID player, side player, _name, "?", "?", _amount, _item]) remoteExec ["fnc_logMyStuff",2];
	} else {
		["Передача предмета",format ["%1 слишком далеко или мёртв",_realname],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	};
};
publicVariable "fnc_giveItem";
fnc_getPrice = {
	private ["_index","_item","_price"];
	_index = _this;
	_item = (itemstosell select _index);
	//systemChat str _item;
	//round(((((((shop_array select curshop) select 3) select (((shop_array select curshop) select 6) find (itemstosell select _index))) select 1)/2)*parseNumber('1'));
	//_price = round((((((shop_array select curshop) select 3) select (((shop_array select curshop) select 6) find (itemstosell select _index))) select 1)/2)*parseNumber('1'));
	
	_price = 0;
	switch (shopclass_array select curshop) do {
		case "wholesale1": {
			_max = 0;
			{
				if ((_x select 0) in food_shops) then {
					_max = _max + ((((shop_array select _forEachIndex) select 3) select (((shop_array select _forEachIndex) select 6) find _item)) select 5);
				};
			} foreach shop_array;
			_act = 0;
			{
				if ((_x select 0) in food_shops) then {
					_act = _act + ((((shop_array select _forEachIndex) select 3) select (((shop_array select _forEachIndex) select 6) find _item)) select 3);
				};
			} foreach shop_array;
			_price = ceil((((((shop_array select curshop) select 3) select (((shop_array select curshop) select 6) find (itemstosell select _index))) select 1))*parseNumber('1'));
			if (_act>_max) then {		
				systemChat str _price;
				_price = ceil(_price*0.1);
			} else {
				_price = ceil((_price*0.1)+(_price*((1-(_act/_max))/2)));
			};
			systemChat str _max;
			systemChat str _act;		
		};
		default {
			_price = round((((((shop_array select curshop) select 3) select (((shop_array select curshop) select 6) find (itemstosell select _index))) select 1)/2)*parseNumber('1'));
		};
	};
	_price
};
publicVariable "fnc_getPrice";
fnc_shopItemDesc = {
	
	private ["_display","_description","_item","_itemdata","_tax","_a1","_a2"];
	
	disableSerialization;
	
	_item = _this select 0;
	_itemdata = shop_mierda select (_this select 1);
	_display = findDisplay 50100;
	_description = _display displayCtrl 1100;
	_description2 = _display displayCtrl 1101;
	
	_tax = 0;
	
	if legalshopyesno then {
		_tax = nds_tax;
	};
	
	_a1 = (_itemdata select 1);
	_a2 = (_itemdata select 3);
	
	if (_a1 < 0) then {	
		_a1 = "бесконечно";	
	};
	if (_a2 < 0) then {	
		_a2 = "бесконечно";	
	};
	
	_description ctrlSetStructuredText (parseText format ["%1<br/>%2",(_item call fnc_getItemName),(_item call fnc_getItemInfo)]);
	if ((_itemdata select 3)==-1) then {
		_description2 ctrlSetStructuredText (parseText format ["Цена: <t color='#00ff00'>%1</t> CRK<br/>Вес: <t color='#00ff00'>%2</t> кг<br/>Кол-во: <t color='#00ff00'>%3</t>/<t color='#00ff00'>%4</t> шт.",ceil((_itemdata select 2)*(1+_tax)),(_item call fnc_getItemWeight),_a1,_a2]);
	} else {
		_description2 ctrlSetStructuredText (parseText format ["Цена: <t color='#00ff00'>%1</t> CRK<br/>Вес: <t color='#00ff00'>%2</t> кг<br/>Кол-во: <t color='#00ff00'>%3</t>/<t color='#00ff00'>%4</t> шт.",ceil(([_itemdata select 1,_itemdata select 3,_itemdata select 2] call fnc_getItemStockPrice)*(1+_tax)),(_item call fnc_getItemWeight),_a1,_a2]);	
	};
	//_description2 ctrlSetStructuredText (parseText "asdasdasd");
	
};
publicVariable "fnc_shopItemDesc";
fnc_openGarage = {
	
	private ["_code","_args","_result","_garage","_platez","_dataos"];
	
	_garage = _this select 0;
	
	garagespawn = format ["%1_spawn", _garage];
	
	/*_args = [getPlayerUID player,_garage];
	
	_result = [fnc_getRes_remote_code_45,_args] call fnc_getResult;
	
	_result = (((call compile _result) select 1));*/
	
	
	
	
	
	_args = [getPlayerUID player,_garage];
	
	_result = [fnc_getRes_remote_code_45,_args] call fnc_getResult;	
	
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
		
		//_result = (((call compile _result) select 1) select 0) select 0;
		_result = (((call compile _result) select 1));
	
	} else {
	
		//systemChat "Не мультипарт!";
		
		//_result = (((call compile _result) select 1) select 0) select 0;
		_result = (((call compile _result) select 1));
	
	};
	
	//systemChat (str _result);
	//systemChat str (count toArray (str _result));
	
	//systemChat str (count toArray (str _result));
	
	//systemChat str _result;
		
	garage_array = [];
	
	_platez = [];
	
	{
		
		if !((format ["veh%1",(_x select 1)]) in servervehiclesarray) then {
			garage_array pushBack _x;
		};
		
		_platez pushBack str (_x select 1);
		
	} forEach _result;
	
	//hint str garage_array;
		
	//vehicle_keys = vehicle_keys arrayIntersect _platez;
	
	if (!(createDialog "garage_dialog")) exitWith {hint "Dialog Error!";};
	{
		lbAdd [1500, format ["%1", (_x select 0) call fnc_getItemName]];
	} foreach garage_array;
	
};
publicVariable "fnc_openGarage";
fnc_buyItem = {
	if antidupa exitWith {hint "Неизвестная ошибка!";};
	antidupa = true;
	
	disableSerialization;
	
	private ["_lb","_classname","_display","_itemstobuy_ctrl","_itemstosell_ctrl","_buyamount_ctrl","_sellamount_ctrl","_type228","_price","_maxstock","_stock","_cost","_params","_tax","_tex","_noplace"];
	
	_display = findDisplay 50100;
	_itemstobuy_ctrl = _display displayCtrl 1500;
	_buyamount_ctrl = _display displayCtrl 1401;
	_lb = _this;
	
	if (_lb < 0) exitWith {antidupa = false;};
	
	_classname = _itemstobuy_ctrl lbData _lb;
	_amount = (parseNumber (ctrlText 1401));
	closeDialog 0;
	_type228 = _classname call fnc_getItemType;
	
	
	_minimum = 1;
	if ((_amount<_minimum) or ((_amount/_minimum)!=round(_amount/_minimum))) exitWith {systemChat "Допустимы только целые числа"; antidupa = false;};
	_stock = [_classname, global_shops_array_classes select curshop] call fnc_getShopStock;
	_maxstock = [_classname, global_shops_array_classes select curshop] call fnc_getShopMaxStock;
	
	if (_maxstock==0) exitWith {["Магазин","Этот товар не продаётся.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls; antidupa = false;};
	
	if (_type228 == "vehicle") then {
		_amount = 1;
	};
	
	if (_stock>=0) then {
		if (_amount > _stock) then {_amount = _stock};	
	};
	
	if (_amount < 0) then {_amount = 0};
	if (_amount == 0) exitWith {antidupa = false;};
	
	_price = ((((global_shops_array_items select curshop) select 0) select _lb) select 2);
	
	
	if (_stock>=0) then {
		_price = ([_stock,_maxstock,_price] call fnc_getItemStockPrice);
	};
	
	_tax = 0;
	
	if legalshopyesno then {	
		_tax = nds_tax;
	};
		
	_cost = ceil(_price*_amount*(1+_tax));	
	
	//_cost = ((((global_shops_array_items select curshop) select 0) select _lb) select 2)*(1+_tax)*_amount;
	
	//systemChat str _cost;
	
	//_cost = round(_cost);
	
	_license = ((((global_shops_array_items select curshop) select 0) select _lb) select 5);
	
	_box = (global_shops_array_classes select curshop) call fnc_getShopCrate;
	_spawn = (global_shops_array_classes select curshop) call fnc_getShopSpawn;
	
	_noplace = false;
	
	if (_type228 == "vehicle") then {
		if ((count (nearestObjects [_spawn, ["LandVehicle","Air"], 5]))>0) then {
			_noplace = true;
		};
	};
	
	if _noplace exitWith {systemChat "Место занято другим автомобилем. При необходимости вызовите сотрудников полиции."; antidupa = false;};
	
	//systemChat str _box;
	
	_money = "money" call fnc_getItemAmount;
	if ((not (_license call fnc_playerHasLicense)) and (not (_license == "none"))) exitWith {["Магазин",format ["Необходима %1", _license call fnc_getLicenseName],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls; antidupa = false;};
	if (_cost > _money) exitWith {["Магазин","Недостаточно денег.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls; antidupa = false;};
	
	gov_money = gov_money + round(_price*_amount*_tax);
	publicVariable "gov_money";
	
	["money", _cost] call fnc_removeItem;
	
	if (_stock>=0) then {
		[_classname, _amount, global_shops_array_classes select curshop] call fnc_removeShopStock;
	};
	switch _type228 do {
		case "item": {
			[_classname, _amount] call fnc_addItem;
		};
		case "weapon": {
			_box addWeaponCargo [_classname, _amount];
		};
		case "magazine": {
			_box addMagazineCargo [_classname, _amount];
		};
		case "gameitem": {
			_box addItemCargo [_classname, _amount];
		};
		case "uniform": {
			_box addItemCargo [_classname, _amount];
		};
		case "vest": {
			_box addItemCargo [_classname, _amount];
		};
		case "backpack": {
			_box addBackpackCargo [_classname, _amount];
		};
		case "vehicle": {
			
			//_regplate = format ["%1_%2", player, round(time)];
			_regplate = str currentplate;
			currentplate = currentplate + 1;
			publicVariable "currentplate";
			_vehname = format ["veh_%1",_regplate];
			
			call compile format ["%1 = createVehicle [_classname, getPos _spawn, [], 3, ''];",_vehname];		
			
			_veh = call compile _vehname;
			/*
			_veh setVehicleVarName format ["veh%1",_regplate];
			
			call compile format ["%1 = %2;",format ["veh%1",_regplate],_vehname];*/
			
			[_veh,_regplate] remoteExec ["fnc_vehicleVarNameRemote",0,true];
			missionNamespace setVariable [format ["veh%1",_regplate],_veh,true];
			
			_params = ((((global_shops_array_items select curshop) select 0) select _lb) select 6);
			
			_veh setVariable ["tuning_data",["none",0],true];
			_veh setVariable ["owner",getPlayerUID player,true];
			
			_veh remoteExec ["fnc_offroadSpeedLimit",2];
			
			if ((str player) in cop_array) then {
				_veh setVariable ["policevehicle",true,true];
			};
			
			_tex = (items_array select (items_classes find _classname)) select 6;
			
			if ((count _params) == 0) then {
			
				if (count (_tex select 0) > 0) then {
				
					if (((_tex select 0) select 0)!="none") then {
					
						_params = _tex select 0;
					
					};
				
				};
			
			};
			
			if ((count _params) > 0) then {
				
				//systemChat str _params;
				//_params = _params select 0;
				{
					_veh setObjectTextureGlobal [_forEachIndex,_x];
				} forEach _params;
				_veh setVariable ["tuning_data",[_params,0],true];
				
			};
			
			publicVariable format ["veh%1",_regplate];
			//servervehiclesarray pushBack str _veh;
			servervehiclesarray pushBack format ["veh%1",_regplate];
			//systemChat str servervehiclesarray;
			publicVariable "servervehiclesarray";
			
			_veh lock true;
			_veh setDir (getDir _spawn);
			clearWeaponCargoGlobal _veh;
			clearMagazineCargoGlobal _veh;
			clearItemCargoGlobal _veh;
			clearBackpackCargoGlobal _veh;
			_veh setVariable ["regplate", _regplate, true];
			_veh setVariable ["trunkitems", [], true];
			_veh setVariable ["trunkamounts", [], true];
			vehicle_keys pushBack _regplate;
		};
	};
	["Магазин",format ["Вы купили %1 %2 за %3 CRK.", _amount, _classname call fnc_getItemName, [_cost] call fnc_numberToText],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	
	(format ["[%1|%2|%7] has bought %3 %4 for %5 at %6", name player, getPlayerUID player, _amount, _classname, [_cost] call fnc_numberToText, curshop, side player]) remoteExec ["fnc_logMyStuff",2];
	
	antidupa = false;
	
};
publicVariable "fnc_buyItem";
fnc_vehicleVarNameRemote = {
	_veh = _this select 0;
	_regplate = _this select 1;
	_veh setVehicleVarName format ["veh%1",_regplate];
			
	//call compile format ["%1 = %2;",format ["veh%1",_regplate],format ["veh_%1",_regplate]];
	//call compile format ["%1 = %2;",format ["veh%1",_regplate], _veh];
	
	//missionNamespace setVariable [format ["veh%1",_regplate],_veh,true];
	
};
publicVariable "fnc_vehicleVarNameRemote";
fnc_numberToText = {
	
	private ["_number","_mod","_digits","_digitsCount","_modBase","_numberText"];
	_number = [_this,0,0,[0]] call bis_fnc_param;
	_mod = [_this,1,3,[0]] call bis_fnc_param;
	_digits = _number call bis_fnc_numberDigits;
	_digitsCount = count _digits - 1;
	_modBase = _digitsCount % _mod;
	_numberText = "";
	{
		_numberText = _numberText + str _x;
		if ((_foreachindex - _modBase) % (_mod) == 0 && _foreachindex != _digitsCount) then {_numberText = _numberText + "";};
	} foreach _digits;
	_numberText
};
publicVariable "fnc_numberToText";
fnc_paintVehicle = {
	
				
};
publicVariable "fnc_paintVehicle";
fnc_getItemStockPrice = {
	
	private ["_stock","_maxstock","_price","_demand"];
	
	_stock = _this select 0;
	_maxstock = _this select 1;
	_price = _this select 2;
	
	if (_maxstock==0) then {
		//nothing
	} else {
		_demand = _price*0.25*(_stock-(_maxstock*0.5))/(0.5*_maxstock);
		_price = round(_price - _demand);
	};
	
	_price
	
};
publicVariable "fnc_getItemStockPrice";
fnc_sellItem = {
	if antidupa exitWith {hint "Неизвестная ошибка!";};
	antidupa = true;
	
	disableSerialization;
	
	private ["_lb","_classname","_display","_itemstobuy_ctrl","_itemstosell_ctrl","_buyamount_ctrl","_sellamount_ctrl","_type228","_regplate","_vehicle","_sellprice","_maxstock","_stock","_cost","_price","_legal","_shop_object"];
	
	_display = findDisplay 50100;
	_itemstobuy_ctrl = _display displayCtrl 1501;
	_buyamount_ctrl = _display displayCtrl 1401;
	_lb = _this;
	
	if (_lb < 0) exitWith {antidupa = false;};
	
	_box = (global_shops_array_classes select curshop) call fnc_getShopCrate;
	_spawn = (global_shops_array_classes select curshop) call fnc_getShopSpawn;
	
	_vehicle = "none";
	_regplate = "none";
	_classname = _itemstobuy_ctrl lbData _lb;
	_amount = (parseNumber (ctrlText 1401));
	closeDialog 0;
	if (_classname in vehicle_keys) then {
		
		_regplate = _classname;
		_classname = "none";
		{
			if ((_x getVariable ["regplate","none"]) == _regplate) then {
				_classname = typeOf _x;
				_vehicle = _x;
			};
		} forEach ((position _spawn) nearObjects ["AllVehicles", 50]);
		
		//systemChat str _regplate;
		//systemChat str _classname;
		
	};
	
	_legal = _classname call fnc_getItemLegal;
	_shop_object = call compile ((global_shops_array select curshop) select 3);
		
	_index = ((global_shops_array_items select curshop) select 1) find _classname;
	_type228 = _classname call fnc_getItemType;
	
	
	_minimum = 1;
	if ((_amount<_minimum) or ((_amount/_minimum)!=round(_amount/_minimum))) exitWith {systemChat "Допустимы только целые числа"; antidupa = false;};
	_stock = [_classname, global_shops_array_classes select curshop] call fnc_getShopStock;
	_maxstock = [_classname, global_shops_array_classes select curshop] call fnc_getShopMaxStock;
		
	//if (_amount > _stock) then {_amount = _stock};
	if (_amount > (_classname call fnc_getItemAmount)) then {_amount = (_classname call fnc_getItemAmount)};
	if (_type228 == "vehicle") then {_amount = 1;};
	
	if (_stock>=0) then {
		if (_stock+_amount>_maxstock) then {_amount=_maxstock-_stock};
	};
	if (_amount < 0) then {_amount = 0};
	if (_amount == 0) exitWith {antidupa = false;};
		
	_price = ((((global_shops_array_items select curshop) select 0) select _index) select 2);
	
	if (_stock>=0) then {
		_price = ([_stock,_maxstock,_price] call fnc_getItemStockPrice);
	};
	
	_cost = floor((_price*_amount)/2);	
	
	["money", _cost] call fnc_addItem;
	
	if (_stock>=0) then {
		[_classname, _amount, global_shops_array_classes select curshop] call fnc_addShopStock;
	};
		
	switch _type228 do {
		case "item": {
			[_classname, _amount] call fnc_removeItem;
		};
		case "weapon": {
			_box addWeaponCargoGlobal [_classname, _amount];
		};
		case "magazine": {
			_box addMagazineCargoGlobal [_classname, _amount];
		};
		case "gameitem": {
			_box addItemCargoGlobal [_classname, _amount];
		};
		case "uniform": {
			_box addItemCargoGlobal [_classname, _amount];
		};
		case "vest": {
			_box addItemCargoGlobal [_classname, _amount];
		};
		case "backpack": {
			_box addItemCargoGlobal [_classname, _amount];
		};
		case "vehicle": {
			
			servervehiclesarray = servervehiclesarray - [str _vehicle];
			publicVariable "servervehiclesarray";
			
			deleteVehicle _vehicle;
			vehicle_keys = vehicle_keys - [_regplate];	
			private ["_code","_args","_result"];
			
			_args = [_regplate];
			
			_result = [fnc_getRes_remote_code_46,_args] call fnc_getResult;
			
		};
	};
	
	private ["_isellers_array","_isell_index"];
		
	if !_legal then {
				
		_isellers_array = _shop_object getVariable ["isellers_array",[[],[],[]]];
				
		_isell_index = ((_isellers_array select 0) find (getPlayerUID player));
		
		
		if (_isell_index < 0) then {
		
			(_isellers_array select 0) pushBack (getPlayerUID player);
			(_isellers_array select 1) pushBack _cost;
			(_isellers_array select 2) pushBack ([player,true] call fnc_getRealName);
		
		} else {
		
			(_isellers_array select 1) set [_isell_index, ((_isellers_array select 1) select _isell_index)+_cost];			
			(_isellers_array select 2) set [_isell_index, [player,true] call fnc_getRealName];			
		
		};
		
		_shop_object setVariable ["isellers_array",_isellers_array,true];
	
	};
	["Магазин",format ["Вы продали %1 %2 за %3 CRK.", [_amount] call fnc_numberToText, _classname call fnc_getItemName, [_cost] call fnc_numberToText],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
		
	if (("napa" in licenses_illegal) and (_classname in ["heroin","mdma","amphetamine","mari","lsd","psilo"])) then {
		if ((roleplay_pts>0) and (roleplay_pts-_amount*4>=0)) then {
		
			//roleplay_pts = roleplay_pts-_amount*4;
			[_amount*4,true] call fnc_removeRPP;
		
		};
		if ((roleplay_pts>0) and (roleplay_pts-_amount*4<0)) then {
		
			//roleplay_pts = 0;
			[_amount*4,true] call fnc_removeRPP;
		
		};
		["НаПа",format ["Вы потеряли %1 RPP за продажу наркотиков.",_amount*4],[1,1,1,1],[0.8,0,0,0.8]] spawn fnc_notifyMePls;
	};
	antidupa = false;
	
};
publicVariable "fnc_sellItem";
fnc_sellCrateItems = {
	if (antidupa and ((lastdupa+5)>time)) exitWith {hint "Неизвестная ошибка! Подождите 5 секунд!";};
	
	antidupa = true;
	lastdupa = time;
	
	private ["_crate","_shop","_containeritems","_unsellable","_sellable","_items","_classnames","_totalprice","_cost","_index","_msg","_confirmMsg","_confirmitems","_stock","_maxstock","_exitvar"];
	
	_crate = _this select 0;
	_shop = _crate getVariable ["shop","none"];
	
	_exitvar = false;
	
	if (_shop in gangareas_array) then {
		if ((((call compile _shop) getVariable ["flagowner","none"])=="none") or (((call compile _shop) getVariable ["flagowner","none"])!=(call fnc_getMyGang))) exitWith {antidupa = false; _exitvar = true;};
	};
	
	if _exitvar exitWith {["Магазин","Эта территория не принадлежит вам!",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls; antidupa = false;};
	
	curshop = (global_shops_array_classes find _shop);
	_containeritems = (itemCargo _crate) + (magazineCargo _crate) + (weaponCargo _crate) + (backpackCargo _crate);
	_unsellable = [];
	_sellable = [];
	_items = _shop call fnc_getShopItems;
	_classnames = _items select 1;
	_items = _items select 0;
	_totalprice = 0;
	
	{
		if (!(_x in _classnames)) then {
			if (!(_x in _unsellable)) then {
				_unsellable pushBack _x;
			};
		} else {
			_sellable pushBack _x;
			_index = ((global_shops_array_items select curshop) select 1) find _x;			
			_cost = ((((global_shops_array_items select curshop) select 0) select _index) select 2);
			
			_stock = [_x, global_shops_array_classes select curshop] call fnc_getShopStock;
			_maxstock = [_x, global_shops_array_classes select curshop] call fnc_getShopMaxStock;
			
			if (_stock>=0) then {
				_cost = ([_stock,_maxstock,_cost] call fnc_getItemStockPrice);
			};
					
			_cost = round(_cost/2);
			_totalprice = _totalprice + _cost;
		};
	} foreach _containeritems;
		
	if (count _unsellable > 0) exitWith {
		_msg = "";
		{
			_msg = _msg + (_x call fnc_getItemName) + " ";
		} foreach _unsellable;
		[format ['%1не интересуют торговца, уберите их из ящика.', _msg], "Ошибка"] call BIS_fnc_guiMessage;
	
		antidupa = false;
	};
	_confirmMsg = format ["Вы получите %1 CRK за:<br/>", [_totalprice] call fnc_numberToText];
	_confirmitems = [];
	_stock = [];
		
	{	
		if (!(_x in _confirmitems)) then {
			_item = _x;
			_itemName = _item call fnc_getItemName;
			_amount = {_x == _item} count _sellable;
			_confirmMsg = _confirmMsg + format ["<br/>%1 x  %2", _amount, _itemName];
			_confirmitems pushBack _x;
			_stock pushBack [_item,_amount];
		};
	} foreach _sellable;
	
	if ([parseText _confirmMsg, "Confirm", "Продать", true] call BIS_fnc_guiMessage) then
	{
		{
			if (([_x select 0, global_shops_array_classes select curshop] call fnc_getShopStock) >=0) then {
				[_x select 0, _x select 1, global_shops_array_classes select curshop] call fnc_addShopStock;
			};
		} forEach _stock;
		
		clearBackpackCargoGlobal _crate;
		clearMagazineCargoGlobal _crate;
		clearWeaponCargoGlobal _crate;
		clearItemCargoGlobal _crate;
		["money",_totalprice] call fnc_addItem;
		
		["Магазин",format ["Вы продали предметы из ящика за %1 CRK.", [_totalprice] call fnc_numberToText],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	};
	
	antidupa = false;
};
publicVariable "fnc_sellCrateItems";
fnc_setUpNarcoLab = {
	
	/*private ["_lab"];
	
	if ((str player) in cop_array) exitWith {systemChat "Сер вы что охуели?";};
	
	["narcolab",1] call fnc_removeItem;
	
	_lab = createVehicle ["Land_tent_east", getPosATL player, [], 0, "CAN_COLLIDE"];
	_lab setVariable ["labowner",getPlayerUID player,true];
	_lab allowDamage false;
	
	["Нарколаборатория","Вы установили нарколабораторию.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;*/
	
	
	private ["_lab","_cities","_villages","_detected"];
	
	if ((str player) in cop_array) exitWith {systemChat "Сер вы что охуели?";};
	
	["narcolab",1] call fnc_removeItem;
	
	_lab = createVehicle ["Land_tent_east", getPosATL player, [], 0, "CAN_COLLIDE"];
	_lab setVariable ["labowner",getPlayerUID player,true];
	_lab allowDamage false;		
	_cities = (nearestLocations [getPos _lab, ["NameCityCapital","NameCity"], 750, getPos _lab]);
	_villages = (nearestLocations [getPos _lab, ["NameVillage"], 500, getPos _lab]);
	_detected = "none";
	
	if ((count _cities) == 0) then {
	
		if ((count _villages)>0) then {
			_detected = _villages select 0;
		};
	
	} else {
	
		_detected = _cities select 0;
	
	};
	
	switch (typeName _detected) do {
	
		case "STRING": {
			["Нарколаборатория","Вы установили нарколабораторию. Местные жители смогут обнаружить её в течение примерно получаса.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
			["les",_lab,_detected] remoteExec ["fnc_detectNarcoLab",2];
		};
		
		case "LOCATION": {
			["Нарколаборатория","Вы установили нарколабораторию. Местные жители смогут обнаружить её в течение примерно 10 минут.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
			["gorod",_lab,_detected] remoteExec ["fnc_detectNarcoLab",2];
		};
	
	};
	
	/*
	
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
		
	};*/
	
};
publicVariable "fnc_setUpNarcoLab";
fnc_detectNarcoLab = {
	private ["_mesto","_lab","_detected","_wait","_markernamelol"];
	
	_mesto = _this select 0;
	_lab = _this select 1;
	_detected = _this select 2;
	_wait = round ((20 + (random 40))*60);
	//_wait = round ((0.2 + (random 0))*60);
	
	if (_mesto == "gorod") then {
		_wait = round ((1 + (random 19))*60);
		//_wait = round ((0.1 + (random 0))*60);
	};
	
	sleep _wait;
	
	if (alive _lab) then {
	
		[_detected] remoteExec ["fnc_infoAboutLab"];
		
		_markernamelol = format ["narcolab_%1%2", round (random 123), time];
		
		createMarker [_markernamelol, getPos _lab];
		_markernamelol setMarkerShape "ICON";
		_markernamelol setMarkerType "mil_marker";
		_markernamelol setMarkerColor "ColorRed";
		_markernamelol setMarkerText "НАРКОЛАБОРАТОРИЯ";
			
		//[_markernamelol] remoteExec ["fnc_wantedMarkerDecay",2];
		
		waitUntil {!alive _lab};
		
		deleteMarker _markernamelol;
	
	};
	
};
publicVariable "fnc_detectNarcoLab";
fnc_infoAboutLab = {
	private ["_detected"];
	
	_detected = _this select 0;
	
	if ((text _detected) == "none") then {
		systemChat "Местные жители обнаружили нарколабораторию на вукоёбине.";
	} else {	
		systemChat format ["Недалеко от %1 местные жители обнаружили нарколабораторию.", text _detected];
	};
};
publicVariable "fnc_infoAboutLab";
fnc_destroyDrugLab = {
	
	private ["_lab","_uid","_code","_args"];
	
	_lab = (nearestObjects [player, ['Land_tent_east'], 5]);
	
	if (count _lab == 0) exitWith {};
		
	if !([parseText "Вы точно хотите уничтожить лабораторию?", "Confirm", "Уничтожить", true] call BIS_fnc_guiMessage) exitWith {};
	
	_lab = _lab select 0;
	_uid = _lab getVariable ["labowner","none"];
	
	//if ((str player) in cop_array) exitWith {systemChat "Сер вы что охуели?";};
	
	deleteVehicle _lab;
	
	_args = [_uid];
	
	_args remoteExec ["fnc_destroyDrugLab_remote_code1"];
	
	if ((str player) in cop_array) then {
		["Нарколаборатория","Вы уничтожили нарколабораторию и получаете 100'000 CRK в награду.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
		deposit = deposit + 100000;
	} else {
		["Нарколаборатория","Вы уничтожили нарколабораторию.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	};
};
publicVariable "fnc_destroyDrugLab";
fnc_destroyDrugLab_remote_code1 = {
		
		if ((getPlayerUID player) in _this) then {
			
			["Нарколаборатория","Ваша нарколаборатория была уничтожена!",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
			
		};
		
	};
publicVariable "fnc_destroyDrugLab_remote_code1";
fnc_samogonTeachMe = {
	
	private ["_confirmMsg"];
	
	if (("vodka_taras" call fnc_getItemAmount) < 5) exitWith {
		["Самогонщик-грибонюх","Притащи пять бутылок 'Тараса', на сухое горло болтать неохота...",[1,1,1,1],[0.8,0,0,0.8]] spawn fnc_notifyMePls;
	};
	
	_confirmMsg = "С тебя пять пузырей и я научу тебя гнать охуенный самогон и расскажу о том как найти волшебные, ебать, грибы.";
	
	if ([parseText _confirmMsg, "Согласен?", "Согласен", true] call BIS_fnc_guiMessage) then
	{
		
		if (("vodka_taras" call fnc_getItemAmount) < 5) exitWith {
			["Самогонщик-грибонюх","Притащи пять бутылок 'Тараса' и тогда поболтаем...",[1,1,1,1],[0.8,0,0,0.8]] spawn fnc_notifyMePls;
		};
		
		["vodka_taras",5] call fnc_removeItem;
		
		licenses_illegal = licenses_illegal + ["samogon"];
		
		["Самогонщик-грибонюх","Теперь ты знаешь как искать и сушить псилоцибе и умеешь самогон.",[1,1,1,1],[0.8,0,0,0.8]] spawn fnc_notifyMePls;
		
	};
	
	
	
};
publicVariable "fnc_samogonTeachMe";
fnc_gribyPickup = {
	
	private ["_grib","_amount"];
	
	if (count (nearestObjects [getpos player, ['Baseball'], 2]) < 1) exitWith {
		["Рядом нет грибов.","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	};
	
	_grib = ((nearestObjects [getpos player, ['Baseball'], 2]) select 0);
	_amount = (_grib getVariable ['grib',0]);
	
	if !(_amount > 0) exitWith {
		["Это не гриб.","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	};
		
	deleteVehicle _grib;
	
	["grib",_amount] call fnc_addItem;
	
	[format ["Вы нашли %1 съедобных грибов.",_amount]] spawn fnc_itemNotifyMePls;
	
	if ("samogon" in licenses_illegal) then {
		_amount = round (random (_amount/2));
		["psilocybe",_amount] call fnc_addItem;
		[format ["Вы нашли %1 псилоцибе.",_amount]] spawn fnc_itemNotifyMePls;
	};
	
};
publicVariable "fnc_gribyPickup";
fnc_buySlave_code = {
	
	private ["_slave","_owner","_condition"];
	
	_slave = _this select 0;
	_owner = _this select 1;
	
	while {true} do {
		
		if !(alive _slave) exitWith {sleep 10; deleteVehicle _slave;};
		if !(_owner in playableUnits) exitWith {[_slave] join grpNull};
		
	};
	
};
publicVariable "fnc_buySlave_code";
fnc_playerResetAnim_remote = {(_this select 0) switchMove '';};
publicVariable "fnc_playerResetAnim_remote";
fnc_playerStun_remote = {
	_this switchMove "Incapacitated";
	if (_this==player) then {
	
		stunned = true;
		stuncountdown = stuncountdown + 20;
		
		_anim = "Incapacitated";
			
		{inGameUISetEventHandler [_x, "true"]} forEach ["PrevAction", "NextAction","Action"];
		while {stunned} do {
								
			if !(player getVariable ["restrained",false]) then {
				if (((vehicle player)==player) and ((animationState player)!="incapacitated")) then {
					[player,_anim] remoteExec ["fnc_playerSwitchMove_remote"];
				};
			};
			
			
				
			if !(alive player) exitWith {};
				
			uiSleep 0.1;
		};
		if !(player getVariable ["restrained",false]) then {
		
			//[player,""] remoteExec ["fnc_playerSwitchMove_remote"];
			[player,"AmovPpneMstpSnonWnonDnon"] remoteExec ["fnc_playerSwitchMove_remote"];
				
			{inGameUISetEventHandler [_x, "false"]} forEach ["PrevAction", "NextAction","Action"];
		
		};
	};
};
publicVariable "fnc_playerStun_remote";
fnc_playerSwitchMove_remote = {
	(_this select 0) switchMove (_this select 1);
};
publicVariable "fnc_playerSwitchMove_remote";
fnc_playerPlayMove_remote = {
	(_this select 0) playMove (_this select 1);
};
publicVariable "fnc_playerPlayMove_remote";
fnc_taxiRemote_code1 = {
					(_this select 0) assignAsCargo (_this select 1);
					[(_this select 0)] orderGetIn true;
					(_this select 0) moveInCargo (_this select 1);
				};
publicVariable "fnc_taxiRemote_code1";
fnc_taxiRemote_code2 = {
					(_this select 0) action ["getOut",(_this select 1)];
					unassignVehicle (_this select 0);
				};
publicVariable "fnc_taxiRemote_code2";
fnc_taxiRemote_code3 = {
					(_this select 0) action ["getOut",(_this select 1)];
					unassignVehicle (_this select 0);
					(_this select 0) doMove (_this select 2);
				};
publicVariable "fnc_taxiRemote_code3";
fnc_slavesRemote_code = {
				
				private ["_slave","_owner","_condition"];
				
				_slave = _this select 0;
				_owner = _this select 1;
				
				while {true} do {
					
					if !(alive _slave) exitWith {sleep 10; deleteVehicle _slave;};
					if !(_owner in playableUnits) exitWith {[_slave] join grpNull};
					
				};
				
			};
publicVariable "fnc_slavesRemote_code";
fnc_showLicenseToAll_remote = {
	private ["_license","_player"];
	
	_license = _this select 0;
	_player = _this select 1;
	
	if (player distance _player < 5) then {
	
		if ((goggles _player) in masks_array) then {
	
			systemChat format ["%1 показывает %2", "НЕИЗВЕСТНЫЙ", _license];
		
		} else {
			
			systemChat format ["%1 показывает %2", [_player,false] call fnc_getRealName, _license];
			
		};
	
	};
};
publicVariable "fnc_showLicenseToAll_remote";
fnc_showLicenseToAll = {
	private ["_license"];
	
	_license = _this select 0;
	
	[_license,player] remoteExec ["fnc_showLicenseToAll_remote"];
};
publicVariable "fnc_showLicenseToAll";
fnc_initCivLoadout = {
	private ["_uniform","_cap"];
	
	_uniform = selectRandom ["TRYK_U_B_Denim_T_WH","TRYK_U_B_Denim_T_BK","TRYK_U_B_BLK_T_WH","TRYK_U_B_RED_T_BR","TRYK_U_B_BLK_T_BK","TRYK_SUITS_BR_F","TRYK_SUITS_BLK_F","TRYK_U_denim_jersey_blu","TRYK_U_denim_jersey_blk","TRYK_shirts_DENIM_od","TRYK_shirts_DENIM_BWH","TRYK_shirts_DENIM_BL","TRYK_shirts_DENIM_BK","TRYK_U_B_C02_Tsirt","U_BG_Guerilla2_2","U_BG_Guerilla2_1","U_BG_Guerilla2_3","U_Marshal"];
	_cap = selectRandom ["H_Cap_blk","H_Cap_grn_BI","H_Cap_blu","H_Cap_grn","H_Cap_oli","H_Cap_red","H_Cap_tan","","","","","","","","","",""];
	removeAllWeapons player;
	removeAllItems player;
	removeAllAssignedItems player;
	removeUniform player;
	removeVest player;
	removeBackpack player;
	removeHeadgear player;
	removeGoggles player;
	player forceAddUniform _uniform;
	player addHeadgear _cap;
	player linkItem "ItemMap";
	player linkItem "ItemCompass";
	player linkItem "ItemWatch";
	player linkItem "ItemRadio";
};
publicVariable "fnc_initCivLoadout";
fnc_initCopLoadout = {
	removeAllWeapons player;
	removeAllItems player;
	removeAllAssignedItems player;
	removeUniform player;
	removeVest player;
	removeBackpack player;
	removeHeadgear player;
	removeGoggles player;
	player forceAddUniform "rds_uniform_Policeman";
	for "_i" from 1 to 3 do {player addItemToUniform "8Rnd_mas_9x18_Mag";};
	player addVest "rds_pistol_holster";
	for "_i" from 1 to 3 do {player addItemToVest "8Rnd_mas_9x18_Mag";};
	player addHeadgear "rds_police_cap";
	player addWeapon "hgun_mas_mak_F";
	player linkItem "ItemMap";
	player linkItem "ItemCompass";
	player linkItem "ItemWatch";
	player linkItem "ItemRadio";
};
publicVariable "fnc_initCopLoadout";
	//["Пфивет","Ну чо пфивет",[0.5,0.5,0.5,1],[0,0,0,1]] spawn fnc_notifyMe;
	
//["Банкомат","Допустимы только целые числа",[1,1,1,1],[0,0.68,0,0.8]] spawn fnc_notifyMePls;	
fnc_notifyMePls = {
	if (isNil "nots_array") then {
	
		nots_array = [];
	
	};
	if (isNil "curnot") then {curnot = 1;};
	waitUntil {!isNil "notifymepls"};
				
	notifymepls pushBack _this;
};
publicVariable "fnc_notifyMePls";
	
fnc_notifyMe = {
	private ["_title","_message","_tcolor","_bgcolor","_hud_nots","_hudtitle","_hudtext","_hudbg","_height","_delArray","_stroki"];
	_title = _this select 0;
	_message = _this select 1;
	_tcolor = _this select 2;
	_bgcolor = _this select 3;
	_delArray = [];
	_GUI_GRID_X	= 0;
	_GUI_GRID_Y = 0;
	_GUI_GRID_W = 0.025;
	_GUI_GRID_H = 0.04;
	_GUI_GRID_WAbs = 1;
	_GUI_GRID_HAbs = 1;
	
	_stroki = ((count (toArray _message))/45);
	if (_stroki!=(floor _stroki)) then {
		_stroki = floor ((count (toArray _message))/45);
	} else {
		_stroki = floor ((count (toArray _message))/45) - 1;
	};
	
	if (_stroki>=0) then {_stroki=_stroki+0.1};
	
	_height = 2 + _stroki;
	
	{
	
		if (_forEachIndex < 4) then {
	
			{
			
				(_x select 0) ctrlSetPosition [
				
					(ctrlPosition (_x select 0)) select 0,
					((ctrlPosition (_x select 0)) select 1) + _height*(0.022 * safezoneH) + 0.25*(0.022 * safezoneH),
					(ctrlPosition (_x select 0)) select 2,
					(_x select 1)
				
				];
				(_x select 0) ctrlCommit 0.25;
			
			} forEach (_x select 2);
		
		} else {
		
			_delArray pushBack _forEachIndex;
		
			{
			
				(_x select 0) spawn {
				
					_this ctrlSetFade 1;
					_this ctrlCommit 0.25;
					sleep 0.25;
					ctrlDelete _this;
				
				
				};
			
			} forEach (_x select 2);			
		
		};
	
	} forEach nots_array;
	
	{
	
		nots_array deleteAt _x;
	
	} forEach _delArray;
	
	
	_hud_nots = uiNamespace getVariable ["disp_notifications", findDisplay 46];
			
	_hudbg = _hud_nots ctrlCreate ["RscPicture", curnot];
	curnot = curnot + 1;
	_hudbg ctrlSetPosition
	[
		0.159687 * safezoneW + safezoneX,
		0.016 * safezoneH + safezoneY,
		0.201094 * safezoneW,
		0
	];
	_hudbg ctrlSetText "#(argb,8,8,3)color(0,0,0,0.75)";
	_hudbg ctrlCommit 0;
	_hudbg ctrlSetPosition
	[
		0.159687 * safezoneW + safezoneX,
		0.016 * safezoneH + safezoneY,
		0.201094 * safezoneW,
		_height * (0.022 * safezoneH)
	];
	_hudbg ctrlCommit 0.25;
	
	_hudtitle = _hud_nots ctrlCreate ["RscStructuredText", curnot];
	curnot = curnot + 1;
	_hudtitle ctrlSetPosition
	[
		0.159687 * safezoneW + safezoneX,
		0.016 * safezoneH + safezoneY,
		0.201094 * safezoneW,
		0
	];
	_hudtitle ctrlSetStructuredText parseText _title;
	_hudtitle ctrlSetTextColor _tcolor;
	_hudtitle ctrlSetBackgroundColor _bgcolor;
	_hudtitle ctrlCommit 0;
	_hudtitle ctrlSetPosition
	[
		0.159687 * safezoneW + safezoneX,
		0.016 * safezoneH + safezoneY,
		0.201094 * safezoneW,
		1 * (0.022 * safezoneH)
	];
	_hudtitle ctrlCommit 0.25;
	
	_hudtext = _hud_nots ctrlCreate ["RscStructuredText", curnot];
	curnot = curnot + 1;
	_hudtext ctrlSetPosition
	[
		0.159687 * safezoneW + safezoneX,
		0.016 * safezoneH + safezoneY + (0.022 * safezoneH),
		0.201094 * safezoneW,
		0
	];
	_hudtext ctrlSetStructuredText parseText _message;
	_hudtext ctrlCommit 0;
	_hudtext ctrlSetPosition
	[
		0.159687 * safezoneW + safezoneX,
		0.016 * safezoneH + safezoneY + (0.022 * safezoneH),
		0.201094 * safezoneW,
		(_height-1) * (0.022 * safezoneH)
	];
	_hudtext ctrlCommit 0.25;
	
	nots_array = [[_title,_message,[[_hudtitle,1 * (0.022 * safezoneH)],[_hudbg,_height * (0.022 * safezoneH)],[_hudtext,(_height-1) * (0.022 * safezoneH)]]]] + nots_array;
	sleep 0.25;
	
	[_hudtitle,_hudbg,_hudtext] spawn {
	
		sleep 6;
		
		{
		
			_x spawn {
				_this ctrlSetFade 1;
				_this ctrlCommit 0.25;
				sleep 0.25;
				ctrlDelete _this;
			};
		} forEach _this;
	
	};
	
};
publicVariable "fnc_notifyMe";	
fnc_itemNotifyMePls = {
	if (isNil "nots_array_items") then {
	
		nots_array_items = [];
	
	};
	if (isNil "curnot") then {curnot = 1;};
	waitUntil {!isNil "notifymepls_items"};
				
	notifymepls_items pushBack _this;
};
publicVariable "fnc_itemNotifyMePls";
	
fnc_itemNotifyMe = {
	private ["_message","_hud_nots","_hudtext","_height","_delArray","_width"];
	_message = _this select 0;
	_delArray = [];
	_GUI_GRID_X	= 0;
	_GUI_GRID_Y = 0;
	_GUI_GRID_W = 0.025;
	_GUI_GRID_H = 0.04;
	_GUI_GRID_WAbs = 1;
	_GUI_GRID_HAbs = 1;
	
	//_width = count toArray _message;
	_width = 20;
	_height = 1;
	
	{
	
		if (_forEachIndex < 4) then {
	
			{
			
				(_x select 0) ctrlSetPosition [
				
					(ctrlPosition (_x select 0)) select 0,
					((ctrlPosition (_x select 0)) select 1) - _height*(0.022 * safezoneH) - 0.25*(0.022 * safezoneH),
					(ctrlPosition (_x select 0)) select 2,
					(_x select 1)
				
				];
				(_x select 0) ctrlCommit 0.1;
			
			} forEach (_x select 1);
		
		} else {
		
			_delArray pushBack _forEachIndex;
		
			{
			
				(_x select 0) spawn {
				
					_this ctrlSetFade 1;
					_this ctrlCommit 0.1;
					sleep 0.1;
					ctrlDelete _this;
				
				
				};
			
			} forEach (_x select 1);			
		
		};
	
	} forEach nots_array_items;
	
	{
	
		nots_array_items deleteAt _x;
	
	} forEach _delArray;
	
	
	_hud_nots = uiNamespace getVariable ["disp_notifications", findDisplay 46];
		
	_hudtext = _hud_nots ctrlCreate ["RscStructuredText", curnot];
	curnot = curnot + 1;
	_hudtext ctrlSetPosition
	[
		0.78875 * safezoneW + safezoneX,
		0.808 * safezoneH + safezoneY,
		0.20625 * safezoneW,
		0
	];
	_hudtext ctrlSetStructuredText parseText format ["<t align='right'>%1</t> ",_message];
	_hudtext ctrlSetBackgroundColor [0,0,0,0.5];
	_hudtext ctrlCommit 0;
	_hudtext ctrlSetPosition
	[
		0.78875 * safezoneW + safezoneX,
		0.808 * safezoneH + safezoneY,
		0.20625 * safezoneW,
		1 * (0.022 * safezoneH)
	];
	_hudtext ctrlCommit 0.1;
	
	nots_array_items = [[_message,[[_hudtext,1 * (0.022 * safezoneH)]]]] + nots_array_items;
	sleep 0.1;
	
	[_hudtext] spawn {
	
		sleep 3;
		
		{
		
			_x spawn {
				_this ctrlSetFade 1;
				_this ctrlCommit 0.1;
				sleep 0.1;
				ctrlDelete _this;
			};
		} forEach _this;
	
	};
	
};
publicVariable "fnc_itemNotifyMe";
fnc_briefingStuff = {
	hint "Информация об управлении в дневнике при открытии карты.";
	systemChat "Информация об управлении в дневнике при открытии карты.";
	waitUntil {uiSleep 0.03; !isNull player && player == player};
	if(player diarySubjectExists "rules")exitwith{};
	player createDiarySubject ["maininfo","ИНФОРМАЦИЯ"];
	player createDiarySubject ["controls","УПРАВЛЕНИЕ"];
	
	player createDiaryRecord["maininfo",
		[
			"Группа в ВК",
				"Ставьте лайки, подписывайтесь на мой канал: vk.com/s_zagoria"
		]
	];
	player createDiaryRecord["controls",
		[
			"Основные клавиши",
				"Tab - включить/отключить клавиши<br/>1 - информация об игроке и законах<br/>2 - виртуальный инвентарь<br/>3 - таблица розыска и наград за поимку<br/>4 - меню банд<br/>0 - убрать оружие за спину<br/>Левый Win - взаимодействие с предметами и игроками / добыча ресурсов<br/>T - багажник транспорта<br/>U - закрыть/открыть транспорт<br/>Y - меню ключей от транспорта<br/>Shift+F - ударить ближайшего игрока<br/>H - спрятать/достать пистолет<br/>Shift+V - руки за голову"
		]
	];
};
publicVariable "fnc_briefingStuff";
fnc_boarKilledByPlayer_remote1 = {
	private ["_killer"];
	
	_killer = _this select 0;
	if (_killer!=player) exitWith {};
	
	if (("kaban_putevka" call fnc_getItemAmount)<1) then {
	
		[getPlayerUID player,"Браконьерство",5000,[player,true] call fnc_getRealName] call fnc_setPlayerWanted;
		["Внимание!","Вы были объявлены в розыск за браконьерство.",[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;
	
	} else {
	
		["kaban_putevka",1] call fnc_removeItem;
		
		if (("kaban_putevka" call fnc_getItemAmount)<1) then {
	
			["Внимание!","У вас больше не осталось путёвок на отстрел.",[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;
		
		};
	};
};
publicVariable "fnc_boarKilledByPlayer_remote1";
fnc_boarKilledByPlayer = {
	private ["_killer"];
	
	_killer = (_this select 1);
	
	[_killer] remoteExec ["fnc_boarKilledByPlayer_remote1"];
};
publicVariable "fnc_boarKilledByPlayer";
fnc_copDoprosShop = {
	private ["_shop","_isellers_array","_amount"];
	
	_shop = call compile _this;
	_isellers_array = _shop getVariable ["isellers_array",[[],[],[]]];
	_shop setVariable ["isellers_array",[[],[],[]],true];
	_amount = 0;
	
	{
	
		_amount = _amount + 1;
		[_x, "Сбыт запрещённых предметов", round (((_isellers_array select 1) select _forEachIndex)*1.5), (_isellers_array select 2) select _forEachIndex] call fnc_setPlayerWanted;
	
	} forEach (_isellers_array select 0);
	
	["Допрос",format ["Вы получили информацию о %1 преступниках. Они объявлены в розыск.",_amount],[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;
};
publicVariable "fnc_copDoprosShop";
fnc_mineButton = {
	private ["_resource","_req_tools","_new_req_tools"];
	
	_resource = "none";
	_req_tools = [];
	_new_req_tools = [];
	
	{
		if (player distance (getMarkerPos (_x select 0)) <= (_x select 1)) then {
			_req_tools = _x select 3;
			_resource = _x select 2;
		};
	} foreach mine_areas;
	
	if (_resource=="none") exitWith {/*["Добыча","Вы не в зоне добычи.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;*/};
		
	{
	
		_new_req_tools set [((count _req_tools) - 1) - _forEachIndex, _x];
	
	} forEach _req_tools;
	
	//systemChat str _new_req_tools;
	
	{
		//if (("jackhammer" in _req_tools) and (("jackhammer" call fnc_getItemAmount) > 0)) exitWith {[(inventory_items find "jackhammer"), 1] call fnc_useItem;};
		if ((_x in _req_tools) and ((_x call fnc_getItemAmount) > 0)) exitWith {[(inventory_items find _x), 1] call fnc_useItem;};
	} forEach _new_req_tools;
};
publicVariable "fnc_mineButton";
fnc_becomeSunni = {
	private ["_confirmMsg"];
	
	if ("napa" in licenses_illegal) exitWith {["Вероисповедание","Сначала покиньте Национальную Партию!",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	
	_confirmMsg = "Вы собираетесь сменить вероисповедание. Подобное решение не принимается просто так и всегда сопряжено с переживанием определённых событий в жизни и полным её переосмыслением, подумайте дважды. Это будет стоить вам 500 RPP.";
	
	if ([parseText _confirmMsg, "Подтвердить", "Ок", true] call BIS_fnc_guiMessage) then
	{
	
		if ("religion_cd" in (cooldown_array select 0)) exitWith {["Вероисповедание","Вы не можете менять вероисповедание слишком часто.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
		if (roleplay_pts<500) exitWith {["Вероисповедание","У вас недостаточно RPP для смены вероисповедания.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	
		religion="sunni";
		roleplay_pts=roleplay_pts-500;
		(cooldown_array select 0) pushBack "religion_cd";
		(cooldown_array select 1) pushBack 120;
		["Вероисповедание","Вы сменили вероисповедание.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	
	};
};
publicVariable "fnc_becomeSunni";
fnc_becomeOrthodox = {
	private ["_confirmMsg"];
	
	_confirmMsg = "Вы собираетесь сменить вероисповедание. Подобное решение не принимается просто так и всегда сопряжено с переживанием определённых событий в жизни и полным её переосмыслением, подумайте дважды. Это будет стоить вам 500 RPP.";
		
	if ("ig_lic" in licenses_illegal) exitWith {["Вероисповедание","Сначала покиньте ИГ!",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	
	if ([parseText _confirmMsg, "Подтвердить", "Ок", true] call BIS_fnc_guiMessage) then
	{
	
		if ("religion_cd" in (cooldown_array select 0)) exitWith {["Вероисповедание","Вы не можете менять вероисповедание слишком часто.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
		if (roleplay_pts<500) exitWith {["Вероисповедание","У вас недостаточно RPP для смены вероисповедания.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	
		religion="orthodox";
		roleplay_pts=roleplay_pts-500;
		(cooldown_array select 0) pushBack "religion_cd";
		(cooldown_array select 1) pushBack 120;
		["Вероисповедание","Вы сменили вероисповедание.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	
	};
};
publicVariable "fnc_becomeOrthodox";
fnc_getGarageSpawn = {
	(garages_array select (garages_array_classes find _this)) select 1
};
publicVariable "fnc_getGarageSpawn";
fnc_getGarageTypes = {
	(garages_array select (garages_array_classes find _this)) select 2
	
};
publicVariable "fnc_getGarageTypes";
fnc_medKit = {
	if (player==(vehicle player)) then {
		player playmove "AinvPknlMstpSlayWrflDnon_medic";
	};
	
	["medkit",1] call fnc_removeItem;
	
	sleep 7;
	
	if ((alive player) and ((damage player)>0.25)) then {
	
		player setDamage 0.25;
	
	};
};
publicVariable "fnc_medKit";
fnc_becomeNapaMember = {
	if !(religion in ["orthodox","catholic","protestant","atheism"]) exitWith {
		["Вы не можете вступить в Национальную Партию из-за своих религиозных убеждений.", "Нет, нет, нет..."] call BIS_fnc_guiMessage;
	};
	
	if (roleplay_pts<500) exitWith {["НаПа","У вас должно быть минимум 500 RPP для вступления.",[1,1,1,1],[0.8,0,0,0.8]] spawn fnc_notifyMePls;};
	
	private ["_confirmMsg"];
	
	_confirmMsg = "[При добровольном выходе вы потеряете 500 RPP и не сможете использовать оружие 30 минут!] Национальная Партия - оппозиционно настроенная организация христианских националистов. После разгрома ЧДКЗ в 2011 году является основным противником действующего правительства. Национальная Партия требует больших полномочий для парламента, большей экономической свободы, отличается антимигрантскими настроениями и является противником вступления Черноруссии в Евросоюз, так же полагает, что достичь демократии в текущем положении можно только вооружённы";
	
	if ([parseText _confirmMsg, "Вступить?", "Согласен", true] call BIS_fnc_guiMessage) then
	{
		
		licenses_illegal = licenses_illegal + ["napa"];
		
		["НаПа","Добро пожаловать в силы копротивления!",[1,1,1,1],[0.8,0,0,0.8]] spawn fnc_notifyMePls;
		
	};	
	
};
publicVariable "fnc_becomeNapaMember";
fnc_leaveNapa = {
	
	private ["_confirmMsg"];
	
	_confirmMsg = "Вы действительно хотите покинуть Национальну Партию? Вы потеряете 500 RPP и не сможете применять оружие 30 минут.";
	
	if ([parseText _confirmMsg, "Покинуть?", "Согласен", true] call BIS_fnc_guiMessage) then
	{
		
		licenses_illegal = licenses_illegal - ["napa"];
		
		["НаПа","Давай, до свидания.",[1,1,1,1],[0.8,0,0,0.8]] spawn fnc_notifyMePls;
		
		roleplay_pts = roleplay_pts - 500;
		
		if (((cooldown_array select 0) find "gun_cd")<0) then {
					
			(cooldown_array select 0) pushBack "gun_cd";
			(cooldown_array select 1) pushBack 30;
					
		} else {
					
			(cooldown_array select 1) set [(cooldown_array select 0) find "gun_cd", 30];
					
		};
		
	};	
	
};
publicVariable "fnc_leaveNapa";
fnc_becomeISMember = {
	if !(religion in ["sunni"]) exitWith {
		["Вы не можете вступить в ИГ из-за своих религиозных убеждений.", "Нет, нет, нет..."] call BIS_fnc_guiMessage;
	};
	
	if (roleplay_pts<500) exitWith {["НаПа","У вас должно быть минимум 500 RPP для вступления.",[1,1,1,1],[0.8,0,0,0.8]] spawn fnc_notifyMePls;};
	
	private ["_confirmMsg"];
	
	_confirmMsg = "[При добровольном выходе вы потеряете 500 RPP и не сможете использовать оружие 30 минут!] ИГ - международная террористическая группировка с экстремистской радикальной идеологией, основанной на исламе суннитского толка. Её члены считают своей задачей агрессивное продивжение исламизма и установление власти шариата на подконтрольных территориях. Террористы ИГ совершают различные террористические акты, чтобы посеять страх среди местного населения, охотятся на бывших мусульман, покинувших ислам, и занимаются распространением экстремистской л";
	
	if ([parseText _confirmMsg, "Вступить?", "Согласен", true] call BIS_fnc_guiMessage) then
	{
		
		licenses_illegal = licenses_illegal + ["ig_lic"];
		
		["ИГ","Добро пожаловать!",[1,1,1,1],[0.8,0,0,0.8]] spawn fnc_notifyMePls;
		
	};	
	
};
publicVariable "fnc_becomeISMember";
fnc_leaveIS = {
	
	private ["_confirmMsg"];
	
	_confirmMsg = "Вы действительно хотите покинуть ИГ? Вы потеряете 500 RPP и не сможете применять оружие 30 минут.";
	
	if ([parseText _confirmMsg, "Покинуть?", "Согласен", true] call BIS_fnc_guiMessage) then
	{
		
		licenses_illegal = licenses_illegal - ["ig_lic"];
		
		["ИГ","Давай, до свидания.",[1,1,1,1],[0.8,0,0,0.8]] spawn fnc_notifyMePls;		
		
		roleplay_pts = roleplay_pts - 500;
		
		if (((cooldown_array select 0) find "gun_cd")<0) then {
					
			(cooldown_array select 0) pushBack "gun_cd";
			(cooldown_array select 1) pushBack 30;
					
		} else {
					
			(cooldown_array select 1) set [(cooldown_array select 0) find "gun_cd", 30];
					
		};
	};	
	
};
publicVariable "fnc_leaveIS";
fnc_repairTransformer = {
	private ["_transformer","_price"];
	
	_transformer = _this select 0;
	_price = _this select 1;
	
	if (("money" call fnc_getItemAmount)<_price) exitWith {["Трансформатор","Не хватает денег для ремонта.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	
	["money",10000] call fnc_removeItem;
	_transformer setDamage 0;
	["Трансформатор","Ремонт успешно произведён!",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	
};
publicVariable "fnc_repairTransformer";
fnc_smugglerContract = {
	if !(religion in ["sunni"]) exitWith {
		["Вы не можете вступить в ИГ из-за своих религиозных убеждений.", "Нет, нет, нет..."] call BIS_fnc_guiMessage;
	};
	
	if (roleplay_pts<500) exitWith {["НаПа","У вас должно быть минимум 500 RPP для вступления.",[1,1,1,1],[0.8,0,0,0.8]] spawn fnc_notifyMePls;};
	
	private ["_confirmMsg"];
	
	_confirmMsg = "[При добровольном выходе вы потеряете 500 RPP и не сможете использовать оружие 30 минут!] ИГ - международная террористическая группировка с экстремистской радикальной идеологией, основанной на исламе суннитского толка. Её члены считают своей задачей агрессивное продивжение исламизма и установление власти шариата на подконтрольных территориях. Террористы ИГ совершают различные террористические акты, чтобы посеять страх среди местного населения, охотятся на бывших мусульман, покинувших ислам, и занимаются распространением экстремистской л";
	
	if ([parseText _confirmMsg, "Вступить?", "Согласен", true] call BIS_fnc_guiMessage) then
	{
		
		licenses_illegal = licenses_illegal + ["ig_lic"];
		
		["ИГ","Добро пожаловать!",[1,1,1,1],[0.8,0,0,0.8]] spawn fnc_notifyMePls;
		
	};	
	
};
publicVariable "fnc_smugglerContract";
fnc_destroyDrugsNapa = {
	private ["_confirmMsg"];
	
	_confirmMsg = "Вы собираетесь уничтожить все наркотики в вашем инвентаре. За каждую уничтоженную единицу вы получите 2 RPP и 1000 CRK.";
	
	if ([parseText _confirmMsg, "Уничтожить наркотики?", "Согласен", true] call BIS_fnc_guiMessage) then
	{
	
		{
		
			private ["_namount"];
			
			_namount = (_x call fnc_getItemAmount);
		
			if (_namount>0) then {
			
				[_x, _namount] call fnc_removeItem;
				//roleplay_pts = roleplay_pts+_namount*2;
				(_namount*2) call fnc_addRPP;
				["money",_namount*1000] call fnc_addItem;
				["НаПа",format ["Уничтожено %1 %2.", _namount, _x call fnc_getItemName],[1,1,1,1],[0.8,0,0,0.8]] spawn fnc_notifyMePls;
			
			};
		
		} forEach ["heroin","mdma","amphetamine","mari","lsd","psilo"];
		
		["НаПа","Теперь эта отрава не попадёт на улицы.",[1,1,1,1],[0.8,0,0,0.8]] spawn fnc_notifyMePls;
		
	};	
};
publicVariable "fnc_destroyDrugsNapa";
fnc_inventoryOpenedScript = {
	params ["_unit","_container","_secondaryContainer"];
	
	if (((str _container) in servervehiclesarray) and ((locked _container) == 2) and !((_container getVariable ["regplate","none"]) in vehicle_keys)) exitWith {
		hint "Багажник заперт.";
		true;
	};
	if ((_container getVariable ["nowOpenedBy","none"])!="none") exitWith {
	
		hint "Уже кем-то открыто";
		
		private ["_uid","_doit"];
		
		_uid = (_container getVariable ["nowOpenedBy","none"]);
		_doit = true;
		
		{
		
			if ((getPlayerUID _x)==_uid) then {_doit=false;};
		
		} forEach playableUnits;
		
		if _doit then {_container setVariable ["nowOpenedBy", "none", true];};
		
		true;
	};
	
	_container setVariable ["nowOpenedBy", getPlayerUID player, true];
};
publicVariable "fnc_inventoryOpenedScript";
fnc_inventoryClosedScript = {
	params ["_unit","_container","_secondaryContainer"];
	
	_container setVariable ["nowOpenedBy", "none", true];
};
publicVariable "fnc_inventoryClosedScript";
fnc_revealLocation_remote_2 = {
	private ["_location","_text"];
	
	_location = _this select 0;
	_text = _this select 1;
	systemChat format ["%1 %2", _text, text _location];
	
};
publicVariable "fnc_revealLocation_remote_2";
fnc_revealLocation_remote = {
	private ["_code","_args","_result","_location","_text"];
	
	_location = _this select 0;
	_text = _this select 1;
	
	[_location, _text] remoteExec ["fnc_revealLocation_remote_2"];
};
publicVariable "fnc_revealLocation_remote";
fnc_eachFrameTags = {
	private ["_hud","_tag","_pos","_sPos","_text_size","_tags","_units","_todel","_nearUnits"];
	
	_tags = tags_array select 0;
	_units = tags_array select 1;
	_todel = [];
	
	{
	
		if (((_x distance player)>tag_distance) or ((vehicle _x)!=_x)) then {
		
			_todel pushBack _forEachIndex;
		
		};
	
	} forEach _units;
	
	reverse _todel;
	
	{
	
		//systemChat str ((_tags select _x) select 0);
		//systemChat str ((_tags select _x) select 1);
		ctrlDelete ((_tags select _x) select 0);
		free_tags pushBack ((_tags select _x) select 1);
		_tags deleteAt _x;
		_units deleteAt _x;
	
	} forEach _todel;
	/*if (visibleMap OR {!alive player} OR {dialog}) exitWith {
		500 cutText["","PLAIN"];
	};*/
	
	_nearUnits = nearestObjects[(visiblePosition player),["Man"],tag_distance] - [player];
	
	_hud = uiNamespace getVariable ["disp_notifications", findDisplay 46];
	
	{
	
		if (isPlayer _x) then  {
	
		private ["_show"];
	
		_show = true;
	
		if (lineIntersects [eyePos player, eyePos _x, player, _x]) then {
		
			_show = false;
		
		};
		
		if !(alive _x) then {
		
			_show = false;
		
		};
		
		if !(isPlayer _x) then {
		
			_show = false;
		
		};
		
		if (visibleMap) then {
		
			_show = false;
		
		};
		
		if !(_x in _units) then {
			
			_tag = _hud ctrlCreate ["RscStructuredText", 78000+ (free_tags select 0)];
			_tags pushBack [_tag,78000+ (free_tags select 0)];
			_units pushBack _x;
			
			free_tags deleteAt 0;
			
			_pos = [(visiblePosition _x) select 0, (visiblePosition _x) select 1, ((_x modelToWorld (_x selectionPosition "head")) select 2) + 0.8];
			_sPos = worldToScreen _pos;
			if (count _sPos > 0) then {
				_text_size = ((5 / (_x distance player)) max 0.5) min 1;
				_tag ctrlSetStructuredText parseText format["<t align='center' font='RobotoCondensed'><t color='#00fffc' size='%3'>%1<br/></t><t font='TahomaB' color='#ffd100' size='%4'>%2</t></t><br/><t align='center'>[%5]</t>","",[_x,false,1] call fnc_getRealName,(_text_size - (_text_size*0.25)),_text_size*1.25,_x getVariable ["role_id",1398]];
				_tag ctrlSetPosition [(_sPos select 0) - 0.2, _sPos select 1, 0.4, 0.2];
				_tag ctrlSetScale 1;
				_tag ctrlSetFade 0;
				_tag ctrlCommit 0;
				if _show then {_tag ctrlShow true;} else {_tag ctrlShow false;};
			};
		
		} else {
		
			_tag = (_tags select (_units find _x)) select 0;
			
			_pos = [(visiblePosition _x) select 0, (visiblePosition _x) select 1, ((_x modelToWorld (_x selectionPosition "head")) select 2) + 0.8];
			_sPos = worldToScreen _pos;
			if (count _sPos > 0) then {
				_text_size = ((5 / (_x distance player)) max 0.5) min 1;
				_tag ctrlSetStructuredText parseText format["<t align='center' font='RobotoCondensed'><t color='#00fffc' size='%3'>%1<br/></t><t font='TahomaB' color='#ffd100' size='%4'>%2</t></t><br/><t align='center'>[%5]</t>","",[_x,false,1] call fnc_getRealName,(_text_size - (_text_size*0.25)),_text_size*1.25,_x getVariable ["role_id",1398]];
				_tag ctrlSetPosition [(_sPos select 0) - 0.2, _sPos select 1, 0.4, 0.2];
				_tag ctrlSetScale 1;
				_tag ctrlSetFade 0;
				_tag ctrlCommit 0;
				if _show then {_tag ctrlShow true;} else {_tag ctrlShow false;};
			};
		
		};
		
		
		
		
		if ((goggles _x) in masks_array) then {
		
			_tag ctrlSetStructuredText parseText format["<t align='center' font='RobotoCondensed'><t color='#00fffc' size='%3'>%1<br/></t><t font='TahomaB' color='#ffd100' size='%4'>%2</t></t>","","НЕИЗВЕСТНЫЙ",(_text_size - (_text_size*0.25)),_text_size*1.25];
		
		};
		
		};
		
	
	} forEach _nearUnits;
	
	/*private _ui = GVAR_UINS ["Life_HUD_nameTags",displayNull];
	if (isNull _ui) then {
		500 cutRsc["Life_HUD_nameTags","PLAIN"];
		_ui = GVAR_UINS ["Life_HUD_nameTags",displayNull];
	};
	private _units = nearestObjects[(visiblePosition player),["Man"],50] - [player];
	private _index = -1;
	private ["_idc","_sPos","_indexInIds","_text_size","_pos"];
	{
		_idc = _ui displayCtrl (iconID + _forEachIndex);
		if (!(lineIntersects [eyePos player, eyePos _x, player, _x]) && {GVAR_RNAME(_x) != ""}) then {
			if (NOTINVEH(_x)) then {
				_pos = [visiblePosition _x select 0, visiblePosition _x select 1, ((_x modelToWorld (_x selectionPosition "head")) select 2) + 0.8];
				_sPos = worldToScreen _pos;
				if ((_x distance player) < 15 && {count _sPos > 0}) then {
					_indexInIds = [(getPlayerUID _x),life_ids] call UnionClient_system_index;
					if (_x in (units grpPlayer) OR !(EQUAL(_indexInIds,-1))) then {
						_text_size = ((0.8 / (_x distance player) * 10) max 0.7) min 1;
						if (!isNil {(group _x) GVAR "gang_name"}) then {
							_idc ctrlSetStructuredText parseText format["<t align='center' font='RobotoCondensed'><t color='#ffffff' size='%4'>%1</t><t color='#ffd100' size='%5'><br/>%2</t><t color='#e9e9e9' size='%6'><br/>%3</t></t>",GVAR_RTITLE(_x),GVAR_RNAME(_x),(group _x) GVAR ["gang_name",""],(_text_size - (_text_size*0.25)),_text_size, (_text_size - (_text_size*0.3))];
						} else {
							_idc ctrlSetStructuredText parseText format["<t align='center' font='RobotoCondensed'><t color='#00fffc' size='%3'>%1<br/></t><t color='#ffd100' size='%4'>%2</t></t>",GVAR_RTITLE(_x),GVAR_RNAME(_x),(_text_size - (_text_size*0.25)),_text_size];
						};
						_idc ctrlSetPosition [(_sPos select 0) - 0.2, _sPos select 1];
						_idc ctrlSetScale 1;
						_idc ctrlSetFade 0;
						_idc ctrlCommit 0;
						_idc ctrlShow true;
					} else {_idc ctrlShow false};
				} else {_idc ctrlShow false};
			} else {_idc ctrlShow false};
		} else {_idc ctrlShow false};
		_index = _forEachIndex;
	} foreach _units;
	(_ui displayCtrl (iconID + _index + 1)) ctrlSetStructuredText parseText "";*/
};
publicVariable "fnc_eachFrameTags";
fnc_logMyStuff = {
	diag_log _this;
};
publicVariable "fnc_logMyStuff";
fnc_plantCarBomb_remote_explode_mepls = {
	private ["_ac"];
	
	_ac = ctrlText 1400;
	
	closeDialog 0;
	
	//systemChat str _ac;
	
	{
		
		private ["_veh"];
	
		_veh = call compile _x;
		
		//systemChat format ["%1 %2 %3",_veh,_veh getVariable ["activation_code","none"], _x];
	
		if ((_veh getVariable ["activation_code","none"])==_ac) then {
		
			private ["_bomb","_jammers","_jammed"];
			
			if !(alive _veh) exitWith {};
			if ((_veh getVariable ["carbomb","none"])=="none") exitWith {};
					
			_jammers = nearestObjects [_veh, ["Land_SatellitePhone_F"], 50];
			_jammed = false;
			if (count _jammers > 0) then {
			
				{
				
					if ((_x getVariable ["jamming",0])==1) then {_jammed = true;};
				
				} forEach _jammers;
			
			};
			
			if _jammed exitWith {["Автобомба","Сигнал не прошёл.",[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;};
				
			_bomb = "SatchelCharge_Remote_Ammo" createVehicle (getPosATL _veh);
			
			_bomb setDamage 1;
			
			_veh setDamage 1;
			
			["Автобомба","Подрыв совершён.",[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;
		
		};
	
	} forEach servervehiclesarray;
	
	{
		
		private ["_veh"];
	
		_veh = _x;
		
		//systemChat format ["%1 %2 %3",_veh,_veh getVariable ["activation_code","none"], _x];
	
		if (((remotebombsdata select _forEachIndex) select 0)==_ac) then {
		
			private ["_bomb","_jammers","_jammed"];
			
			if !(alive _veh) exitWith {};
					
			_jammers = nearestObjects [_veh, ["Land_SatellitePhone_F"], 50];
			_jammed = false;
			if (count _jammers > 0) then {
			
				{
				
					if ((_x getVariable ["jamming",0])==1) then {_jammed = true;};
				
				} forEach _jammers;
			
			};
			
			if _jammed exitWith {["Взрывпакет","Сигнал не прошёл.",[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;};
				
			//_bomb = "SatchelCharge_Remote_Ammo" createVehicle (getPosATL _veh);
			
			//_bomb setDamage 1;
			
			_veh setDamage 1;
			
			["Взрывпакет","Подрыв совершён.",[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;
		
		};
	
	} forEach remotebombsarray;
	
};
publicVariable "fnc_plantCarBomb_remote_explode_mepls";
fnc_plantCarBomb_remote_explode_menu = {
	if ("gun_cd" in (cooldown_array select 0)) exitWith {
		hint format ["Вы не можете использовать оружие ещё %1 минут!",((cooldown_array select 1) select ((cooldown_array select 0) find "gun_cd"))];
	};
	
	if (roleplay_pts<0) exitWith {
		hint "Вы не можете применять оружие, RPP меньше нуля!";
	};
	
	createDialog "carbomb_remote_pult";
	
};
publicVariable "fnc_plantCarBomb_remote_explode_menu";
fnc_plantCarBomb_remote = {
	if ("gun_cd" in (cooldown_array select 0)) exitWith {
		hint format ["Вы не можете использовать оружие ещё %1 минут!",((cooldown_array select 1) select ((cooldown_array select 0) find "gun_cd"))];
	};
	
	if (roleplay_pts<0) exitWith {
		hint "Вы не можете применять оружие, RPP меньше нуля!";
	};
	
	private ["_code","_vehicle","_speed","_message","_display","_checkbox"];
	
	if (("carbomb_remote" call fnc_getItemAmount)<1) exitWith {["Установка бомбы","Взрывчатки нет...",[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;};
			
	_vehicle = nearestObjects [player, ["LandVehicle"], 5];
	if (count _vehicle == 0) exitWith {["Установка бомбы","Подойдите ближе к транспортному средству.",[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;};
	if ((vehicle player)!=player) then {
		_vehicle = vehicle player;
	} else {
		_vehicle = _vehicle select 0;
	};
	
	if ((_vehicle getVariable ["carbomb","none"])!="none") exitWith {["Установка бомбы","В машину уже установлена бомба.",[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;};
	
	if (player==(vehicle player)) then {
		player playmove "AinvPknlMstpSlayWrflDnon_medic";
	};
	
	sleep 7;
	
	if ((_vehicle distance player) > 5) exitWith {["Установка бомбы","Машина слишком далеко.",[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;};
	
	if (("carbomb_remote" call fnc_getItemAmount)<1) exitWith {["Установка бомбы","Взрывчатки нет...",[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;};
	
	["carbomb_remote",1] call fnc_removeItem;
	
	["Установка бомбы","Бомба установлена, запомните код активации.",[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;
	
	_vehicle setVariable ["carbomb","remote",true];
	
	_vehicle setVariable ["spottedcarbomb", [getPlayerUID player], true];
	_vehicle setVariable ["engskill", engskill, true];
	
	[_vehicle] remoteExec ["fnc_carbomb_monitor",2];
	
	private ["_ac"];
	
	_ac = format ["%1%2", parseNumber (str player), round time];
	
	_vehicle setVariable ["activation_code", _ac, true];
	
	systemChat format ["Код активации - %1. Запомните его!", _ac];
	
};
publicVariable "fnc_plantCarBomb_remote";
fnc_plantCarBomb_speed_menu = {
	if ("gun_cd" in (cooldown_array select 0)) exitWith {
		hint format ["Вы не можете использовать оружие ещё %1 минут!",((cooldown_array select 1) select ((cooldown_array select 0) find "gun_cd"))];
	};
	
	if (roleplay_pts<0) exitWith {
		hint "Вы не можете применять оружие, RPP меньше нуля!";
	};
	createDialog "carbomb_speed_dialog";
	
	sliderSetRange [1900, 1, 200];
		
	sliderSetSpeed [1900, 1, 5];
	
	sliderSetPosition [1900, 50];
	ctrlSetText [1400, format ["Вам привет от %1!", [player, true] call fnc_getRealName]];
	
};
publicVariable "fnc_plantCarBomb_speed_menu";
fnc_plantCarBomb_speed_menu_slider = {
	private ["_slider","_value"];
	
	_slider = _this select 0;
	_value = round (_this select 1);
	
	ctrlSetText [1000, format ["Скорость активации: %1 км/ч",_value]];
};
publicVariable "fnc_plantCarBomb_speed_menu_slider";
fnc_plantCarBomb_speed_remote_2 = {
	if (player in (crew (_this select 0))) then {
		hint (_this select 1);
		systemChat (_this select 1);
	};
	
};
publicVariable "fnc_plantCarBomb_speed_remote_2";
fnc_carbomb_monitor = {
	private ["_veh","_text","_speed","_code2"];
	
	_veh = _this select 0;
	
	waitUntil {(!(alive _veh)) or ((_veh getVariable ["carbomb","none"])=="none")};
	
	if ((_veh getVariable ["carbomb","none"])=="none") exitWith {};
	
	private ["_bomb"];
				
	_bomb = "SatchelCharge_Remote_Ammo" createVehicle (getPosATL _veh);
			
	_bomb setDamage 1;
	
	//_veh setDamage 1;
	
};
publicVariable "fnc_carbomb_monitor";
fnc_plantCarBomb_speed_remote = {
	private ["_veh","_text","_speed","_code2"];
	
	_veh = _this select 0;
	_text = _this select 1;
	_speed = _this select 2;
	
	waitUntil {((speed _veh)>=_speed) or ((_veh getVariable ["carbomb","none"])=="none")};
	
	if ((_veh getVariable ["carbomb","none"])=="none") exitWith {};
	
	if (count (toArray _text) > 0) then {
	
		[_veh,_text] remoteExec ["fnc_plantCarBomb_speed_remote_2"];
	
	};
	
	waitUntil {((speed _veh)<_speed) or ((_veh getVariable ["carbomb","none"])=="none")};
	
	if ((_veh getVariable ["carbomb","none"])=="none") exitWith {};
	
	private ["_bomb"];
				
	_bomb = "SatchelCharge_Remote_Ammo" createVehicle (getPosATL _veh);
			
	_bomb setDamage 1;
	
	_veh setDamage 1;
	
};
publicVariable "fnc_plantCarBomb_speed_remote";
fnc_plantCarBomb_speed = {
	
	private ["_code","_vehicle","_speed","_message","_display","_checkbox"];
	
	if (("carbomb_speed" call fnc_getItemAmount)<1) exitWith {["Установка бомбы","Взрывчатки нет...",[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;};
			
	_vehicle = nearestObjects [player, ["LandVehicle"], 5];
	if (count _vehicle == 0) exitWith {["Установка бомбы","Подойдите ближе к транспортному средству.",[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;};
	if ((vehicle player)!=player) then {
		_vehicle = vehicle player;
	} else {
		_vehicle = _vehicle select 0;
	};
	
	if ((_vehicle getVariable ["carbomb","none"])!="none") exitWith {["Установка бомбы","В машину уже установлена бомба.",[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;};
	
	_display = findDisplay 500191;
	_checkbox = _display displayCtrl 2800;
	_message = "";
	
	if (cbChecked _checkbox) then {
	
		_message = ctrlText 1400;
	
	};
	_speed = round (sliderPosition 1900);
	
	closeDialog 0;
		
	if (player==(vehicle player)) then {
		player playmove "AinvPknlMstpSlayWrflDnon_medic";
	};
	
	sleep 7;
	
	if ((_vehicle distance player) > 5) exitWith {["Установка бомбы","Машина слишком далеко.",[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;};
	
	if (("carbomb_speed" call fnc_getItemAmount)<1) exitWith {["Установка бомбы","Взрывчатки нет...",[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;};
	
	["carbomb_speed",1] call fnc_removeItem;
	
	["Установка бомбы","Бомба установлена.",[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;
	
	_vehicle setVariable ["spottedcarbomb", [getPlayerUID player], true];
	_vehicle setVariable ["engskill", engskill, true];
	
	[_vehicle, _message, _speed] remoteExec ["fnc_plantCarBomb_speed_remote",2];
	
	[_vehicle] remoteExec ["fnc_carbomb_monitor",2];
	
	_vehicle setVariable ["carbomb","speed",true];
	
	
};
publicVariable "fnc_plantCarBomb_speed";
fnc_useGazan = {
	
	private ["_vehicle","_carbomb","_gearexplisoves","_trunkexplosives","_virtexplosives","_fulltext"];
			
	_vehicle = nearestObjects [player, ["LandVehicle"], 5];
	if (count _vehicle == 0) exitWith {["Газоанализатор","Подойдите ближе к машине.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	if ((vehicle player)!=player) then {
		_vehicle = vehicle player;
	} else {
		_vehicle = _vehicle select 0;
	};
	
	_virtexplosives = ["powder","carbomb_speed","carbomb_remote"];	
	_gearexplisoves = (getMagazineCargo _vehicle) select 0;
	_trunkexplosives = [];
	_carbomb = _vehicle getVariable ["carbomb","none"];
	
	{
	
		if (_x in _virtexplosives) then {_trunkexplosives pushBack _x;};
	
	} forEach (_vehicle getVariable ["trunkitems",[]]);
	
	_fulltext = "";
	
	if (_carbomb!="none") then {
	
		private ["_player_role"];
		
		_player_role = switch true do {
		
			case ((str player) in cop_array): {"police"};
			default {getPlayerUID player};
		
		};
		
		_fulltext = _fulltext + "В машине установлена бомба!!!";
		_vehicle setVariable ["spottedcarbomb", (_vehicle getVariable ["spottedcarbomb",[]])+[_player_role], true];
	
	};
	
	if ((count (_gearexplisoves+_trunkexplosives)) > 0) then {
		
		if (count (toArray _fulltext) > 0) then {
		
			_fulltext = _fulltext + " ";
		
		};
		_fulltext = _fulltext + "В багажнике обнаружена взрывчатка либо боеприпасы.";
	
	};
	
	if (count (toArray _fulltext) < 1) then {
	
		_fulltext = "Всё чисто.";
	
	};
	
	["Газоанализатор",_fulltext,[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
};
publicVariable "fnc_useGazan";
fnc_examineCarbomb = {
	private ["_vehicle","_type","_slozh","_chance"];
	
	_vehicle = cursorTarget;
	
	if ((vehicle player)!=player) then {_vehicle = vehicle player;};
	
	_type = _vehicle getVariable ["carbomb","none"];
	_slozh = _vehicle getVariable ["engskill",1488];
	if (_slozh>0) then {
		_chance = engskill/_slozh;
	} else {
		_chance = 1;
	};
	if (_chance>1) then {_chance=1};
	_chance = round (_chance*100);
	
	if (_type == "none") exitWith {hint "Ошибка типа бомбы.";};
	
	_type = switch _type do {
	
		case "speed": {"скоростная"};
		case "remote": {"радиоуправляемая"};	
	};
	
	if (player==(vehicle player)) then {
		player playmove "AinvPknlMstpSlayWrflDnon_medic";
	};
	
	sleep 6;
	
	if (_vehicle distance player > 7) exitWith {["Обезвреживание бомбы","Машина слишком далеко.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	
	["Обезвреживание бомбы",format ["Тип бомбы - %1. Сложность - %2%3. С учётом вашего инженерного навыка вероятность успешного разминирования - %4%3.",_type,_slozh,"%",_chance],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
};
publicVariable "fnc_examineCarbomb";
fnc_defuseCarbomb = {
	private ["_vehicle","_type","_slozh","_chance"];
	
	_vehicle = cursorTarget;
	
	//if ("pliers" call fnc_getItemAmount)
	
	if ((vehicle player)!=player) then {_vehicle = vehicle player;};
	
	if !(alive _vehicle) exitWith {hint "Ошибка.";};
	
	_type = _vehicle getVariable ["carbomb","none"];
	_slozh = _vehicle getVariable ["engskill",1488];
	if (_slozh>0) then {
		_chance = engskill/_slozh;
	} else {
		_chance = 1;
	};
	if (_chance>1) then {_chance=1};
	//if ((_chance>0.5) and (("pliers" call fnc_getItemAmount)<1)) then {_chance = 0.5 + ((_chance-0.5)/2);};
	
	if (player==(vehicle player)) then {
		player playmove "AinvPknlMstpSlayWrflDnon_medic";
	};
	
	sleep 6;
	
	if (_vehicle distance player > 5) exitWith {["Обезвреживание бомбы","Машина слишком далеко.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	if !(alive player) exitWith {};
	
	if ((random 1)>_chance) exitWith {
		
		_vehicle setDamage 1;
		["Обезвреживание бомбы","Неудача!",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	
	};
	
	switch _type do {
	
		case "remote": {["carbomb_remote",1] call fnc_addItem;};
		case "speed": {["carbomb_speed",1] call fnc_addItem;};
	
	};
	
	_vehicle setVariable ["carbomb","none",true];
	_vehicle setVariable ["spottedcarbomb",[],true];
	_vehicle setVariable ["engskill",0,true];
	
	["Обезвреживание бомбы","Вы успешно разминировали автомобиль.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
};
publicVariable "fnc_defuseCarbomb";
fnc_plantEWDevice = {
	private ["_jammer"];
	
	if (("glushilka" call fnc_getItemAmount) < 1) exitWith {};
	
	["glushilka",1] call fnc_removeItem;
		
	_jammer = createVehicle ["Land_SatellitePhone_F", getPosATL player, [], 1, "CAN_COLLIDE"];
	_jammer setVariable ["jamming",1,true];
	["Глушилка","Постановщик помех активирован.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	
};
publicVariable "fnc_plantEWDevice";
fnc_takeJammer = {
	private ["_jammer"];
	
	deleteVehicle cursorTarget;
	["glushilka",1] call fnc_addItem;
	["Глушилка","Постановщик помех убран.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	
};
publicVariable "fnc_takeJammer";
fnc_satchelcharge_monitor = {
	private ["_veh","_text","_speed","_code2"];
	
	_veh = _this select 0;
	
	waitUntil {!(alive _veh)};
	
	if ((_veh getVariable ["carbomb","none"])=="none") exitWith {};
	
	private ["_bomb"];
				
	_bomb = "SatchelCharge_Remote_Ammo" createVehicle (getPosATL _veh);
			
	_bomb setDamage 1;
	
	//_veh setDamage 1;
	
};
publicVariable "fnc_satchelcharge_monitor";
fnc_plantSatchelcharge = {
	if ("gun_cd" in (cooldown_array select 0)) exitWith {
		hint format ["Вы не можете использовать оружие ещё %1 минут!",((cooldown_array select 1) select ((cooldown_array select 0) find "gun_cd"))];
	};
	
	if (roleplay_pts<0) exitWith {
		hint "Вы не можете применять оружие, RPP меньше нуля!";
	};
	private ["_charge","_code","_ac"];
	if (("satchelcharge" call fnc_getItemAmount) < 1) exitWith {};
	
	_charge = "SatchelCharge_Remote_Ammo" createVehicle (getPosATL player);
	_charge setPos (getPosATL player);
	_ac = format ["%1%2", parseNumber (str player), round time];
	["satchelcharge",1] call fnc_removeItem;
	
	remotebombsarray pushBack _charge;
	publicVariable "remotebombsarray";
	
	remotebombsdata pushBack [_ac,50];
	publicVariable "remotebombsdata";
	
	//_charge setVariable ["engskill", 50, true];
		
	//_charge setVariable ["activation_code", _ac, true];
	//[_charge] remoteExec ["fnc_satchelcharge_monitor",2];
	
	systemChat format ["Код активации - %1. Запомните его!", _ac];
	
};
publicVariable "fnc_plantSatchelcharge";
fnc_examineSatchelcharge = {
	private ["_vehicle","_type","_slozh","_chance"];
	
	_vehicle = cursorObject;
	
	if ((vehicle player)!=player) exitWith {hint "Ошибка vehicle player";};
	
	_slozh = 50;
	if (_slozh>0) then {
		_chance = engskill/_slozh;
	} else {
		_chance = 1;
	};
	if (_chance>1) then {_chance=1};
	_chance = round (_chance*100);
	
	if (player==(vehicle player)) then {
		player playmove "AinvPknlMstpSlayWrflDnon_medic";
	};
	
	sleep 6;
	
	if (_vehicle distance player > 7) exitWith {["Обезвреживание бомбы","Бомба слишком далеко.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	
	["Обезвреживание бомбы",format ["Сложность - %2%3. С учётом вашего инженерного навыка вероятность успешного разминирования - %4%3.",1,_slozh,"%",_chance],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
};
publicVariable "fnc_examineSatchelcharge";
fnc_defuseSatchelcharge = {
	private ["_vehicle","_type","_slozh","_chance"];
	
	_vehicle = cursorObject;
	
	if ((vehicle player)!=player) exitWith {hint "Ошибка vehicle player";};
	
	if !(alive _vehicle) exitWith {hint "Ошибка.";};
	
	_slozh = (remotebombsdata select (remotebombsarray find _vehicle)) select 1;
	if (_slozh>0) then {
		_chance = engskill/_slozh;
	} else {
		_chance = 1;
	};
	if (_chance>1) then {_chance=1};
	//if ((_chance>0.5) and (("pliers" call fnc_getItemAmount)<1)) then {_chance = 0.5 + ((_chance-0.5)/2);};
	
	if (player==(vehicle player)) then {
		player playmove "AinvPknlMstpSlayWrflDnon_medic";
	};
	
	sleep 6;
	
	if (_vehicle distance player > 5) exitWith {["Обезвреживание бомбы","Бомба слишком далеко.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	if !(alive player) exitWith {};
	
	if ((random 1)>_chance) exitWith {
		
		_vehicle setDamage 1;
		["Обезвреживание бомбы","Неудача!",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	
	};
	
	["satchelcharge",1] call fnc_addItem;
	
	deleteVehicle _vehicle;
	
	["Обезвреживание бомбы","Вы успешно обезвредили бомбу.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
};
publicVariable "fnc_defuseSatchelcharge";
fnc_adminTeleport = {
	closeDialog 0;
	openMap true;
	
	onMapSingleClick "(vehicle player) setPos _pos; onMapSingleClick '';";
};
publicVariable "fnc_adminTeleport";
fnc_adminAddNalik = {
	private ["_amount"];
	_amount = parseNumber (ctrlText 1400);
	
	["money",_amount] call fnc_addItem;
	
};
publicVariable "fnc_adminAddNalik";
fnc_adminAddBank = {
	private ["_amount"];
	_amount = parseNumber (ctrlText 1400);
	
	deposit = deposit + _amount;
	
};
publicVariable "fnc_adminAddBank";
fnc_unflipVehicle = {
	//-- KiloSwiss 19:07 05/05/2018
	params [ ["_vehicle", objNull, [objNull]] ];
	if ( isNull _vehicle ) exitWith { false };
	/*
	//-- Not needed, since the argument(s) and effect(s) of the command "addForce" are global.
	//-- https://community.bistudio.com/wiki/addForce
	if !( local _vehicle ) exitWith
	{
		[_vehicle] remoteExec ["KS_fnc_unflipVehicle", [2, owner _vehicle] select isServer];
	};
	*/
	private ["_vectorDiff","_upsideDown","_vehicleBank","_turnLeft","_forceParams","_force","_addForcePointX","_addForcePointZ"];
	_vectorDiff = vectorUp _vehicle vectorDotProduct surfaceNormal getPos _vehicle;
	_upsideDown = _vectorDiff < -0.75; //_upsideDown = abs _vehicleBank > 135;
	_vehicleBank = _vehicle call BIS_fnc_getPitchBank select 1;
	_turnLeft = [false, true] select ( _vehicleBank >= 0 );
	//-- Reverse bool on _turnLeft if vehicle is upside down.
	if ( _upsideDown ) then
	{
		_turnLeft = [true, false] select _turnLeft;
	};
	//-- Get the correct multiplicator to calculate the correct force for different vehicles.
	_forceParams = [ [1.5, 5], [2.5, 6] ] select ( _vehicle isKindOf "MRAP_03_base_F" );	//-- Strider
	_forceParams = [ _forceParams, [1.2, 8] ] select ( _vehicle isKindOf "B_APC_Tracked_01_base_F" || { _vehicle isKindOf "MBT_01_base_F" } );	//-- Panther OR Slammer
	_force = getMass _vehicle * (_forceParams select _upsideDown);
	_addForcePointX = boundingBoxReal _vehicle select ([0, 1] select _turnLeft) select 0;
	_addForcePointZ = boundingBoxReal _vehicle select ([1, 0] select _upsideDown) select 2;
	//_addForcePointZ = [2, -4] select _upsideDown;
	_vehicle addForce [_vehicle vectorModelToWorld [[_force, - _force]select _turnLeft, 0, 0], [_addForcePointX, 0, _addForcePointZ]];
	true
};
publicVariable "fnc_unflipVehicle";
fnc_prayInTemple = {
	if ("pray_cd" in (cooldown_array select 0)) exitWith {["Молитва","Вы уже молились недавно.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
	
	["Молитва","Вы успешно совершили поход в храм и получили за это ролевые очки.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	
	switch religion do {
	
		case "orthodox": {
		
			//roleplay_pts = roleplay_pts + 100;
			100 call fnc_addRPP;
			(cooldown_array select 0) pushBack "pray_cd";
			(cooldown_array select 1) pushBack 30;
		
		};
	
		case "sunni": {
		
			//roleplay_pts = roleplay_pts + 300;
			300 call fnc_addRPP;
			(cooldown_array select 0) pushBack "pray_cd";
			(cooldown_array select 1) pushBack 15;
		
		};	
	
	
	};
};
publicVariable "fnc_prayInTemple";
fnc_wantedMarkerDecay = {
	private ["_marker","_i"];
	
	_marker = _this select 0;
	
	for "_i" from 0 to 30 do {
	
		_marker setMarkerAlpha ((30-_i)/30);
		
		sleep 10;
	
	};
	
	deleteMarker _marker;
	
};
publicVariable "fnc_wantedMarkerDecay";
fnc_offroadSpeedLimit = {
	private ["_vehicle","_limitSpeedMaxSpeed","_velocityVeh","_velocityVeh","_vehicleMass","_sarr","_limitSpeedMaxSpeedOffroad"];
	
	_vehicle = _this;
	_limitSpeedMaxSpeed = 1000;
	_limitSpeedMaxSpeedOffroad = 35;
	_sarr = ["#CRConcrete","#CRSterk","#CRTarmac"];
	
	if (offroad_veh_data_classes find (typeOf _vehicle) > -1) then {
		_limitSpeedMaxSpeedOffroad = (offroad_veh_data select (offroad_veh_data_classes find (typeOf _vehicle))) select 1;
	};
	
	while {alive _vehicle} do {
	
		/*if ((speed _vehicle > 20) and !(isTouchingGround _vehicle)) then {
			private _velocityVeh = velocity _vehicle;
			private _vehicleMass = getMass _vehicle;
			_velocityVeh = _velocityVeh apply {_x * -1};
			_vehicle addForce [ _velocityVeh, [0, 0, (boundingBoxReal _vehicle select 0 select 2) / 2 ] ];
		};*/
	
		if !(((surfaceType (getPos _vehicle)) in _sarr) or (isOnRoad _vehicle)) then {
			_limitSpeedMaxSpeed = _limitSpeedMaxSpeedOffroad;
	
			if ( speed _vehicle > _limitSpeedMaxSpeed && { isTouchingGround _vehicle } ) then
			{
				private _velocityVeh = velocity _vehicle;
				private _vehicleMass = getMass _vehicle;
				_velocityVeh = _velocityVeh apply {_x * -1};
				_vehicle addForce [ _velocityVeh, [0, 0, (boundingBoxReal _vehicle select 0 select 2) / 2 ] ];
			};
			
		} else {
			_limitSpeedMaxSpeed = 1000;
		};
	
	};
};
publicVariable "fnc_offroadSpeedLimit";
fnc_addRPP = {
	private ["_amount"];
	
	_amount = _this;
	
	if ("bp_nvg_cd" in (cooldown_array select 0)) then {
	
		roleplay_pts = roleplay_pts + (_amount/5);
	
	} else {
	
		roleplay_pts = roleplay_pts + _amount;
	
	};
};
publicVariable "fnc_addRPP";
fnc_removeRPP = {
	private ["_amount","_zero"];
	
	_amount = _this select 0;
	_zero = _this select 1;
	
	if ("bp_nvg_cd" in (cooldown_array select 0)) then {
	
		_amount = _amount*2;
	
	};
	
	if (_zero and ((roleplay_pts - _amount)<0)) then {
	
		roleplay_pts = 0;
	
	} else {
	
		roleplay_pts = roleplay_pts - _amount;
	};
};
publicVariable "fnc_removeRPP";
