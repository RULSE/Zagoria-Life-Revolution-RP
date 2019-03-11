
_shop = _this select 3;
_items = _shop call fnc_getShopItems;
curshop = shopclass_array find _shop;
if (!(createDialog "carshop_dialog")) exitWith {hint "Dialog Error!";};
{lbAdd [1500, format ["%1 %2 шт.", (_x select 0) call fnc_getItemName, (_x select 3)]];} foreach _items;
ctrlSetText [1002, format ['Наличные: %1 CRK', ("money" call fnc_getItemAmount)]];
