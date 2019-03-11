
_amount = _this select 0;
_params = _this select 1;
_item = _this select 2;
_value = _params select 0;
_value2 = _params select 1;
_rpadd = true;
if smokingcig exitWith {
	["Я уже курю сигарету.","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
};
if (_amount>1) then {_amount = 1;};
if (((cooldown_array select 0) find "nikotin_cd")>-1) then {_rpadd=false;};
[_item,_amount] call fnc_removeItem;
if _rpadd then {
	(cooldown_array select 0) pushBack "nikotin_cd";
	(cooldown_array select 1) pushBack 3;
};
switch _item do {
	
	case "stal_cigarette": {
		
		_message = selectRandom ["Ухх, намана..."];
				
	};
	
	
};
smokingcig = true;
for "_i" from 0 to 30 do {
	_unit = player;
	
	if !(alive _unit) exitWith {};
	
	//if _rpadd then {roleplay_pts = roleplay_pts + _value2;};
	if _rpadd then {_value2 call fnc_addRPP;};
	
	stress_value = stress_value - _value;
	
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
smokingcig = false;
