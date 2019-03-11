
_amount = _this select 0;
_params = _this select 1;
_item = _this select 2;
_value = _params select 0;
_value2 = _params select 1;
_value3 = _params select 2;
_value4 = _params select 3;
_addval = _value3/30;
_addval2 = _value4/30;
_sleepval = 30/_value3;
_smoke = ["mari"];
_rpadd = true;
if (_amount>1) then {_amount = 1;};
if (((cooldown_array select 0) find "narco_cd")>-1) then {_rpadd = false;};
[_item,_amount] call fnc_removeItem;
if _rpadd then {
	(cooldown_array select 0) pushBack "narco_cd";
	(cooldown_array select 1) pushBack 10;
};
switch _item do {
	
	case "stal_cigarette": {
		
		_message = selectRandom ["Чувствую стальной привкус.","Очень индустриально.","Хочется молот в руки взять."];
		
		systemChat _message;
		
	};
	
	
};
if (_item in _smoke) then {
	
	//_value2 = 200/30;
	for "_i" from 1 to 30 do {
		_unit = player;
		
		if !(alive _unit) exitWith {};
		
		if _rpadd then {_value2 call fnc_addRPP;};
		
		stress_value = stress_value - _addval;
		if (stress_value<0) then {stress_value=0;};
		
		_blood_stuff = (blood_array select 0);
		_blood_amounts = (blood_array select 1);
	
		if (_value in _blood_stuff) then {
			
			private ["_ind"];
			
			_ind = _blood_stuff find _value;
			
			_blood_amounts set [_ind, (_blood_amounts select _ind)+_addval2];
			
		} else {
			
			_blood_stuff pushBack _value;
			_blood_amounts pushBack _addval2;
			
		};
	
		if (stress_value<0) then {stress_value = 0};
		private _multiplier = 1;
		private _source = "logic" createVehicleLocal (getPos _unit);
		private _fog = "#particleSource" createVehicleLocal getPos _source;
		_fog setParticleParams ["\A3\data_f\cl_basic",
		"",
		"Billboard",
		0.5,
		2,
		[0, 0, 0],
		[0, 0.1, -0.1],
		1,
		1.2,
		1,
		0.1,
		[0.1 * _multiplier, 0.2 * _multiplier, 0.1 * _multiplier],
		[[0.2 * _multiplier, 0.2 * _multiplier, 0.2 * _multiplier, 0.3 * _multiplier], [0, 0, 0, 0.01], [1, 1, 1, 0]],
		[500],
		1,
		0.04,
		"",
		"",
		_source];
		_fog setParticleRandom [2, [0, 0, 0], [0.25, 0.25, 0.25], 0, 0.5, [0, 0, 0, 0.1], 0, 0, 10];
		_fog setDropInterval 0.005;
		_source attachTo [_unit, [0, 0.06, 0], "head"];
		sleep 0.4;
		deleteVehicle _source;
		
		sleep 1.6;
	};
} else {
	
	for "_i" from 1 to 30 do {
	
		if _rpadd then {_value2 call fnc_addRPP};
		
		stress_value = stress_value - _addval;
		if (stress_value<0) then {stress_value=0;};
		
		_blood_stuff = (blood_array select 0);
		_blood_amounts = (blood_array select 1);
		
		if (_value in _blood_stuff) then {
			
			private ["_ind"];
			
			_ind = _blood_stuff find _value;
			
			_blood_amounts set [_ind, (_blood_amounts select _ind)+_addval2];
			
		} else {
			
			_blood_stuff pushBack _value;
			_blood_amounts pushBack _addval2;
			
		};
		
		sleep 1;
	};
	
};
