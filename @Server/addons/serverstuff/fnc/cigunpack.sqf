
_amount = _this select 0;
_params = _this select 1;
_item = _this select 2;
_cigs = _params select 0;
_cigs_amount = _params select 1;
[_item,_amount] call fnc_removeItem;
[_cigs,_cigs_amount] call fnc_addItem;
["Вы открыли пачку.","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
