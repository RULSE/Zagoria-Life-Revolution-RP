
_amount = _this select 0;
_params = _this select 1;
_item = _this select 2;
_value = _params select 0;
_value = round (_value*1.5);
_value2 = _params select 0;
//if (_amount>1) then {_amount=1;};
if ((thirst-_value)>=0) then {
	//roleplay_pts = roleplay_pts + _value2;
	_value2 call fnc_addRPP;
};
[_item,_amount] call fnc_removeItem;
thirst = thirst - (_value*_amount);
if (thirst<0) then {thirst = 0};
["Вы утолили жажду","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
exit
