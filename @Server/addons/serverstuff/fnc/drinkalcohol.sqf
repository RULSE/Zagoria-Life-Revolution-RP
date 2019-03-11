
_amount = _this select 0;
_params = _this select 1;
_item = _this select 2;
_value = _params select 0;
_value2 = _params select 1;
_value3 = _params select 2;
_rpadd = true;
_sleepval = 30/_value;
if (_amount>1) then {_amount = 1;};
if (((cooldown_array select 0) find "alco_cd")>-1) then {_rpadd = false;};
if (religion in ["sunni"]) then {
	_rpadd = false;
	["Харам","Вы пьёте алкоголь будучи суннитом. Вы потеряли 100 RPP.",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
	if ((roleplay_pts-100)>0) then {
		roleplay_pts=roleplay_pts-100;
		//[100,true] call fnc_removeRPP;
	} else {
		roleplay_pts=0;
		//[100,true] call fnc_removeRPP;
	};
};
[_item,_amount] call fnc_removeItem;
if _rpadd then {
	(cooldown_array select 0) pushBack "alco_cd";
	(cooldown_array select 1) pushBack _value2;
};
switch _item do {
	
	case "vodka_taras": {
		
		_message = selectRandom ["Брррлллээээээ..."];
		
		systemChat _message;
		
	};	
	
};
for "_i" from 1 to _value do {
	
	if _rpadd then {_value3 call fnc_addRPP; stress_value = stress_value - 2;};
	
	if (stress_value<0) then {stress_value=0;};
	
	_blood_stuff = (blood_array select 0);
	_blood_amounts = (blood_array select 1);
	
	if ("alcohol" in _blood_stuff) then {
		
		private ["_ind"];
		
		_ind = _blood_stuff find "alcohol";
		
		_blood_amounts set [_ind, (_blood_amounts select _ind)+1];
		
	} else {
		
		_blood_stuff pushBack "alcohol";
		_blood_amounts pushBack 1;
		
	};
	
	sleep _sleepval;
};
