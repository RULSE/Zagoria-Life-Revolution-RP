
iactionarr = [];
aactionarr = [];
while {true} do 
 
{
	_animals = ["WildBoar","WildBoarBoss"];
	
	_dead_animals = nearestObjects [getpos player, _animals, 2];
	{
		_exitvar = false;
		for "_i" from 0 to (count aactionarr) do 
		{
			_arr = aactionarr select _i;
			if (!isnil "_arr") then {
				if(_x in _arr)exitwith{_exitvar=true};
			};
		};
		
		if(_exitvar)exitwith{};	
		if ((_x distance player < 3) and (!(alive _x)))then
			{
			
			_action = player addaction ["Освежевать животное",{_this spawn fnc_osvezh},[_x],1.5,true,true,"","(vehicle player == player) and (_target == player)",-1];
			//_action =  player addAction ["String Exec", "hint 'this is also compiled'"];
		
			aactionarr = aactionarr + [[_x, _action]];
			};
		} foreach _dead_animals;
		for [{_i=0}, {_i < (count aactionarr)}, {_i=_i+1}] do 
			{
			_arr	= aactionarr select _i;
			_obj    = _arr select 0;
			_action = _arr select 1;
				
			if(isnull _obj or _obj distance player > 2)then
				{
				player removeaction _action;
				aactionarr set [_i, 0];
				aactionarr = aactionarr - [0];
				};
			};
	
	
	_objs 	= nearestObjects [getpos player, itemobjects, 2];
		{
		_exitvar = false;
		for "_i" from 0 to (count iactionarr) do 
		{
			_arr = iactionarr select _i;
			if (!isnil "_arr") then {
				if(_x in _arr)exitwith{_exitvar=true};
			};
		};
		
		if(_exitvar)exitwith{};	
		if(_x distance player < 3)then
			{
			
			_amount	= _x getvariable ["amount",0];
			
			if (_amount>0) then {
				_item 	= _x getvariable "item";
				_name	= _item call fnc_getItemName;
				
				_action = player addaction [format["Поднять %1 (%2)", _name, _amount],fnc_pickUpItem,[_x, _item, _amount],1.5,true,true,"","(vehicle player == player) and (_target == player)"];
			
				iactionarr = iactionarr + [[_x, _action]];
			
			};
			};
		} foreach _objs;
		for [{_i=0}, {_i < (count iactionarr)}, {_i=_i+1}] do 
			{
			_arr	= iactionarr select _i;
			_obj    = _arr select 0;
			_action = _arr select 1;
			_var	= _obj getvariable "amount"; 
				
			if(isnull _obj or _obj distance player > 2 or (isnil "_var"))then
				{
				player removeaction _action;
				iactionarr set [_i, 0];
				iactionarr = iactionarr - [0];
				};
			};
		
	sleep 0.2;
};
