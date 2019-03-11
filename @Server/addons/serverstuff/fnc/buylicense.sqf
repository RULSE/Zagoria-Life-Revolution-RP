
_this = _this select 3;
_license = _this select 0;
_price = _this select 1;
_legal = _this select 2;
if (_license call fnc_playerHasLicense) then {
		["У вас уже есть эта лицензия.","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
};
if (_price > ("money" call fnc_getItemAmount)) then {
		["Недостаточно денег.","",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
};
if ((not (_license call fnc_playerHasLicense)) and (_price <= ("money" call fnc_getItemAmount))) then {
	if (_legal==1) then {
		licenses = licenses + [_license];
	} else {
		licenses_illegal = licenses_illegal + [_license];
	};
	["money", _price] call fnc_removeItem;
	
	["Лицензия приобретена",format ["Вы купили %1 за %2 CRK",_license call fnc_getLicenseName, _price],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
};
player setVariable ["licenses_array",licenses,true];
