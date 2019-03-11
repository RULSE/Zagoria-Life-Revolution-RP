
disableSerialization;
private ["_display","_itemstobuy_ctrl","_itemstosell_ctrl","_buyamount_ctrl","_sellamount_ctrl","_shop","_items","_classnames"];
_shop = _this select 3;
_copshops = [];
if !((str player) in cop_array) then {
	_copshops = ["cop_carshop_1","cop_weaponshop_1","cop_equipment_1"];
};
if (_shop in _copshops) exitWith {hint "Вам недоступен этот магазин.";};
_items = _shop call fnc_getShopItems;
//copyToClipboard str _items;
shop_mierda_new = _items;
_classnames = _items select 1;
_items = _items select 0;
//[[["waterbottle",476,250,1000,5,"none",[]],["beer_baltika3",98,150,1000,5,"none",[]],["beer_baltika9",91,300,1000,5,"none",[]],["beer_bratan",93,120,1000,5,"none",[]],["beer_kozlice",40,320,1000,5,"none",[]],["vodka_taras",49,1200,1000,5,"none",[]],["vodka_putinka",96,1500,1000,5,"none",[]],["vodka_finka",64,2100,1000,5,"none",[]],["whiskey_redlabel",69,3000,500,5,"none",[]],["whiskey_jackdaniels",44,4000,300,5,"none",[]],["cognac_ararar",80,2500,500,5,"none",[]],["cognac_ludvig",1,24000,100,5,"none",[]],["stal_cigpack",95,600,1000,5,"none",[]],["cigpack_president",86,1200,1000,5,"none",[]],["cigpack_windstone",97,1500,1000,5,"none",[]],["cigpack_smallboro",5,1800,100,5,"none",[]]],["waterbottle","beer_baltika3","beer_baltika9","beer_bratan","beer_kozlice","vodka_taras","vodka_putinka","vodka_finka","whiskey_redlabel","whiskey_jackdaniels","cognac_ararar","cognac_ludvig","stal_cigpack","cigpack_president","cigpack_windstone","cigpack_smallboro"]]
shop_mierda = _items;
curshop = global_shops_array_classes find _shop;
_spawn = _shop call fnc_getShopSpawn;
legalshopyesno = ((global_shops_array select curshop) select 16) select 0;
//systemChat str (_shop call fnc_getShopCrate);
//systemChat str (_shop call fnc_getShopSpawn);
//systemChat str (_shop call fnc_getShopItems);
newshop_virtarray = [];
newshop_wepsarray = [];
newshop_geararray_other = [];
newshop_geararray_uniforms = [];
newshop_geararray_vests = [];
newshop_geararray_headgear = [];
newshop_geararray_goggles = [];
newshop_geararray_backpacks = [];
newshop_veharray = [];
{
	switch (_x call fnc_getItemType) do {
	
		case "item": {newshop_virtarray pushBack _x};
		case "weapon": {newshop_wepsarray pushBack _x};
		case "vehicle": {newshop_veharray pushBack _x};
		case "uniform": {newshop_geararray_uniforms pushBack _x};
		case "vest": {newshop_geararray_vests pushBack _x};
		case "backpack": {newshop_geararray_backpacks pushBack _x};
		case "gameitem": {
		
		
		
			switch ((_x call fnc_getWeaponInfo) select 5) do {			
				case "Headgear": {newshop_geararray_headgear pushBack _x;};
				case "Glasses": {newshop_geararray_goggles pushBack _x;};
				default {newshop_geararray_other pushBack _x;};			
			};		
		
		};
	
	};
} forEach _classnames;
if (!(createDialog "generic_shop_dialog_new")) exitWith {hint "Dialog Error!";};
[] spawn fnc_shopShowInit;
_display = findDisplay 502289;
_shopname = _display displayCtrl 1100;
_playercash = _display displayCtrl 1101;
_shopname ctrlSetText ((global_shops_array select (global_shops_array_classes find _shop)) select 1);
_playercash ctrlSetText format ["Наличные: %1 CRK", "money" call fnc_getItemAmount];
/*_display = findDisplay 50100;
_itemstobuy_ctrl = _display displayCtrl 1500;
_itemstosell_ctrl = _display displayCtrl 1501;
_buyamount_ctrl = _display displayCtrl 1400;
_sellamount_ctrl = _display displayCtrl 1401;*/
if (count newshop_virtarray > 0) exitWith {[] spawn fnc_switchToVirtItems;};
if (count newshop_wepsarray > 0) exitWith {[] spawn fnc_switchToWeapons;};
if (count (newshop_geararray_other+newshop_geararray_uniforms+newshop_geararray_vests+newshop_geararray_backpacks+newshop_geararray_headgear+newshop_geararray_goggles) > 0) exitWith {[] spawn fnc_switchToGear;};
if (count newshop_veharray > 0) exitWith {[] spawn fnc_switchToVehs};
if true exitWIth {};
{
	switch ((_x select 0) call fnc_getItemType) do {
		case "item": {
			if ((_x select 3)==-1) then {
				_itemstobuy_ctrl lbAdd format ["%1", (_x select 0) call fnc_getItemName, (_x select 0) call fnc_getItemWeight, (_x select 1), ceil((_x select 2)*(1+nds_tax))];
			};
			if ((_x select 3)==0) then {
				_itemstobuy_ctrl lbAdd format ["%1 [НЕ ПРОДАЁТСЯ]", (_x select 0) call fnc_getItemName, (_x select 0) call fnc_getItemWeight, (_x select 1), ceil((_x select 2)*(1+nds_tax))];
			};
			if ((_x select 3)>0) then {
				_itemstobuy_ctrl lbAdd format ["%1 %3/%4 шт.", (_x select 0) call fnc_getItemName, (_x select 0) call fnc_getItemWeight, (_x select 1), (_x select 3), ceil(([_x select 1,_x select 3,_x select 2] call fnc_getItemStockPrice)*(1+nds_tax))];
			};
		};
		default {
			if ((_x select 3)==-1) then {
				_itemstobuy_ctrl lbAdd format ["%1", (_x select 0) call fnc_getItemName, (_x select 1), (_x select 2)*(1+nds_tax)];
			};
			if ((_x select 3)==0) then {
				_itemstobuy_ctrl lbAdd format ["%1 [НЕ ПРОДАЁТСЯ]", (_x select 0) call fnc_getItemName, (_x select 1), (_x select 2)*(1+nds_tax)];
			};
			if ((_x select 3)>0) then {
				_itemstobuy_ctrl lbAdd format ["%1 %2/%3 шт.", (_x select 0) call fnc_getItemName, (_x select 1), (_x select 3), ceil(([_x select 1,_x select 3,_x select 2] call fnc_getItemStockPrice)*(1+nds_tax))];
			};
		};
	};
	_itemstobuy_ctrl lbSetData [(lbSize _itemstobuy_ctrl)-1,_x select 0];
} foreach _items;
if ((_shop call fnc_getShopBuyshit) == 1) then {
	{
		if (_x in _classnames) then {
			private ["_price","_stock","_maxstock"];
			_price = (_items select (_classnames find _x)) select 2;
			_maxstock = (_items select (_classnames find _x)) select 3;
			_stock = (_items select (_classnames find _x)) select 1;
			if (_maxstock==-1) then {
				_itemstosell_ctrl lbAdd format ["%1 %2 кг %3 шт. %4 CRK", _x call fnc_getItemName, _x call fnc_getItemWeight, _x call fnc_getItemAmount, floor (_price/2)];
			} else {
				_itemstosell_ctrl lbAdd format ["%1 %2 кг %3 шт. %4 CRK", _x call fnc_getItemName, _x call fnc_getItemWeight, _x call fnc_getItemAmount, floor (([_stock,_maxstock,_price] call fnc_getItemStockPrice)/2)];
			};
			_itemstosell_ctrl lbSetData [(lbSize _itemstosell_ctrl)-1,_x];
		};
	} foreach inventory_items;
	
	{
		if (((typeOf _x) in _classnames) and ((_x getVariable ["regplate","none"]) in vehicle_keys)) then {
			private ["_price","_stock","_maxstock"];
			_price = (_items select (_classnames find (typeOf _x))) select 2;
			_maxstock = (_items select (_classnames find (typeOf _x))) select 3;
			_stock = (_items select (_classnames find (typeOf _x))) select 1;
			if (_maxstock==-1) then {
				_itemstosell_ctrl lbAdd format ["%1 %2 CRK", (typeOf _x) call fnc_getItemName, floor (_price/2)];
			} else {
				_itemstosell_ctrl lbAdd format ["%1 %2 CRK", (typeOf _x) call fnc_getItemName, floor (([_stock,_maxstock,_price] call fnc_getItemStockPrice)/2)];
			};
			_itemstosell_ctrl lbSetData [(lbSize _itemstosell_ctrl)-1,_x getVariable ["regplate","error"]];
		};
	} foreach ((position _spawn) nearObjects ["AllVehicles", 50]);
	
};
ctrlSetText [1002, format ['Наличные: %1 CRK', ("money" call fnc_getItemAmount)]];
