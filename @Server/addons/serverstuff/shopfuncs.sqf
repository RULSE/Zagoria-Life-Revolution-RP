
fnc_switchToVirtItems = {
	curshoptype = "virtitems";
	private ["_display","_virtbutton","_wepsbutton","_gearbutton","_vehbutton","_shop","_classnames","_price","_maxstock","_stock","_items"];
	
	_display = findDisplay 502289;
	_virtbutton = _display displayCtrl 1603;
	_wepsbutton = _display displayCtrl 1604;
	_gearbutton = _display displayCtrl 1605;
	_vehbutton = _display displayCtrl 1606;
	_shop = global_shops_array_classes select curshop;
	
	_buylist = _display displayCtrl 1500;
	_selllist = _display displayCtrl 1501;
	lbClear _buylist;
	lbClear _selllist;
	if (count _this == 0) then {
		lbSetCurSel [1500,-1];
		lbSetCurSel [1501,-1];
	};
	
	{ctrlShow [_x, false];} forEach [2204,2205,1502,1402,1503,1403,1607,1608,1504,2106,2107];
	{ctrlShow [_x, true];} forEach [1400,2203,2200,2201,1601,1602,1401,1500,1501];
	
	_virtbutton ctrlEnable false;
	if (count newshop_wepsarray < 1) then {_wepsbutton ctrlEnable false;} else {_wepsbutton ctrlEnable true;};
	if (count (newshop_geararray_other+newshop_geararray_uniforms+newshop_geararray_vests+newshop_geararray_backpacks+newshop_geararray_headgear+newshop_geararray_goggles) < 1) then {_gearbutton ctrlEnable false;} else {_gearbutton ctrlEnable true;};
	if (count newshop_veharray < 1) then {_vehbutton ctrlEnable false;} else {_vehbutton ctrlEnable true;};
	
	{
	
		private ["_data"];
		
		_data = (shop_mierda_new select 0) select ((shop_mierda_new select 1) find _x);
	
		if ((_data select 3)==-1) then {
			_buylist lbAdd format ["%1", (_data select 0) call fnc_getItemName, (_data select 0) call fnc_getItemWeight, (_data select 1), ceil((_data select 2)*(1+nds_tax))];
			_buylist lbSetData [(lbSize _buylist)-1, (_data select 0)];
		};
		if ((_data select 3)==0) then {
			_buylist lbAdd format ["%1 [НЕ ПРОДАЁТСЯ]", (_data select 0) call fnc_getItemName, (_data select 0) call fnc_getItemWeight, (_data select 1), ceil((_data select 2)*(1+nds_tax))];
			_buylist lbSetData [(lbSize _buylist)-1, (_data select 0)];
		};
		if ((_data select 3)>0) then {
			_buylist lbAdd format ["%1 %3/%4 шт.", (_data select 0) call fnc_getItemName, (_data select 0) call fnc_getItemWeight, (_data select 1), (_data select 3), ceil(([_data select 1,_data select 3,_data select 2] call fnc_getItemStockPrice)*(1+nds_tax))];
			_buylist lbSetData [(lbSize _buylist)-1, (_data select 0)];
		};
	
	} forEach newshop_virtarray;
	if ((_shop call fnc_getShopBuyshit) == 1) then {
	
		_classnames = shop_mierda_new select 1;
		_items = shop_mierda_new select 0;
		{
			if (_x in _classnames) then {
				private ["_price","_stock","_maxstock"];
				_price = (_items select (_classnames find _x)) select 2;
				_maxstock = (_items select (_classnames find _x)) select 3;
				_stock = (_items select (_classnames find _x)) select 1;
				if (_maxstock==-1) then {
					_selllist lbAdd format ["%1 %2 кг %3 шт. %4 CRK", _x call fnc_getItemName, _x call fnc_getItemWeight, _x call fnc_getItemAmount, floor (_price/2)];
				} else {
					_selllist lbAdd format ["%1 %2 кг %3 шт. %4 CRK", _x call fnc_getItemName, _x call fnc_getItemWeight, _x call fnc_getItemAmount, floor (([_stock,_maxstock,_price] call fnc_getItemStockPrice)/2)];
				};
				_selllist lbSetData [(lbSize _selllist)-1,_x];
			};
		} foreach inventory_items;
		
		/*{
			if (((typeOf _x) in _classnames) and ((_x getVariable ["regplate","none"]) in vehicle_keys)) then {
				private ["_price","_stock","_maxstock"];
				_price = (_items select (_classnames find (typeOf _x))) select 2;
				_maxstock = (_items select (_classnames find (typeOf _x))) select 3;
				_stock = (_items select (_classnames find (typeOf _x))) select 1;
				if (_maxstock==-1) then {
					_selllist lbAdd format ["%1 %2 CRK", (typeOf _x) call fnc_getItemName, floor (_price/2)];
				} else {
					_selllist lbAdd format ["%1 %2 CRK", (typeOf _x) call fnc_getItemName, floor (([_stock,_maxstock,_price] call fnc_getItemStockPrice)/2)];
				};
				_selllist lbSetData [(lbSize _selllist)-1,_x getVariable ["regplate","error"]];
			};
		} foreach ((position _spawn) nearObjects ["AllVehicles", 50]);*/
	
	};
	
	ShopBoxRadius = 3;
	
	/*shopBoxVehicle = "b_survivor_F" createVehicleLocal ShopBoxVehiclePosition;
	ShopBoxVehicle setPosASL ShopBoxVehiclePosition;
	ShopBoxVehicle setDir (getDir player);
	ShopBoxVehicle enableSimulation false;
	ShopBoxVehicle switchMove "amovpercmstpsnonwnondnon";
	removeUniform ShopBoxVehicle;
	removeVest ShopBoxVehicle;
	removeBackpack ShopBoxVehicle;
	removeGoggles ShopBoxVehicle;
	removeHeadGear ShopBoxVehicle;
	ShopBoxVehicle forceAddUniform life_oldClothes;
	ShopBoxVehicle addBackpack life_oldBackpack;
	ShopBoxVehicle addVest life_oldVest;
	ShopBoxVehicle addGoggles life_oldGlasses;
	ShopBoxVehicle addHeadgear life_oldHat;
	ShopBoxRadius = 3;
	ShopBoxRadiusMax = 12;
	ShopBoxAngle = 0;
	ShopBoxAltitude = 302;
	ShopBoxSpeed = 0.01; 
	ShopBoxAngleStep = 5.5;
	ShopBoxRadStep = 0.5;
	ShopBoxAltitudeStep = 0.1;
	ShopBoxCameraCord = [ShopBoxVehicle,ShopBoxRadius,ShopBoxAngle] call BIS_fnc_relPos;
	ShopBoxCameraCord set [2, ShopBoxAltitude];
	ShopBoxCamera = "camera" camCreate ShopBoxCameraCord;
	ShopBoxCamera cameraEffect ["INTERNAL","BACK"];
	ShopBoxCamera camPrepareFOV 0.700;
	ShopBoxCamera camPrepareTarget ShopBoxVehicle;
	ShopBoxCameraCord = [ShopBoxVehicle,ShopBoxRadius,ShopBoxAngle] call BIS_fnc_relPos;
	ShopBoxCameraCord set [2, ShopBoxAltitude];
	ShopBoxCamera camPreparePos ShopBoxCameraCord;
	ShopBoxCamera camCommitPrepared ShopBoxSpeed;*/
};
publicVariable "fnc_switchToVirtItems";
fnc_switchToWeapons = {
	curshoptype = "weapons";
	private ["_display","_virtbutton","_wepsbutton","_gearbutton","_vehbutton"];
	
	_display = findDisplay 502289;
	_virtbutton = _display displayCtrl 1603;
	_wepsbutton = _display displayCtrl 1604;
	_gearbutton = _display displayCtrl 1605;
	_vehbutton = _display displayCtrl 1606;
	
	_buylist = _display displayCtrl 1500;
	lbClear _buylist;
	if (count _this == 0) then {
		lbSetCurSel [1500,-1];
		lbSetCurSel [1501,-1];
	};
	
	{ctrlShow [_x, false];} forEach [2203,1602,1401,1501,1504,2106,2107];
	{ctrlShow [_x, true];} forEach [1400,2200,2201,1601,1500,2204,2205,1502,1402,1608,1503,1403,1607];
	
	if (count newshop_virtarray < 1) then {_virtbutton ctrlEnable false;} else {_virtbutton ctrlEnable true;};
	_wepsbutton ctrlEnable false;
	if (count (newshop_geararray_other+newshop_geararray_uniforms+newshop_geararray_vests+newshop_geararray_backpacks+newshop_geararray_headgear+newshop_geararray_goggles) < 1) then {_gearbutton ctrlEnable false;} else {_gearbutton ctrlEnable true;};
	if (count newshop_veharray < 1) then {_vehbutton ctrlEnable false;} else {_vehbutton ctrlEnable true;};
	
	{
	
		private ["_data"];
		
		_data = (shop_mierda_new select 0) select ((shop_mierda_new select 1) find _x);
	
		if ((_data select 3)==-1) then {
			_buylist lbAdd format ["%1", (_data select 0) call fnc_getItemName, (_data select 0) call fnc_getItemWeight, (_data select 1), ceil((_data select 2)*(1+nds_tax))];
			_buylist lbSetData [(lbSize _buylist)-1, (_data select 0)];
		};
		if ((_data select 3)==0) then {
			_buylist lbAdd format ["%1 [НЕ ПРОДАЁТСЯ]", (_data select 0) call fnc_getItemName, (_data select 0) call fnc_getItemWeight, (_data select 1), ceil((_data select 2)*(1+nds_tax))];
			_buylist lbSetData [(lbSize _buylist)-1, (_data select 0)];
		};
		if ((_data select 3)>0) then {
			_buylist lbAdd format ["%1 %3/%4 шт.", (_data select 0) call fnc_getItemName, (_data select 0) call fnc_getItemWeight, (_data select 1), (_data select 3), ceil(([_data select 1,_data select 3,_data select 2] call fnc_getItemStockPrice)*(1+nds_tax))];
			_buylist lbSetData [(lbSize _buylist)-1, (_data select 0)];
		};
	
	} forEach newshop_wepsarray;
	
	ShopBoxRadius = 4;
};
publicVariable "fnc_switchToWeapons";
fnc_switchToGear = {
	curshoptype = "gear";
	private ["_display","_virtbutton","_wepsbutton","_gearbutton","_vehbutton","_gearcombo"];
	
	_display = findDisplay 502289;
	_virtbutton = _display displayCtrl 1603;
	_wepsbutton = _display displayCtrl 1604;
	_gearbutton = _display displayCtrl 1605;
	_vehbutton = _display displayCtrl 1606;
	_gearcombo = _display displayCtrl 2106;
	
	_buylist = _display displayCtrl 1500;
	_buylist_gear = _display displayCtrl 1504;
	lbClear _buylist;
	lbClear _buylist_gear;
	lbClear _gearcombo;
	if (count _this == 0) then {
		lbSetCurSel [1500,-1];
		lbSetCurSel [1501,-1];
		lbSetCurSel [1504,-1];
	};
	//lbSetCurSel [2106,-1];
	
	{ctrlShow [_x, false];} forEach [2204,2205,1502,1402,1503,1403,1607,1608,2203,1602,1401,1501,1500,2107];
	{ctrlShow [_x, true];} forEach [1400,2200,2201,1601,1504,2106];
	
	if (count newshop_virtarray < 1) then {_virtbutton ctrlEnable false;} else {_virtbutton ctrlEnable true;};
	if (count newshop_wepsarray < 1) then {_wepsbutton ctrlEnable false;} else {_wepsbutton ctrlEnable true;};
	_gearbutton ctrlEnable false;
	if (count newshop_veharray < 1) then {_vehbutton ctrlEnable false;} else {_vehbutton ctrlEnable true;};
	
	//(+++++)
	
	if (count newshop_geararray_uniforms > 0) then {_gearcombo lbAdd "Униформа"; _gearcombo lbSetData [(lbSize _gearcombo)-1, "uniform"]};
	if (count newshop_geararray_vests > 0) then {_gearcombo lbAdd "Бронежилеты, разгрузочные системы и пояса"; _gearcombo lbSetData [(lbSize _gearcombo)-1, "vests"]};
	if (count newshop_geararray_goggles > 0) then {_gearcombo lbAdd "Очки и маски"; _gearcombo lbSetData [(lbSize _gearcombo)-1, "goggles"]};
	if (count newshop_geararray_headgear > 0) then {_gearcombo lbAdd "Головные уборы и шлемы"; _gearcombo lbSetData [(lbSize _gearcombo)-1, "headgear"]};
	if (count newshop_geararray_backpacks > 0) then {_gearcombo lbAdd "Рюкзаки"; _gearcombo lbSetData [(lbSize _gearcombo)-1, "backpacks"]};
	if (count newshop_geararray_other > 0) then {_gearcombo lbAdd "Разное"; _gearcombo lbSetData [(lbSize _gearcombo)-1, "other"]};
	
	_gearcombo lbSetCurSel 0;
	
	ShopBoxRadius = 5;
};
publicVariable "fnc_switchToGear";
fnc_switchToGear_something = {
	private ["_display","_virtbutton","_wepsbutton","_gearbutton","_vehbutton","_gearcombo","_type","_list"];
	
	_type = _this select 0;
	
	//systemChat str _this;
	
	_display = findDisplay 502289;
	
	_buylist_gear = _display displayCtrl 1504;
	lbClear _buylist_gear;
	if (count _this == 1) then { 
		lbSetCurSel [1504,-1];
	};
	_list = [];
	
	switch _type do {	
		case "uniform": {_list=newshop_geararray_uniforms;};
		case "vests": {_list=newshop_geararray_vests;};
		case "goggles": {_list=newshop_geararray_goggles;};
		case "headgear": {_list=newshop_geararray_headgear;};
		case "backpacks": {_list=newshop_geararray_backpacks;};
		case "other": {_list=newshop_geararray_other;};	
	};
		
	{
	
		private ["_data"];
		
		_data = (shop_mierda_new select 0) select ((shop_mierda_new select 1) find _x);
	
		if ((_data select 3)==-1) then {
			_buylist_gear lbAdd format ["%1", (_data select 0) call fnc_getItemName, (_data select 0) call fnc_getItemWeight, (_data select 1), ceil((_data select 2)*(1+nds_tax))];
			_buylist_gear lbSetData [(lbSize _buylist_gear)-1, (_data select 0)];
		};
		if ((_data select 3)==0) then {
			_buylist_gear lbAdd format ["%1 [НЕ ПРОДАЁТСЯ]", (_data select 0) call fnc_getItemName, (_data select 0) call fnc_getItemWeight, (_data select 1), ceil((_data select 2)*(1+nds_tax))];
			_buylist_gear lbSetData [(lbSize _buylist_gear)-1, (_data select 0)];
		};
		if ((_data select 3)>0) then {
			_buylist_gear lbAdd format ["%1 %3/%4 шт.", (_data select 0) call fnc_getItemName, (_data select 0) call fnc_getItemWeight, (_data select 1), (_data select 3), ceil(([_data select 1,_data select 3,_data select 2] call fnc_getItemStockPrice)*(1+nds_tax))];
			_buylist_gear lbSetData [(lbSize _buylist_gear)-1, (_data select 0)];
		};
	
	} forEach _list;
	
}; 
publicVariable "fnc_switchToGear_something";
fnc_switchToVehs = {
	curshoptype = "vehicles";
	private ["_display","_virtbutton","_wepsbutton","_gearbutton","_vehbutton","_shop","_classnames","_price","_maxstock","_stock","_spawn","_items"];
	
	_display = findDisplay 502289;
	_virtbutton = _display displayCtrl 1603;
	_wepsbutton = _display displayCtrl 1604;
	_gearbutton = _display displayCtrl 1605;
	_vehbutton = _display displayCtrl 1606;
	_shop = global_shops_array_classes select curshop;
	_spawn = _shop call fnc_getShopSpawn;
	
	_buylist = _display displayCtrl 1504;
	_selllist = _display displayCtrl 1501;
	lbClear _buylist;
	lbClear _selllist;
	if (count _this == 0) then {
		lbSetCurSel [1504,-1];
		lbSetCurSel [1501,-1];
	};
	
	{ctrlShow [_x, false];} forEach [2204,2205,1502,1402,1503,1403,1607,1608,1500];
	{ctrlShow [_x, true];} forEach [1400,2203,2200,2201,1601,1602,1401,1504,2106,2107,1501];
	
	if (count newshop_virtarray < 1) then {_virtbutton ctrlEnable false;} else {_virtbutton ctrlEnable true;};
	if (count newshop_wepsarray < 1) then {_wepsbutton ctrlEnable false;} else {_wepsbutton ctrlEnable true;};
	if (count (newshop_geararray_other+newshop_geararray_uniforms+newshop_geararray_vests+newshop_geararray_backpacks+newshop_geararray_headgear+newshop_geararray_goggles) < 1) then {_gearbutton ctrlEnable false;} else {_gearbutton ctrlEnable true;};
	_vehbutton ctrlEnable false;
	
	{
	
		private ["_data"];
		
		_data = (shop_mierda_new select 0) select ((shop_mierda_new select 1) find _x);
	
		if ((_data select 3)==-1) then {
			_buylist lbAdd format ["%1", (_data select 0) call fnc_getItemName, (_data select 0) call fnc_getItemWeight, (_data select 1), ceil((_data select 2)*(1+nds_tax))];
			_buylist lbSetData [(lbSize _buylist)-1, (_data select 0)];
		};
		if ((_data select 3)==0) then {
			_buylist lbAdd format ["%1 [НЕ ПРОДАЁТСЯ]", (_data select 0) call fnc_getItemName, (_data select 0) call fnc_getItemWeight, (_data select 1), ceil((_data select 2)*(1+nds_tax))];
			_buylist lbSetData [(lbSize _buylist)-1, (_data select 0)];
		};
		if ((_data select 3)>0) then {
			_buylist lbAdd format ["%1 %3/%4 шт.", (_data select 0) call fnc_getItemName, (_data select 0) call fnc_getItemWeight, (_data select 1), (_data select 3), ceil(([_data select 1,_data select 3,_data select 2] call fnc_getItemStockPrice)*(1+nds_tax))];
			_buylist lbSetData [(lbSize _buylist)-1, (_data select 0)];
		};
	
	} forEach newshop_veharray;
	if ((_shop call fnc_getShopBuyshit) == 1) then {
		
		_classnames = shop_mierda_new select 1;
		_items = shop_mierda_new select 0;
		/*{
			if (_x in _classnames) then {
				private ["_price","_stock","_maxstock"];
				_price = (_items select (_classnames find _x)) select 2;
				_maxstock = (_items select (_classnames find _x)) select 3;
				_stock = (_items select (_classnames find _x)) select 1;
				if (_maxstock==-1) then {
					_selllist lbAdd format ["%1 %2 кг %3 шт. %4 CRK", _x call fnc_getItemName, _x call fnc_getItemWeight, _x call fnc_getItemAmount, floor (_price/2)];
				} else {
					_selllist lbAdd format ["%1 %2 кг %3 шт. %4 CRK", _x call fnc_getItemName, _x call fnc_getItemWeight, _x call fnc_getItemAmount, floor (([_stock,_maxstock,_price] call fnc_getItemStockPrice)/2)];
				};
				_selllist lbSetData [(lbSize _selllist)-1,_x];
			};
		} foreach inventory_items;*/
		
		{
			if (((typeOf _x) in _classnames) and ((_x getVariable ["regplate","none"]) in vehicle_keys)) then {
				private ["_price","_stock","_maxstock"];
				_price = (_items select (_classnames find (typeOf _x))) select 2;
				_maxstock = (_items select (_classnames find (typeOf _x))) select 3;
				_stock = (_items select (_classnames find (typeOf _x))) select 1;
				if (_maxstock==-1) then {
					_selllist lbAdd format ["%1 %2 CRK", (typeOf _x) call fnc_getItemName, floor (_price/2)];
				} else {
					_selllist lbAdd format ["%1 %2 CRK", (typeOf _x) call fnc_getItemName, floor (([_stock,_maxstock,_price] call fnc_getItemStockPrice)/2)];
				};
				_selllist lbSetData [(lbSize _selllist)-1,_x getVariable ["regplate","error"]];
			};
		} foreach ((position _spawn) nearObjects ["AllVehicles", 50]);
	
	};
	ShopBoxRadius = 10;
	
};
publicVariable "fnc_switchToVehs";
fnc_tovarDescription2 = {
	private ["_display","_description","_item","_itemdata","_tax","_a1","_a2","_paintjob","_mags_list","_accs_list"];
	
	disableSerialization;
		
	_item = _this select 0;
	_display = findDisplay 502289;
	_description = _display displayCtrl 1102;
	_description2 = _display displayCtrl 1103;
	_paintjob = _display displayCtrl 2107;
	
	_mags_list = _display displayCtrl 1502;
	_accs_list = _display displayCtrl 1503;
	
	
	if ((_this select 1)<0) exitWith {};
	//if ((_this select 1)<0) exitWith {_description ctrlShow false; _description2 ctrlShow false;};
		
	_itemdata = (shop_mierda_new select 0) select ((shop_mierda_new select 1) find _item);
	
	_description ctrlShow true; _description2 ctrlShow true;
	
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
};
publicVariable "fnc_tovarDescription2";
fnc_tovarDescription = {
	private ["_display","_description","_item","_itemdata","_tax","_a1","_a2","_paintjob","_mags_list","_accs_list"];
	
	disableSerialization;
		
	_item = _this select 0;
	_display = findDisplay 502289;
	_description = _display displayCtrl 1102;
	_description2 = _display displayCtrl 1103;
	_paintjob = _display displayCtrl 2107;
	
	_mags_list = _display displayCtrl 1502;
	_accs_list = _display displayCtrl 1503;
	
	
	if ((_this select 1)<0) exitWith {_description ctrlShow false; _description2 ctrlShow false;};
	
	if ((_item call fnc_getItemType)=="vehicle") then {
	
		lbClear _paintjob;
		lbSetCurSel [2107,-1];
		
		if ((vehicle_colors_classes find _item)<0) exitWith {};
		
		{
			
			if (call compile (_x select 3)) then {
			
				_paintjob lbAdd str (_x select 0);
				_paintjob lbSetData [(lbSize _paintjob)-1, str (_x select 1)];
				
			};
			
		} forEach ((vehicle_colors select (vehicle_colors_classes find _item)) select 1);
		
		lbSetCurSel [2107,0];
	
	};
	
	if (curshoptype=="weapons") then {
	
		private ["_info"];
		
		lbClear _mags_list;
		lbClear _accs_list;
		if (count _this == 2) then {
			_mags_list lbSetCurSel -1;
			_accs_list lbSetCurSel -1;
		};
		
		//[_item,_displayName,_picture,_desc,_category,_type,_weight,_magazines,_muzzles,_optics,_pointers,_bipods]
		
		_info = _item call fnc_getWeaponInfo;
		
		{	
		
			if (isClass (configFile >> "CfgWeapons" >> _item >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems")) then {
		
				if (isNumber (configFile >> "CfgWeapons" >> _item >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems" >> _x)) then {
				
					//_accs_list lbAdd format ["%1 %2/%3"];
					
					private ["_data"];
					
					_data = (shop_mierda_new select 0) select ((shop_mierda_new select 1) find _x);
				
					if ((_data select 3)==-1) then {
						_accs_list lbAdd format ["%1", (_data select 0) call fnc_getItemName, (_data select 0) call fnc_getItemWeight, (_data select 1), ceil((_data select 2)*(1+nds_tax))];
						_accs_list lbSetData [(lbSize _accs_list)-1, (_data select 0)];
					};
					if ((_data select 3)==0) then {
						_accs_list lbAdd format ["%1 [НЕ ПРОДАЁТСЯ]", (_data select 0) call fnc_getItemName, (_data select 0) call fnc_getItemWeight, (_data select 1), ceil((_data select 2)*(1+nds_tax))];
						_accs_list lbSetData [(lbSize _accs_list)-1, (_data select 0)];
					};
					if ((_data select 3)>0) then {
						_accs_list lbAdd format ["%1 %3/%4 шт.", (_data select 0) call fnc_getItemName, (_data select 0) call fnc_getItemWeight, (_data select 1), (_data select 3), ceil(([_data select 1,_data select 3,_data select 2] call fnc_getItemStockPrice)*(1+nds_tax))];
						_accs_list lbSetData [(lbSize _accs_list)-1, (_data select 0)];
					};
				
				};
			
			};
		
			//systemChat str (_info select 7);
			
			if (_x in (_info select 7)) then {
			
				//_accs_list lbAdd format ["%1 %2/%3"];
				
				private ["_data"];
				
				_data = (shop_mierda_new select 0) select ((shop_mierda_new select 1) find _x);
			
				if ((_data select 3)==-1) then {
					_mags_list lbAdd format ["%1", (_data select 0) call fnc_getItemName, (_data select 0) call fnc_getItemWeight, (_data select 1), ceil((_data select 2)*(1+nds_tax))];
					_mags_list lbSetData [(lbSize _mags_list)-1, (_data select 0)];
				};
				if ((_data select 3)==0) then {
					_mags_list lbAdd format ["%1 [НЕ ПРОДАЁТСЯ]", (_data select 0) call fnc_getItemName, (_data select 0) call fnc_getItemWeight, (_data select 1), ceil((_data select 2)*(1+nds_tax))];
					_mags_list lbSetData [(lbSize _mags_list)-1, (_data select 0)];
				};
				if ((_data select 3)>0) then {
					_mags_list lbAdd format ["%1 %3/%4 шт.", (_data select 0) call fnc_getItemName, (_data select 0) call fnc_getItemWeight, (_data select 1), (_data select 3), ceil(([_data select 1,_data select 3,_data select 2] call fnc_getItemStockPrice)*(1+nds_tax))];
					_mags_list lbSetData [(lbSize _mags_list)-1, (_data select 0)];
				};
			
			};
		
		} forEach (shop_mierda_new select 1);
		
	
	};	
	
	_itemdata = (shop_mierda_new select 0) select ((shop_mierda_new select 1) find _item);
	
	_description ctrlShow true; _description2 ctrlShow true;
	
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
	
	private ["_model"];
	
	switch curshoptype do {
	
		case "virtitems": {
	
			_model = (items_array select (items_classes find _item)) select 1;
				
			deleteVehicle ShopBoxVehicle;	
			
			ShopBoxVehicle = _model createVehicleLocal ShopBoxVehiclePosition;
			ShopBoxVehicle allowDamage false;
			ShopBoxVehicle enableSimulation false;
			ShopBoxVehicle setPosASL ShopBoxVehiclePosition;
			ShopBoxVehicle setDir (getDir player);
			
			ShopBoxRadius = 3;
		
		};
	
		case "vehicles": {
	
			_model = (items_array select (items_classes find _item)) select 1;
				
			deleteVehicle ShopBoxVehicle;	
			
			shopBoxVehicle = _model createVehicleLocal ShopBoxVehiclePosition;
			ShopBoxVehicle allowDamage false;
			ShopBoxVehicle enableSimulation false;
			ShopBoxVehicle setPosASL ShopBoxVehiclePosition;
			ShopBoxVehicle setDir (getDir player);
			
			ShopBoxRadius = 10;
		
		};
	
		case "weapons": {
	
			//_model = (items_array select (items_classes find _item)) select 1;
				
			//if !(ShopBoxVehicle isKindOf "WeaponHolderSimulated") then {
						
						
			//if (!isNull ShopBoxWeapHolder) then {deleteVehicle ShopBoxWeapHolder};
			//if (!isNull ShopBoxWeapTurnItem) then {deleteVehicle ShopBoxWeapTurnItem};
			
			/*if !(isNil "ShopBoxVehicle") then {deleteVehicle ShopBoxVehicle;};
			if !(isNil "ShopBoxWeapTurnItem") then {deleteVehicle ShopBoxWeapTurnItem;};
			ShopBoxWeapTurnItem = "Land_Can_V3_F" createVehicleLocal ShopBoxVehiclePosition;
			ShopBoxWeapTurnItem enableSimulation false;
			ShopBoxWeapTurnItem setPosATL ShopBoxVehiclePosition;
			//ShopBoxWeapTurnItem attachTo [ShopBoxTable, [0, 0, 0] ];
			ShopBoxWeapTurnItem hideObject true;
			detach ShopBoxWeapTurnItem;
			ShopBoxVehicle = "WeaponHolderSimulated" createVehicleLocal ShopBoxVehiclePosition;
			ShopBoxVehicle addWeaponCargo [_item,1];
			ShopBoxVehicle attachTo [ShopBoxWeapTurnItem, [0,-0.63,0.7]];
			ShopBoxVehicle setVectorDirAndUp [[0,0,1],[0,-1,0]];
			//life_weaponShopItemRotate = _item;
			private _dir = getDir ShopBoxWeapTurnItem;
			waitUntil {
				_dir = _dir + (
					if (_dir > 360) then [{-360},{0.5}]
				);
				//ShopBoxWeapTurnItem setDir _dir;
				isNull ShopBoxWeapTurnItem OR isNull ShopBoxVehicle
			};*/
			
			deleteVehicle ShopBoxVehicle;	
				
			/*if (isNil "ShopBoxWeapTurnItem") then {
				
				ShopBoxWeapTurnItem = "Land_Can_V3_F" createVehicle ShopBoxVehiclePosition;
				ShopBoxWeapTurnItem enableSimulation false;
				ShopBoxWeapTurnItem setPosATL ShopBoxVehiclePosition;
			
			};*/
			
			ShopBoxVehicle = "GroundWeaponHolder" createVehicleLocal ShopBoxVehiclePosition;
			ShopBoxVehicle addWeaponCargo [_item,1];
			ShopBoxVehicle allowDamage false;
			ShopBoxVehicle enableSimulation false;
			ShopBoxVehicle setPosASL ShopBoxVehiclePosition;
			ShopBoxVehicle setDir (getDir player);
			
			/*private _dir = getDir ShopBoxVehicle;
			waitUntil {
				_dir = _dir + (
					if (_dir > 360) then [{-360},{0.5}]
				);
				//ShopBoxWeapTurnItem setDir _dir;
				isNull ShopBoxVehicle
			};*/
			
			
			//} else {
			
				//clearWeaponCargo ShopBoxVehicle;
				//ShopBoxVehicle addWeaponCargo [_item,1];
			
			//};
			//ShopBoxVehicle attachTo [ShopBoxBackgroundObject, [0,0,1]];
			//ShopBoxVehicle setVectorDirAndUp [[0,0,1],[0,-1,0]];
			
			ShopBoxRadius = 3;
		
		};
	
		case "gear": {
	
			_model = (items_array select (items_classes find _item)) select 1;
				
			
			if (_model in newshop_geararray_other) then {
			
				_model = (items_array select (items_classes find _item)) select 1;
					
				deleteVehicle ShopBoxVehicle;	
				
				shopBoxVehicle = "GroundWeaponHolder" createVehicleLocal ShopBoxVehiclePosition;
				ShopBoxVehicle allowDamage false;
				ShopBoxVehicle enableSimulation false;
				ShopBoxVehicle setPosASL ShopBoxVehiclePosition;
				ShopBoxVehicle setDir (getDir player);
				ShopBoxVehicle addItemCargo [_model,1];
				
				ShopBoxRadius = 3;
			
			} else {
			
				ShopBoxRadius = 4;
				
				if !(ShopBoxVehicle isKindOf "b_survivor_F") then {
			
					deleteVehicle ShopBoxVehicle;	
			
					ShopBoxVehicle = "b_survivor_F" createVehicleLocal ShopBoxVehiclePosition;
					ShopBoxVehicle setPosASL ShopBoxVehiclePosition;
					ShopBoxVehicle setDir (getDir player);
					ShopBoxVehicle enableSimulation false;
					ShopBoxVehicle switchMove "amovpercmstpsnonwnondnon";
				
				} else {
				
					removeUniform ShopBoxVehicle;
					removeVest ShopBoxVehicle;
					removeBackpack ShopBoxVehicle;
					removeGoggles ShopBoxVehicle;
					removeHeadGear ShopBoxVehicle;
					
				};
				removeUniform ShopBoxVehicle;
				removeVest ShopBoxVehicle;
				removeBackpack ShopBoxVehicle;
				removeGoggles ShopBoxVehicle;
				removeHeadGear ShopBoxVehicle;
				
				switch true do {
				
					case (_model in newshop_geararray_backpacks): {ShopBoxVehicle addBackpack _model;};
					case (_model in newshop_geararray_goggles): {ShopBoxVehicle addGoggles _model;};
					case (_model in newshop_geararray_headgear): {ShopBoxVehicle addHeadgear _model;};
					case (_model in newshop_geararray_uniforms): {ShopBoxVehicle forceAddUniform _model;};
					case (_model in newshop_geararray_vests): {ShopBoxVehicle addVest _model;};
				
				};
			
			};
		
		};
	
	};
	
};
publicVariable "fnc_tovarDescription";
fnc_shopShowCarColor = {
	private ["_color"];
	
	_color = [];
	
	if ((lbCurSel 2107)<0) exitWith {
	
		_color = ((items_array select (items_classes find (typeOf ShopBoxVehicle))) select 6) select 0;
	//hint str _color;
		//systemChat str _tex;
		
		sleep 0.5;
			
		{
				
			ShopBoxVehicle setObjectTexture [_forEachIndex,_x];
				
		} forEach _color;
			
		/*_veh setVariable ["tuning_data",[_tex,0],true];*/
	
	};
	
	_color = call compile (lbData [2107, lbCurSel 2107]);
			
	sleep 0.5;
		
	{
				
		ShopBoxVehicle setObjectTexture [_forEachIndex,_x];
				
	} forEach _color;
	
	//hint str _color;
	
	
};
publicVariable "fnc_shopShowCarColor";
fnc_newBuyAcc = {
	if (antidupa and ((lastdupa+5)>time)) exitWith {hint "Неизвестная ошибка! Подождите 5 секунд!";};
	
	antidupa = true;
	lastdupa = time;
	
	disableSerialization;
	
	//private ["_lb","_classname","_display","_itemstobuy_ctrl","_itemstosell_ctrl","_buyamount_ctrl","_sellamount_ctrl","_type228","_price","_maxstock","_stock","_cost","_params","_tax","_tex","_noplace"];
	private ["_display","_amount","_list","_lb","_classname","_amount","_type228","_minimum","_stock","_maxstock","_price","_tax","_cost","_license","_box","_spawn","_noplace","_money"];
	
	_display = findDisplay 502289;
	
	_amount = _display displayCtrl 1403;
	_list = _display displayCtrl 1503;
	_lb = lbCurSel _list;
	
	if (_lb < 0) exitWith {antidupa = false;};
	
	_classname = _list lbData _lb;
	_lb = (shop_mierda_new select 1) find _classname;
	_amount = (parseNumber (ctrlText _amount));
	_type228 = _classname call fnc_getItemType;
	
	_minimum = 1;
	if ((_amount<_minimum) or ((_amount/_minimum)!=round(_amount/_minimum))) exitWith {systemChat "Допустимы только целые числа"; antidupa = false;};
	_stock = [_classname, global_shops_array_classes select curshop] call fnc_getShopStock;
	_maxstock = [_classname, global_shops_array_classes select curshop] call fnc_getShopMaxStock;
	
	if (_maxstock==0) exitWith {["Магазин","Этот товар не продаётся.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls; antidupa = false;};
		
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
		
	_license = ((((global_shops_array_items select curshop) select 0) select _lb) select 5);
	
	_box = (global_shops_array_classes select curshop) call fnc_getShopCrate;
	
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
		
		case "magazine": {
			_box addMagazineCargo [_classname, _amount];
		};
		case "gameitem": {
			_box addItemCargo [_classname, _amount];
		};
		
	};
	["Магазин",format ["Вы купили %1 %2 за %3 CRK.", _amount, _classname call fnc_getItemName, [_cost] call fnc_numberToText],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	
	(format ["[%1|%2|%7] has bought %3 %4 for %5 at %6", name player, getPlayerUID player, _amount, _classname, [_cost] call fnc_numberToText, curshop, side player]) remoteExec ["fnc_logMyStuff",2];
	
	antidupa = false;
	
	if (curshoptype=="gear") then {
	
		[(lbData [1504,lbCurSel 1504]),lbCurSel 1504,1] spawn fnc_tovarDescription;
	
	} else {
	
		[(lbData [1500,lbCurSel 1500]),lbCurSel 1500,1] spawn fnc_tovarDescription;
	};
	
	/*switch curshoptype do {
	
		case "virtitems": {[1] spawn fnc_switchToVirtItems};
		case "weapons": {[1] spawn fnc_switchToWeapons};
		case "gear": {[(lbData [2106, lbCurSel 2106]),1] spawn fnc_switchToGear_something;};
		case "vehicles": {[1] spawn fnc_switchToVehs};
	
	};*/
	
};
publicVariable "fnc_newBuyAcc";
fnc_newBuyMag = {
	if (antidupa and ((lastdupa+5)>time)) exitWith {hint "Неизвестная ошибка! Подождите 5 секунд!";};
	
	antidupa = true;
	lastdupa = time;
	
	disableSerialization;
	
	//private ["_lb","_classname","_display","_itemstobuy_ctrl","_itemstosell_ctrl","_buyamount_ctrl","_sellamount_ctrl","_type228","_price","_maxstock","_stock","_cost","_params","_tax","_tex","_noplace"];
	private ["_display","_amount","_list","_lb","_classname","_amount","_type228","_minimum","_stock","_maxstock","_price","_tax","_cost","_license","_box","_spawn","_noplace","_money"];
	
	_display = findDisplay 502289;
	
	_amount = _display displayCtrl 1402;
	_list = _display displayCtrl 1502;
	_lb = lbCurSel _list;
	
	if (_lb < 0) exitWith {antidupa = false;};
	
	_classname = _list lbData _lb;
	_lb = (shop_mierda_new select 1) find _classname;
	_amount = (parseNumber (ctrlText _amount));
	_type228 = _classname call fnc_getItemType;
	
	_minimum = 1;
	if ((_amount<_minimum) or ((_amount/_minimum)!=round(_amount/_minimum))) exitWith {systemChat "Допустимы только целые числа"; antidupa = false;};
	_stock = [_classname, global_shops_array_classes select curshop] call fnc_getShopStock;
	_maxstock = [_classname, global_shops_array_classes select curshop] call fnc_getShopMaxStock;
	
	if (_maxstock==0) exitWith {["Магазин","Этот товар не продаётся.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls; antidupa = false;};
		
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
		
	_license = ((((global_shops_array_items select curshop) select 0) select _lb) select 5);
	
	_box = (global_shops_array_classes select curshop) call fnc_getShopCrate;
	
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
		
		case "magazine": {
			_box addMagazineCargo [_classname, _amount];
		};
		case "gameitem": {
			_box addItemCargo [_classname, _amount];
		};
		
	};
	["Магазин",format ["Вы купили %1 %2 за %3 CRK.", _amount, _classname call fnc_getItemName, [_cost] call fnc_numberToText],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	
	(format ["[%1|%2|%7] has bought %3 %4 for %5 at %6", name player, getPlayerUID player, _amount, _classname, [_cost] call fnc_numberToText, curshop, side player]) remoteExec ["fnc_logMyStuff",2];
	
	antidupa = false;
	
	if (curshoptype=="gear") then {
	
		[(lbData [1504,lbCurSel 1504]),lbCurSel 1504,1] spawn fnc_tovarDescription;
	
	} else {
	
		[(lbData [1500,lbCurSel 1500]),lbCurSel 1500,1] spawn fnc_tovarDescription;
	};
	
	/*switch curshoptype do {
	
		case "virtitems": {[1] spawn fnc_switchToVirtItems};
		case "weapons": {[1] spawn fnc_switchToWeapons};
		case "gear": {[(lbData [2106, lbCurSel 2106]),1] spawn fnc_switchToGear_something;};
		case "vehicles": {[1] spawn fnc_switchToVehs};
	
	};*/
	
};
publicVariable "fnc_newBuyMag";
fnc_newBuyItem = {
	if (antidupa and ((lastdupa+5)>time)) exitWith {hint "Неизвестная ошибка! Подождите 5 секунд!";};
	
	antidupa = true;
	lastdupa = time;
	
	disableSerialization;
	
	//private ["_lb","_classname","_display","_itemstobuy_ctrl","_itemstosell_ctrl","_buyamount_ctrl","_sellamount_ctrl","_type228","_price","_maxstock","_stock","_cost","_params","_tax","_tex","_noplace"];
	private ["_display","_amount","_list","_lb","_classname","_amount","_type228","_minimum","_stock","_maxstock","_price","_tax","_cost","_license","_box","_spawn","_noplace","_money"];
	
	_display = findDisplay 502289;
	
	_amount = _display displayCtrl 1400;
	_list = _display displayCtrl 1500;
	
	if (curshoptype in ["gear","vehicles"]) then {
		_list = _display displayCtrl 1504;
	};
	_lb = lbCurSel _list;
	
	if (_lb < 0) exitWith {antidupa = false;};
	
	_classname = _list lbData _lb;
	_lb = (shop_mierda_new select 1) find _classname;
	_amount = (parseNumber (ctrlText _amount));
	//closeDialog 0;
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
			
			private ["_paintjob"];
			
			_paintjob = _display displayCtrl 2107;
	
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
			_tex = ((items_array select (items_classes find _classname)) select 6) select 0;
			//systemChat str _tex;
			
			
			_veh setVariable ["tuning_data",[_tex,0],true];
			_veh setVariable ["owner",getPlayerUID player,true];
			
			_veh remoteExec ["fnc_offroadSpeedLimit",2];
			
			if ((str player) in cop_array) then {
				_veh setVariable ["policevehicle",true,true];
			};
			
			
			if ((count _params) == 0) then {
			
				if (count (_tex select 0) > 0) then {
				
					/*if (((_tex select 0) select 0)!="none") then {
					
						_params = _tex select 0;
					
					};*/
				
				};
			
			};
			
			if (lbCurSel _paintjob > -1) then {
			
				{
				
					_veh setObjectTextureGlobal [_forEachIndex,_x];
				
				} forEach (call compile (_paintjob lbData (lbCurSel _paintjob)));
				_veh setVariable ["tuning_data",[(call compile (_paintjob lbData (lbCurSel _paintjob))),0],true];
			
			};
			
			/*if ((count _params) > 0) then {
				
				//systemChat str _params;
				//_params = _params select 0;
				{
					_veh setObjectTextureGlobal [_forEachIndex,_x];
				} forEach _params;
				_veh setVariable ["tuning_data",[_params,0],true];
				
			};*/
			
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
			
			sleep 0.5;
			
			{
				
				_veh setObjectTextureGlobal [_forEachIndex,_x];
				
			} forEach _tex;
			
		};
	};
	["Магазин",format ["Вы купили %1 %2 за %3 CRK.", _amount, _classname call fnc_getItemName, [_cost] call fnc_numberToText],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	
	(format ["[%1|%2|%7] has bought %3 %4 for %5 at %6", name player, getPlayerUID player, _amount, _classname, [_cost] call fnc_numberToText, curshop, side player]) remoteExec ["fnc_logMyStuff",2];
	
	antidupa = false;
	
	if (curshoptype=="gear") then {
	
		[(lbData [1504,lbCurSel 1504]),lbCurSel 1504] spawn fnc_tovarDescription;
	
	} else {
	
		[(lbData [1500,lbCurSel 1500]),lbCurSel 1500] spawn fnc_tovarDescription;
	};
	
	switch curshoptype do {
	
		case "virtitems": {[1] spawn fnc_switchToVirtItems};
		case "weapons": {[1] spawn fnc_switchToWeapons};
		case "gear": {[(lbData [2106, lbCurSel 2106]),1] spawn fnc_switchToGear_something;};
		case "vehicles": {[1] spawn fnc_switchToVehs};
	
	};
	
};
publicVariable "fnc_newBuyItem";
fnc_newSellItem = {
	if (antidupa and ((lastdupa+5)>time)) exitWith {hint "Неизвестная ошибка! Подождите 5 секунд!";};
	
	antidupa = true;
	lastdupa = time;
	
	disableSerialization;
	
	private ["_lb","_classname","_display","_itemstobuy_ctrl","_itemstosell_ctrl","_buyamount_ctrl","_sellamount_ctrl","_type228","_regplate","_vehicle","_sellprice","_maxstock","_stock","_cost","_price","_legal","_shop_object"];
	
	_display = findDisplay 502289;
	
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
	//closeDialog 0;
	
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
			(_isellers_array select 2) pushBack (name player);
		
		} else {
		
			(_isellers_array select 1) set [_isell_index, ((_isellers_array select 1) select _isell_index)+_cost];			
			(_isellers_array select 2) set [_isell_index, name player];			
		
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
	
	switch curshoptype do {
	
		case "virtitems": {[1] spawn fnc_switchToVirtItems};
		case "weapons": {[1] spawn fnc_switchToWeapons};
		case "gear": {[(lbData [2106, lbCurSel 2106]),1] spawn fnc_switchToGear_something;};
		case "vehicles": {[1] spawn fnc_switchToVehs};
	
	};
};
publicVariable "fnc_newSellItem";
fnc_getWeaponInfo = {
	private ["_item"];
	
	_item = _this;
	private _cfg = switch (true) do {
		case (isClass (configFile >> "CfgMagazines" >> _item)) : {"CfgMagazines"};
		case (isClass (configFile >> "CfgWeapons" >> _item)) : {"CfgWeapons"};
		case (isClass (configFile >> "CfgVehicles" >> _item)) : {"CfgVehicles"};
		case (isClass (configFile >> "CfgGlasses" >> _item)) : {"CfgGlasses"};
		default {""};
	};
	if (_cfg=="") exitWith {[]};
	if !(_cfg isEqualType "") exitWith {[]};
	if !(isClass (configFile >> _cfg >> _item)) exitWith {[]};
	private _config = configFile >> _cfg >> _item;
	private _displayName = getText (_config >> "displayName");
	private _picture = getText (_config >> "picture");
	private _desc = getText (_config >> "descriptionshort");
	private _bis_ItemType = [_item] call BIS_fnc_itemType;
	private _category = _bis_ItemType select 0;
	private _type = _bis_ItemType select 1;
	private _weight = switch (_category) do {
		case "Weapon" : {
			switch (_type) do {
				case "AssaultRifle"; 
				case "Shotgun"; 
				case "Rifle";
				case "SniperRifle" : {10};
				case "BombLauncher";
				case "Cannon";
				case "GrenadeLauncher";
				case "Launcher";
				case "Mortar";
				case "RocketLauncher" : {20};
				case "MachineGun";
				case "SubmachineGun" : {15};
				case "Handgun" : {5};
				default {5}; 
			};
		};
		case "Equipment" : {
			switch (_type) do {
				case "Glasses": {1};
				case "Headgear": {2};
				case "Vest";
				case "Uniform": {3};
				case "Backpack": {4};
				default {1};
			};
		};
		case "Magazine": {1};
		case "Item": {1};
		default {1};
	};
	private ["_magazines","_muzzles","_optics","_pointers","_bipods","_underBarrels"];
	if (_cfg=="CfgWeapons") then {
		_muzzles = [_item, "muzzle"] call BIS_fnc_compatibleItems;
		_optics = [_item, "optic"] call BIS_fnc_compatibleItems;
		_pointers = [_item, "pointer"] call BIS_fnc_compatibleItems;
		_bipods = [_item, "bipod"] call BIS_fnc_compatibleItems;
		_magazines = getArray (_config >> "magazines");
		private _muzzlesCfg = getArray (_config >> "muzzles");
		if (count _muzzlesCfg != 0) then {
			private _base = inheritsFrom _config;
			private _tmp = [];
			{
				if !(_x=="this") then {
					_tmp = getArray (_base >> _x >> "magazines");
					{
						_magazines set [count _magazines, _x];
						//systemChat str _magazines;
					} foreach (_tmp);
				};
			} foreach _muzzlesCfg;
		};
	} else {
		_magazines = [];
		_muzzles = [];
		_optics = [];
		_pointers = [];
		_bipods = [];
	};
	private _return = [_item,_displayName,_picture,_desc,_category,_type,_weight,_magazines,_muzzles,_optics,_pointers,_bipods];
	_return
};
publicVariable "fnc_getWeaponInfo";
fnc_shopShowInit = {
	ShopBoxPosition = [0,0,300];
	ShopBoxVehiclePosition = [0,0,300.5];
	ShopBoxBackgroundObject = "Land_Hangar_F" createVehicleLocal ShopBoxPosition;
	ShopBoxBackgroundObject enableSimulation false;
	ShopBoxBackgroundObject allowDamage false;
	ShopBoxBackgroundObject setPosASL ShopBoxPosition;
	ShopBoxBackgroundObject setDir (getDir player);
	ShopBoxLightSource = "#lightpoint" createVehicleLocal [0,0,0];
	ShopBoxLightSource lightAttachObject [ShopBoxBackgroundObject,[0,1.1,1.1]]; 
	ShopBoxLightSource setLightColor [255,255,255];
	ShopBoxLightSource setLightAmbient [1,1,0.2];
	ShopBoxLightSource setLightAttenuation [1,0,0,0];
	ShopBoxLightSource setLightIntensity 50;
	ShopBoxLightSource setLightUseFlare true;
	ShopBoxLightSource setLightFlareSize 0.2;
	ShopBoxLightSource setLightFlareMaxDistance 50;
	shopBoxVehicle = "Land_HelipadEmpty_F" createVehicleLocal ShopBoxVehiclePosition;
	ShopBoxVehicle setPosASL ShopBoxVehiclePosition;
	ShopBoxVehicle setDir (getDir player);
	ShopBoxVehicle enableSimulation false;
	ShopBoxRadius = 3;
	ShopBoxRadiusMax = 12;
	ShopBoxAngle = 0;
	ShopBoxAltitude = 302;
	ShopBoxSpeed = 0.01; 
	ShopBoxAngleStep = 5.5;
	ShopBoxRadStep = 0.5;
	ShopBoxAltitudeStep = 0.1;
	ShopBoxCameraCord = [ShopBoxVehicle,ShopBoxRadius,ShopBoxAngle] call BIS_fnc_relPos;
	ShopBoxCameraCord set [2, ShopBoxAltitude];
	ShopBoxCamera = "camera" camCreate ShopBoxCameraCord;
	ShopBoxCamera cameraEffect ["INTERNAL","BACK"];
	ShopBoxCamera camPrepareFOV 0.700;
	ShopBoxCamera camPrepareTarget ShopBoxVehicle;
	ShopBoxCameraCord = [ShopBoxVehicle,ShopBoxRadius,ShopBoxAngle] call BIS_fnc_relPos;
	ShopBoxCameraCord set [2, ShopBoxAltitude];
	ShopBoxCamera camPreparePos ShopBoxCameraCord;
	ShopBoxCamera camCommitPrepared ShopBoxSpeed;
	showCinemaBorder false;
	showChat false;
	
	life_rbm = false;
	(findDisplay 502289) displayAddEventHandler ["MouseButtonDown","if ((_this select 1) == 1) then {life_rbm = true}"];
	(findDisplay 502289) displayAddEventHandler ["MouseButtonUp","if ((_this select 1) == 1) then {life_rbm = false}"];
	(findDisplay 502289) displayAddEventHandler ["MouseMoving", "_this call fnc_shopCamRotate"];
	(findDisplay 502289) displayAddEventHandler ["MouseZChanged", "_this call fnc_shopCamZoom"];
	
	[] spawn {
		while {true} do {
			if (isNull (findDisplay 502289)) exitWith {
				showChat true;
				ShopBoxCamera cameraEffect ["terminate", "back"];
				camDestroy ShopBoxCamera;
				if (!isNil "ShopBoxTable" && {!isNull ShopBoxTable}) then {deleteVehicle ShopBoxTable};
				if (!isNil "ShopBoxVehicle" && {!isNull ShopBoxVehicle}) then {deleteVehicle ShopBoxVehicle};
				if (!isNil "ShopBoxBackgroundObject" && {!isNull ShopBoxBackgroundObject}) then {deleteVehicle ShopBoxBackgroundObject};
				if (!isNil "ShopBoxLightSource" && {!isNull ShopBoxLightSource}) then {deleteVehicle ShopBoxLightSource};
				if (!isNil "ShopBoxWeapHolder" && {!isNull ShopBoxWeapHolder}) then {deleteVehicle ShopBoxWeapHolder};
				if (!isNil "ShopBoxWeapTurnItem" && {!isNull ShopBoxWeapTurnItem}) then {deleteVehicle ShopBoxWeapTurnItem};
			};
			uiSleep 0.1;
		};
	};
};
publicVariable "fnc_shopShowInit";
fnc_shopCamRotate = {
	params ["_display","_xCoord","_yCoord"];
	if (isNil "ShopBoxVehicle") exitWith {};
	if (isNull ShopBoxVehicle) exitWith {};
	if (life_rbm) then {
		if (_xCoord > 0.25) then {
			if (ShopBoxAngle < 360) then {
				ShopBoxAngle = ShopBoxAngle + ShopBoxAngleStep;
			} else {ShopBoxAngle = 0};
			ShopBoxCameraCord = [ShopBoxVehicle,ShopBoxRadius,ShopBoxAngle] call BIS_fnc_relPos;
			ShopBoxCameraCord set [2, ShopBoxAltitude];
			ShopBoxCamera camPreparePos ShopBoxCameraCord;
			ShopBoxCamera camCommitPrepared ShopBoxSpeed;
		};
		if (_xCoord < -0.25) then {
			if (ShopBoxAngle > 0) then {
				ShopBoxAngle = ShopBoxAngle - ShopBoxAngleStep;
			} else {ShopBoxAngle = 360};
			ShopBoxCameraCord = [ShopBoxVehicle,ShopBoxRadius,ShopBoxAngle] call BIS_fnc_relPos;
			ShopBoxCameraCord set [2, ShopBoxAltitude];
			ShopBoxCamera camPreparePos ShopBoxCameraCord;
			ShopBoxCamera camCommitPrepared ShopBoxSpeed;
		};
		if (_yCoord > 0.3) then {
			if (ShopBoxAltitude < 307) then {
				ShopBoxAltitude = ShopBoxAltitude + ShopBoxAltitudeStep;
				ShopBoxCameraCord set [2, ShopBoxAltitude];
				ShopBoxCamera camPreparePos ShopBoxCameraCord;
				ShopBoxCamera camCommitPrepared ShopBoxSpeed;
			};
		};
		if (_yCoord < -0.3) then {
			if (ShopBoxAltitude > 301) then {
				ShopBoxAltitude = ShopBoxAltitude - ShopBoxAltitudeStep;
				ShopBoxCameraCord set [2, ShopBoxAltitude];
				ShopBoxCamera camPreparePos ShopBoxCameraCord;
				ShopBoxCamera camCommitPrepared ShopBoxSpeed;
			};
		};
	};
};
publicVariable "fnc_shopCamRotate";
fnc_shopCamZoom = {
	if (isNil "ShopBoxVehicle") exitWith {};
	if (isNull ShopBoxVehicle) exitWith {};
	if (life_rbm) then {
		if (_scroll > 0) then {
			ShopBoxRadius = ShopBoxRadius - ShopBoxRadStep;
			if (ShopBoxRadius < 1) then {ShopBoxRadius = 1};
			ShopBoxCameraCord = [ShopBoxVehicle,ShopBoxRadius,ShopBoxAngle] call BIS_fnc_relPos;
			ShopBoxCameraCord set [2, ShopBoxAltitude];
			ShopBoxCamera camPreparePos ShopBoxCameraCord;
			ShopBoxCamera camCommitPrepared ShopBoxSpeed;
		};
		if (_scroll < 0) then {
			ShopBoxRadius = ShopBoxRadius + ShopBoxRadStep;
			if (ShopBoxRadius > ShopBoxRadiusMax) then {ShopBoxRadius = ShopBoxRadiusMax};
			ShopBoxCameraCord = [ShopBoxVehicle,ShopBoxRadius,ShopBoxAngle] call BIS_fnc_relPos;
			ShopBoxCameraCord set [2, ShopBoxAltitude];
			ShopBoxCamera camPreparePos ShopBoxCameraCord;
			ShopBoxCamera camCommitPrepared ShopBoxSpeed;
		};
	};
};
publicVariable "fnc_shopCamZoom";
