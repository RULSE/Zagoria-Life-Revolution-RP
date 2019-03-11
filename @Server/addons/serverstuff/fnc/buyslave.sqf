
_money = "money" call fnc_getItemAmount;
_uid = getPlayerUID player;
_index = (slave_owners_array find _uid);
_slavenumber = 0;
if (_index<0) then {
	slave_owners_array pushBack _uid;
	publicVariable "slave_owners_array";
	slaves_array pushBack [];
	publicVariable "slaves_array";
	_slavenumber = 0;
} else {
	_slavenumber = count (slaves_array select _index);
};
_index = (slave_owners_array find _uid);
if (_slavenumber>=5) exitWith {
	["Слишком много рабов.","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
};
if (_money <= 50000) exitWith {
	["Недостаточно денег.","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
};
["money", 50000] call fnc_removeItem;
["Вы купили раба.","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
_civ = "C_man_p_beggar_F";
_civ createUnit [position player, group player, format ["slave_%1 = this; this setVehicleVarName ""slave_%1""; publicVariable ""slave_%1"";", slave_counter]];
waitUntil {!isNil format ["slave_%1",slave_counter]};
_slavename = call compile format ["slave_%1",slave_counter];
(slaves_array select _index) pushBack _slavename;
publicVariable "slaves_array";
slave_counter = slave_counter + 1;
publicVariable "slave_counter";
_args = [_slavename,player];
_args remoteExec ["fnc_buySlave_code",2];
