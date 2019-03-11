
_death = _this select 0;
switch _death do {
	case "hunger": {
		player setdamage 1;
		hunger = 0;
		thirst = 0;
	};
	case "thirst": {
		player setdamage 1;
		hunger = 0;
		thirst = 0;
	};
};
