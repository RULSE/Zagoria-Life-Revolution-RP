
_mushroomsarray = [
	["mushrooms_1", 300],
	["mushrooms_2", 300]
];
_maxmushrooms = 500;
while{true}do
{
	for [{_i=0}, {_i < (count _mushroomsarray)},{_i=_i+1}] do {
		
		_pos  	= getmarkerpos ((_mushroomsarray select _i) select 0);
		_area 	= (_mushroomsarray select _i) select 1;
		_mushrooms 	= nearestobjects [_pos, ["Baseball"], _area];
		_mushrooms = nearestobjects [_pos, ["Baseball"], _area];
		
		if(count _mushrooms < _maxmushrooms)then{
			(createVehicle ["Baseball", _pos, [], _area, "NONE"]) setVariable ["grib",1 + (round (random 5)), true];;
		};
		
			
	};
	sleep 0.1;
};
