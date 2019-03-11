
_vehicle = vehicle player;
if (_vehicle getVariable ["refueling_now",false]) exitWith {["Заправка уже идёт","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;};
_price = 50;
_station = (getPos (vehicle player)) nearestObject "Land_A_FuelStation_Feed";
_vehicle setVariable ["refueling_now",true];
["Заправляем...","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
while {(vehicle player != player) and (player distance _station < 6) and ("money" call fnc_getItemAmount > round(_price*nds_tax)) and (fuel (vehicle player) < 1)} do {
	gov_money = gov_money + round(_price*inc_tax);
	publicVariable "gov_money";
		
	["money",round(_price*(1+nds_tax))] call fnc_removeItem;
	(vehicle player) setfuel (fuel (vehicle player) + 0.01);
	sleep 1;
};
_vehicle setVariable ["refueling_now",false];
["Заправка завершена","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
