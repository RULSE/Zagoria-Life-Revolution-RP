
_boarboss = _this;
_boarboss forcespeed 40;
(group _boarboss) setSpeedMode "FULL";
_boarboss setVariable ["cansay", 0, true];
while {alive _boarboss} do {
	_target = dummy;
	_targets = [];
	
	_boarboss setVariable ["cansay", (_boarboss getVariable "cansay") - 1, true];
	{
		if ((isPlayer _x) and (alive _x)) then {_targets pushBack _x};
	} foreach (nearestObjects [_boarboss,["Man"],300]);
	if (count _targets > 0) then {_target = _targets select 0};
		
	_sleepTime = 8;
		
	if (_target != dummy) then {
		
		if (_boarboss distance _target < 25) then {call compile format ["if (_boarboss getVariable 'cansay' < 1) then {_boarboss say 'sekach%2'; _boarboss setVariable ['cansay', 10, true]};",_boarboss,round(random 3)+1];};
		
		_boarboss move getpos _target;
		
		if (_boarboss distance _target > 80) then {_sleepTime = 5;};
		if (_boarboss distance _target <= 80) then {_sleepTime = 2;};
		if (_boarboss distance _target < 50) then {_sleepTime = 0.6;};
		if (_boarboss distance _target < 25) then {_sleepTime = 0.4;};
		
				
		if (_boarboss distance _target < 6) then {
			
			_boarboss setDir ([_boarboss, _target] call BIS_fnc_dirTo);
			_boarboss switchMove "WildBoar_Run";
		
		};
			
		if (_boarboss distance _target < 4) then {
			
			_target setdamage (damage _target + 0.3);
		
		};	
	
	} else {
		[group _boarboss, getMarkerPos "hunt1", 1000] call BIS_fnc_taskPatrol;
	};
	
	sleep _sleepTime;
};
