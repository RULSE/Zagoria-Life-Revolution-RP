
//if (taxijob) exitWith {hint "Вы уже работаете таксистом.";};
private ["_action","_marker","_markerdestination","_markerarray","_number","_dp","_package"];
_action = _this select 0;
if (_action == "finish") then {
		
	courierjob = false;
	couriertarget = dummy;
	couriertimeleft = 0;
	couriertimeleftmax = 0;
	
	player removeSimpleTask cour_task;
	
	["Вы завершили работу курьера.","",[1,1,1,1],[0.5,0.25,0,0.8]] spawn fnc_notifyMePls;
	
};
if (_action == "start") then {
	
	courierjob = true;
	
	_dp = selectRandom dp_array;
	_number = (dp_array find _dp) + 1;
	
	_package = selectRandom ["эти порножурналы нашему покупателю","ароматную пиццу", "немного видеоигр", "пару писем", "этот небольшой пакет"];
	["Курьер",format ["Доставьте %1 на ТД %2", _package, _number],[1,1,1,1],[0.5,0.25,0,0.8]] spawn fnc_notifyMePls;
	
	couriertimeleft = round((player distance _dp)/8);
	couriertimeleftmax = round((player distance _dp)/8);
	
	[_number,_dp,round(player distance _dp)] spawn {
	
		private ["_number","_dp","_distance","_money"];
		
		_number = _this select 0;
		_dp = _this select 1;
		_distance = _this select 2;	
		
		cour_task = player createSimpleTask ["DriveToDP"];
		cour_task setSimpleTaskDescription [format ["Отвезите груз на ТД%1.",_number],"Отвезти груз","Привезти"];
		cour_task setSimpleTaskDestination (getPosATL _dp);
		cour_task setSimpleTaskAlwaysVisible true;
		cour_task setTaskState "Assigned";
	
		while {true} do {
		
			couriertimeleft = couriertimeleft - 1;
			
			hintSilent format ["Осталось %1 секунд для доставки на ТД %2",couriertimeleft,_number];
			
			if (((player distance _dp)<5) and ((vehicle player) == player) and courierjob) exitWith {
			
				_money = round(couriertimeleftmax*8*0.5 + (couriertimeleftmax*(1-((couriertimeleftmax-couriertimeleft)/couriertimeleftmax))));
							
				courierjob = false;
				couriertarget = dummy;
				couriertimeleft = 0;
				couriertimeleftmax = 0;
				
				_money = _money*2;
				
				["money",_money] call fnc_addItem;
	
				player removeSimpleTask cour_task;
				
				["Курьер",format ["Доставка успешно завершена! Вы заработали %1 CRK", _money],[1,1,1,1],[0.5,0.25,0,0.8]] spawn fnc_notifyMePls;
			};
			
			if (!(alive player) or !courierjob) exitWith {
			
				["finish"] call fnc_jobCourier;
			
			};
		
			sleep 1;
			
		};
	
	};
	
};
