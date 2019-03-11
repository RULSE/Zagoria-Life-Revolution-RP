
{
	
	_newlamp = "Land_Lampadrevo" createVehicle [0,0,0];
	_newlamp setPosATL (getPosATL _x);
	_newlamp setDir ((getDir _x)+90);
		
	_x allowDamage false;
	hideObjectGlobal _x;
	
} forEach ((getPos centermap) nearObjects ["Land_PowLines_WoodL", 20000]);
electro_kek = true;
publicVariable "electro_kek";
[] spawn {
	while {true} do {
	
		electro_kek = true;
		publicVariable "electro_kek";
		
		[] remoteExec ["fnc_checkLampsWorking"];	
		
		waitUntil {(!alive power_1) and (!alive power_2) and (!alive power_3)};
	
		electro_kek = false;
		publicVariable "electro_kek";
		
		[] remoteExec ["fnc_checkLampsWorking"];
		waitUntil {(alive power_1) and (alive power_2) and (alive power_3)};
	
	};
};
fnc_checkLampsWorking = {
	private ["_types","_code","_args","_lamps"];
	_types = ["Land_Lampadrevo", "Land_PowLines_ConcL", "Land_lampa_ind_zebr", "Land_lampa_sidl_3", "Land_lampa_vysoka", "Land_lampa_ind", "Land_lampa_ind_b", "Land_lampa_sidl"];
		
	if !electro_kek then {
		 
		for [{_i=0},{_i < (count _types)},{_i=_i+1}] do 
		 
		{
		 
		_lamps = (getPos garage_1) nearObjects [_types select _i, 10000]; 
		 
		{_x setHit ["Light_1_hitpoint", 1];} forEach _lamps; 
		 
		};
		
		["Электростанция","В результате террористического акта электростанция вышла из строя! Эта ночь будет особенно тёмной...",[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;
	
	} else {
			
		["Электростанция","Электроснабжение работает в штатном режиме.",[1,1,1,1],[0.5,0,0,0.8]] spawn fnc_notifyMePls;
		
		for [{_i=0},{_i < (count _types)},{_i=_i+1}] do 
		 
		{
		 
		_lamps = (getPos garage_1) nearObjects [_types select _i, 10000]; 
		 
		{_x setHit ["Light_1_hitpoint", 0];} forEach _lamps; 
		 
		};
	
	};
};
publicVariable "fnc_checkLampsWorking";
/*
factory_wages = [
	[15],
	[16],
	[18],
	[16]
];
publicVariable "factory_wages";
factory_wagers = [
	["server"],
	["server"],
	["server"],
	["server"]
];
publicVariable "factory_wagers";
factory_whs = [
	[0],
	[0],
	[0],
	[0]
];
publicVariable "factory_whs";
factory_money = [
	[-1],
	[-1],
	[-1],
	[-1]
];
publicVariable "factory_money";*/
/*
nds_tax = 0.18;
publicVariable "nds_tax";
inc_tax = 0.13;
publicVariable "inc_tax";
currentplate = 100;
publicVariable "currentplate";
*/
restartsoon = false;
publicVariable "restartsoon";
execute_players_array = [];
publicVariable "execute_players_array";
execute_players_array_names = [];
publicVariable "execute_players_array_names";
cop_array = ["cop_1","cop_2","cop_3","cop_4","cop_5","cop_6","cop_7","cop_8","cop_9","cop_10","cop_11","cop_12","cop_13","cop_14","cop_15","cop_16","cop_17","cop_18","cop_19","cop_20","cop_21","cop_22","cop_23","cop_24","cop_25","cop_26","cop_27","cop_28","cop_29","cop_30"];
publicVariable "cop_array";
		
/*[] spawn {
	while {true} do {
		cop_array = [cop_1,cop_2,cop_3,cop_4,cop_5,cop_6,cop_7,cop_8,cop_9,cop_10,cop_11,cop_12,cop_13,cop_14,cop_15];
		publicVariable "cop_array";
	};
};*/
current_governor = "server";
publicVariable "current_governor";
current_governor_name = "никто";
publicVariable "current_governor_name";
people_voted = [];
publicVariable "people_voted";
people_votes = [];
publicVariable "people_votes";
people_votes_names = [];
publicVariable "people_votes_names";
[] spawn {
	
	while {true} do {
		private ["_newGov","_newGovVotes","_oldGov","_newGovName"];
		
		_oldGov = current_governor;
		_newGov = "server";
		_newGovVotes = 0;
		_newGovName = "никто";
		
		{
			private ["_gov"];
			
			_gov = _x;
			
			if (({_x==_gov} count people_votes) > _newGovVotes) then {
				_newGov = _x;
				_newGovName = people_votes_names select _forEachIndex;
				_newGovVotes = ({_x==_gov} count people_votes);
			};
			
		} forEach people_votes;
		
		current_governor = _newGov;
		publicVariable "current_governor";
		current_governor_name = _newGovName;
		publicVariable "current_governor_name";
		
		if (current_governor=="server") then {
			
			_code = {
				
				["Правительство","Губернатор не был выбран.",[1,1,1,1],[0,0,0.5,0.8]] spawn fnc_notifyMePls;
			
			};
			
			[[],_code] remoteExec ["spawn"];
			
		} else {
		
			if (current_governor==_oldGov) then {				
					
				_code = {
					
					["Правительство",format ["По результатам выборов старый губернатор %1 остаётся на своём посту.", current_governor_name],[1,1,1,1],[0,0,0.5,0.8]] spawn fnc_notifyMePls;
				
				};
				
				[[],_code] remoteExec ["spawn"];
				
			} else {	
					
				_code = {
					
					["Правительство",format ["По результатам выборов %1 занял пост губернатора.", current_governor_name],[1,1,1,1],[0,0,0.5,0.8]] spawn fnc_notifyMePls;
				
				};
				
				[[],_code] remoteExec ["spawn"];
				
			};
		
		};
		
		sleep 900;
	};	
	
};
slaves_array = [];
publicVariable "slaves_array";
slave_owners_array = [];
publicVariable "slave_owners_array";
slave_counters_array = [];
publicVariable "slave_counters_array";
slave_counter = 0;
publicVariable "slave_counter";
wanted_players_names = [];
publicVariable "wanted_players_names";
wanted_players_array = [];
publicVariable "wanted_players_array";
wanted_players_list = [];
publicVariable "wanted_players_list";
playerlist = [];
publicVariable "playerlist";
servervehiclesarray = [];
publicVariable "servervehiclesarray";
remotebombsarray = [];
publicVariable "remotebombsarray";
remotebombsdata = [];
publicVariable "remotebombsdata";
maxinsafe = 600000;
publicVariable "maxinsafe";
bank_safe_array = [bank_safe_1,bank_safe_2,bank_safe_3];
publicVariable "bank_safe_array";
robpoolsafe1 		 = 0; 
robpoolsafe2 		 = 0;
robpoolsafe3 		 = 0;
publicvariable "robpoolsafe1";
publicvariable "robpoolsafe2";
publicvariable "robpoolsafe3";
[] spawn {
	
	while{true} do
	{
	if(robpoolsafe1 < maxinsafe)then{robpoolsafe1 = robpoolsafe1 + round random 1000; publicvariable "robpoolsafe1"};
	if(robpoolsafe2 < maxinsafe)then{robpoolsafe2 = robpoolsafe2 + round random 1000; publicvariable "robpoolsafe2"};
	if(robpoolsafe3 < maxinsafe)then{robpoolsafe3 = robpoolsafe3 + round random 1000; publicvariable "robpoolsafe3"};
	sleep 30;
	};
};
vehicle_colors = [
	["ivory_190e",[
			
			["Красный",["#(rgb,8,8,3)color(0.5,0,0,1)"],1000,"true"],
			["Белый",["#(rgb,8,8,3)color(0.5,0.5,0.5,1)"],1000,"true"],
			["Серый",["#(rgb,8,8,3)color(0.25,0.25,0.25,1)"],1000,"true"],
			["Синий",["#(rgb,8,8,3)color(0,0,0.5,1)"],1000,"true"],
			["Жёлтый",["#(rgb,8,8,3)color(0.5,0.5,0,1)"],1000,"true"],
			["Зелёный",["#(rgb,8,8,3)color(0,0.5,0,1)"],1000,"true"],
			["Чёрный",["#(rgb,8,8,3)color(0,0,0,1)"],1000,"true"]
			
		]
	],
	
	["RDS_Octavia_Civ_01",[
			
			["Чёрный",["\rds_a2port_civ\Octavia\Data\car_body_black_co.paa","\rds_a2port_civ\Octavia\Data\car_body_m_black_co.paa"],1000,"true"],
			["Синий",["\rds_a2port_civ\Octavia\Data\car_body_blue_co.paa","\rds_a2port_civ\Octavia\Data\car_body_m_blue_co.paa"],1000,"true"],
			["Белый",["\rds_a2port_civ\Octavia\Data\car_body_co.paa","\rds_a2port_civ\Octavia\Data\car_body_m_co.paa"],1000,"true"],
			["Жёлтый",["\rds_a2port_civ\Octavia\Data\car_body_yellow_co.paa","\rds_a2port_civ\Octavia\Data\car_body_m_yellow_co.paa"],1000,"true"]
			
		]
	],
	
	["RDS_S1203_Civ_01",[
			
			["Зелёный",["rds_a2port_civ\S1203\data\s1203_green_co.paa","rds_a2port_civ\S1203\data\s1203_glass_ca.paa"],1000,"true"],
			["Оранжевый",["rds_a2port_civ\S1203\data\s1203_orange_co.paa","rds_a2port_civ\S1203\data\s1203_glass_ca.paa"],1000,"true"],
			["Красный",["rds_a2port_civ\S1203\data\s1203_red_co.paa","rds_a2port_civ\S1203\data\s1203_glass_ca.paa"],1000,"true"],
			["Серебряный",["rds_a2port_civ\S1203\data\s1203_silver_co.paa","rds_a2port_civ\S1203\data\s1203_glass_ca.paa"],1000,"true"],
			["Синий",["rds_a2port_civ\S1203\data\s1203_co.paa","rds_a2port_civ\S1203\data\s1203_glass_ca.paa"],1000,"true"],
			["Белый",["rds_a2port_civ\S1203\data\s1203_white_co.paa","rds_a2port_civ\S1203\data\s1203_glass_ca.paa"],1000,"true"]
			
		]
	],
	
	["RDS_Golf4_Civ_01",[
			
			["Чёрный",["\rds_a2port_civ\VWGOLF\Data\vwgolf_body_black_co.paa"],1000,"true"],
			["Синий",["\rds_a2port_civ\VWGOLF\Data\vwgolf_body_blue_co.paa"],1000,"true"],
			["Красный",["\rds_a2port_civ\VWGOLF\Data\vwgolf_body_co.paa"],1000,"true"],
			["Белый",["\rds_a2port_civ\VWGOLF\Data\vwgolf_body_white_co.paa"],1000,"true"],
			["Жёлтый",["\rds_a2port_civ\VWGOLF\Data\vwgolf_body_yellow_co.paa"],1000,"true"]
			
		]
	],
	["RDS_Gaz24_Civ_03",[
			
			["Чёрный",["\rds_a2port_civ\volha\Data\Volha_Black_ECIV_CO.paa"],1000,"true"],
			["Голубой",["\rds_a2port_civ\volha\Data\Volha_ECIV_CO.paa"],1000,"true"],
			["Серый",["\rds_a2port_civ\volha\Data\Volha_Gray_ECIV_CO.paa"],1000,"true"]
			
		]
	],
	
	["C_SUV_01_F",[
			
			["Чёрный",["\A3\Soft_F_Gamma\SUV_01\Data\SUV_01_ext_02_CO.paa"],1000,"true"],
			["Серый",["\A3\Soft_F_Gamma\SUV_01\Data\SUV_01_ext_03_CO.paa"],1000,"true"],
			["Оранжевый",["\A3\Soft_F_Gamma\SUV_01\Data\SUV_01_ext_04_CO.paa"],1000,"true"],
			["Красный",["\A3\Soft_F_Gamma\SUV_01\Data\SUV_01_ext_CO.paa"],1000,"true"]
			
		]
	],
	["Jonzie_Corolla",[
			
			["Красный",["#(rgb,8,8,3)color(0.5,0,0,1)"],1000,"true"],
			["Белый",["#(rgb,8,8,3)color(0.5,0.5,0.5,1)"],1000,"true"],
			["Серый",["#(rgb,8,8,3)color(0.25,0.25,0.25,1)"],1000,"true"],
			["Синий",["#(rgb,8,8,3)color(0,0,0.5,1)"],1000,"true"],
			["Жёлтый",["#(rgb,8,8,3)color(0.5,0.5,0,1)"],1000,"true"],
			["Зелёный",["#(rgb,8,8,3)color(0,0.5,0,1)"],1000,"true"],
			["Чёрный",["#(rgb,8,8,3)color(0,0,0,1)"],1000,"true"]
			
		]
	],
	["quiet_sub2015_noir_f",[
			
			["Красный",["#(rgb,8,8,3)color(0.5,0,0,1)"],1000,"true"],
			["Белый",["#(rgb,8,8,3)color(0.5,0.5,0.5,1)"],1000,"true"],
			["Серый",["#(rgb,8,8,3)color(0.25,0.25,0.25,1)"],1000,"true"],
			["Синий",["#(rgb,8,8,3)color(0,0,0.5,1)"],1000,"true"],
			["Жёлтый",["#(rgb,8,8,3)color(0.5,0.5,0,1)"],1000,"true"],
			["Зелёный",["#(rgb,8,8,3)color(0,0.5,0,1)"],1000,"true"],
			["Чёрный",["#(rgb,8,8,3)color(0,0,0,1)"],1000,"true"]
			
		]
	],
	["ivory_gt500",[
			
			["Красный",["#(rgb,8,8,3)color(0.5,0,0,1)"],1000,"true"],
			["Белый",["#(rgb,8,8,3)color(0.5,0.5,0.5,1)"],1000,"true"],
			["Серый",["#(rgb,8,8,3)color(0.25,0.25,0.25,1)"],1000,"true"],
			["Синий",["#(rgb,8,8,3)color(0,0,0.5,1)"],1000,"true"],
			["Жёлтый",["#(rgb,8,8,3)color(0.5,0.5,0,1)"],1000,"true"],
			["Зелёный",["#(rgb,8,8,3)color(0,0.5,0,1)"],1000,"true"],
			["Чёрный",["#(rgb,8,8,3)color(0,0,0,1)"],1000,"true"]
			
		]
	],
	["Quiet_c65amg_noir_f",[
			
			["Красный",["#(rgb,8,8,3)color(0.5,0,0,1)"],1000,"true"],
			["Белый",["#(rgb,8,8,3)color(0.5,0.5,0.5,1)"],1000,"true"],
			["Серый",["#(rgb,8,8,3)color(0.25,0.25,0.25,1)"],1000,"true"],
			["Синий",["#(rgb,8,8,3)color(0,0,0.5,1)"],1000,"true"],
			["Жёлтый",["#(rgb,8,8,3)color(0.5,0.5,0,1)"],1000,"true"],
			["Зелёный",["#(rgb,8,8,3)color(0,0.5,0,1)"],1000,"true"],
			["Чёрный",["#(rgb,8,8,3)color(0,0,0,1)"],1000,"true"]
			
		]
	],
	/*["LandRover_TK_CIV_EP1",[
			
			["Красный",["#(rgb,8,8,3)color(0.5,0,0,1)"],1000,"true"],
			["Белый",["#(rgb,8,8,3)color(0.5,0.5,0.5,1)"],1000,"true"],
			["Серый",["#(rgb,8,8,3)color(0.25,0.25,0.25,1)"],1000,"true"],
			["Синий",["#(rgb,8,8,3)color(0,0,0.5,1)"],1000,"true"],
			["Жёлтый",["#(rgb,8,8,3)color(0.5,0.5,0,1)"],1000,"true"],
			["Зелёный",["#(rgb,8,8,3)color(0,0.5,0,1)"],1000,"true"],
			["Чёрный",["#(rgb,8,8,3)color(0,0,0,1)"],1000,"true"]
			
		]
	],*/
	["Jonzie_Ceed",[
			
			["Красный",["#(rgb,8,8,3)color(0.5,0,0,1)"],1000,"true"],
			["Белый",["#(rgb,8,8,3)color(0.5,0.5,0.5,1)"],1000,"true"],
			["Серый",["#(rgb,8,8,3)color(0.25,0.25,0.25,1)"],1000,"true"],
			["Синий",["#(rgb,8,8,3)color(0,0,0.5,1)"],1000,"true"],
			["Жёлтый",["#(rgb,8,8,3)color(0.5,0.5,0,1)"],1000,"true"],
			["Зелёный",["#(rgb,8,8,3)color(0,0.5,0,1)"],1000,"true"],
			["Чёрный",["#(rgb,8,8,3)color(0,0,0,1)"],1000,"true"]
			
		]
	],
	["Jonzie_Transit",[
			
			["Красный",["#(rgb,8,8,3)color(0.5,0,0,1)"],1000,"true"],
			["Белый",["#(rgb,8,8,3)color(0.5,0.5,0.5,1)"],1000,"true"],
			["Серый",["#(rgb,8,8,3)color(0.25,0.25,0.25,1)"],1000,"true"],
			["Синий",["#(rgb,8,8,3)color(0,0,0.5,1)"],1000,"true"],
			["Жёлтый",["#(rgb,8,8,3)color(0.5,0.5,0,1)"],1000,"true"],
			["Зелёный",["#(rgb,8,8,3)color(0,0.5,0,1)"],1000,"true"],
			["Чёрный",["#(rgb,8,8,3)color(0,0,0,1)"],1000,"true"]
			
		]
	],
	["Jonzie_XB",[
			
			["Красный",["#(rgb,8,8,3)color(0.5,0,0,1)"],1000,"true"],
			["Белый",["#(rgb,8,8,3)color(0.5,0.5,0.5,1)"],1000,"true"],
			["Серый",["#(rgb,8,8,3)color(0.25,0.25,0.25,1)"],1000,"true"],
			["Синий",["#(rgb,8,8,3)color(0,0,0.5,1)"],1000,"true"],
			["Жёлтый",["#(rgb,8,8,3)color(0.5,0.5,0,1)"],1000,"true"],
			["Зелёный",["#(rgb,8,8,3)color(0,0.5,0,1)"],1000,"true"],
			["Чёрный",["#(rgb,8,8,3)color(0,0,0,1)"],1000,"true"]
			
		]
	],
	["Jonzie_Datsun_510",[
			
			["Красный",["#(rgb,8,8,3)color(0.5,0,0,1)"],1000,"true"],
			["Белый",["#(rgb,8,8,3)color(0.5,0.5,0.5,1)"],1000,"true"],
			["Серый",["#(rgb,8,8,3)color(0.25,0.25,0.25,1)"],1000,"true"],
			["Синий",["#(rgb,8,8,3)color(0,0,0.5,1)"],1000,"true"],
			["Жёлтый",["#(rgb,8,8,3)color(0.5,0.5,0,1)"],1000,"true"],
			["Зелёный",["#(rgb,8,8,3)color(0,0.5,0,1)"],1000,"true"],
			["Чёрный",["#(rgb,8,8,3)color(0,0,0,1)"],1000,"true"]
			
		]
	],
	["ivory_e36",[
			
			["Красный",["#(rgb,8,8,3)color(0.5,0,0,1)"],1000,"true"],
			["Белый",["#(rgb,8,8,3)color(0.5,0.5,0.5,1)"],1000,"true"],
			["Серый",["#(rgb,8,8,3)color(0.25,0.25,0.25,1)"],1000,"true"],
			["Синий",["#(rgb,8,8,3)color(0,0,0.5,1)"],1000,"true"],
			["Жёлтый",["#(rgb,8,8,3)color(0.5,0.5,0,1)"],1000,"true"],
			["Зелёный",["#(rgb,8,8,3)color(0,0.5,0,1)"],1000,"true"],
			["Чёрный",["#(rgb,8,8,3)color(0,0,0,1)"],1000,"true"]
			
		]
	],
	["ivory_m3",[
			
			["Красный",["#(rgb,8,8,3)color(0.5,0,0,1)"],1000,"true"],
			["Белый",["#(rgb,8,8,3)color(0.5,0.5,0.5,1)"],1000,"true"],
			["Серый",["#(rgb,8,8,3)color(0.25,0.25,0.25,1)"],1000,"true"],
			["Синий",["#(rgb,8,8,3)color(0,0,0.5,1)"],1000,"true"],
			["Жёлтый",["#(rgb,8,8,3)color(0.5,0.5,0,1)"],1000,"true"],
			["Зелёный",["#(rgb,8,8,3)color(0,0.5,0,1)"],1000,"true"],
			["Чёрный",["#(rgb,8,8,3)color(0,0,0,1)"],1000,"true"]
			
		]
	],
	["Jonzie_30CSL",[
			
			["Красный",["#(rgb,8,8,3)color(0.5,0,0,1)"],1000,"true"],
			["Белый",["#(rgb,8,8,3)color(0.5,0.5,0.5,1)"],1000,"true"],
			["Серый",["#(rgb,8,8,3)color(0.25,0.25,0.25,1)"],1000,"true"],
			["Синий",["#(rgb,8,8,3)color(0,0,0.5,1)"],1000,"true"],
			["Жёлтый",["#(rgb,8,8,3)color(0.5,0.5,0,1)"],1000,"true"],
			["Зелёный",["#(rgb,8,8,3)color(0,0.5,0,1)"],1000,"true"],
			["Чёрный",["#(rgb,8,8,3)color(0,0,0,1)"],1000,"true"]
			
		]
	],
	["ivory_c",[
			
			["Красный",["#(rgb,8,8,3)color(0.5,0,0,1)"],1000,"true"],
			["Белый",["#(rgb,8,8,3)color(0.5,0.5,0.5,1)"],1000,"true"],
			["Серый",["#(rgb,8,8,3)color(0.25,0.25,0.25,1)"],1000,"true"],
			["Синий",["#(rgb,8,8,3)color(0,0,0.5,1)"],1000,"true"],
			["Жёлтый",["#(rgb,8,8,3)color(0.5,0.5,0,1)"],1000,"true"],
			["Зелёный",["#(rgb,8,8,3)color(0,0.5,0,1)"],1000,"true"],
			["Чёрный",["#(rgb,8,8,3)color(0,0,0,1)"],1000,"true"]
			
		]
	],
	["ivory_rs4",[
			
			["Красный",["#(rgb,8,8,3)color(0.5,0,0,1)"],1000,"true"],
			["Белый",["#(rgb,8,8,3)color(0.5,0.5,0.5,1)"],1000,"true"],
			["Серый",["#(rgb,8,8,3)color(0.25,0.25,0.25,1)"],1000,"true"],
			["Синий",["#(rgb,8,8,3)color(0,0,0.5,1)"],1000,"true"],
			["Жёлтый",["#(rgb,8,8,3)color(0.5,0.5,0,1)"],1000,"true"],
			["Зелёный",["#(rgb,8,8,3)color(0,0.5,0,1)"],1000,"true"],
			["Чёрный",["#(rgb,8,8,3)color(0,0,0,1)"],1000,"true"]
			
		]
	],
	["IVORY_R8",[
			
			["Красный",["#(rgb,8,8,3)color(0.5,0,0,1)"],1000,"true"],
			["Белый",["#(rgb,8,8,3)color(0.5,0.5,0.5,1)"],1000,"true"],
			["Серый",["#(rgb,8,8,3)color(0.25,0.25,0.25,1)"],1000,"true"],
			["Синий",["#(rgb,8,8,3)color(0,0,0.5,1)"],1000,"true"],
			["Жёлтый",["#(rgb,8,8,3)color(0.5,0.5,0,1)"],1000,"true"],
			["Зелёный",["#(rgb,8,8,3)color(0,0.5,0,1)"],1000,"true"],
			["Чёрный",["#(rgb,8,8,3)color(0,0,0,1)"],1000,"true"]
			
		]
	],
	
	["RDS_Lada_Civ_01",[
			
			["Зелёный",["rds_a2port_civ\Lada\Data\lada_eciv1_co.paa","rds_a2port_civ\Lada\Data\Lada_glass_ECIV1_CA.paa"],1000,"true"],
			["Красный",["rds_a2port_civ\Lada\Data\lada_red_co.paa","rds_a2port_civ\Lada\Data\lada_glass_ca.paa"],1000,"true"],
			["Лада Джихада",["rds_a2port_civ\Lada\Data\lada_eciv2_co.paa","rds_a2port_civ\Lada\Data\Lada_glass_ECIV2_CA.paa"],1000,"true"],
			["Белый",["rds_a2port_civ\Lada\Data\lada_white_co.paa","rds_a2port_civ\Lada\Data\lada_glass_ca.paa"],1000,"true"]
			
		]
	],
	["Jonzie_Raptor",[
			
			["Красный",["#(rgb,8,8,3)color(0.5,0,0,1)"],1000,"true"],
			["Белый",["#(rgb,8,8,3)color(0.5,0.5,0.5,1)"],1000,"true"],
			["Серый",["#(rgb,8,8,3)color(0.25,0.25,0.25,1)"],1000,"true"],
			["Синий",["#(rgb,8,8,3)color(0,0,0.5,1)"],1000,"true"],
			["Жёлтый",["#(rgb,8,8,3)color(0.5,0.5,0,1)"],1000,"true"],
			["Зелёный",["#(rgb,8,8,3)color(0,0.5,0,1)"],1000,"true"],
			["Чёрный",["#(rgb,8,8,3)color(0,0,0,1)"],1000,"true"]
			
		]
	],
	["CUP_C_Skoda_White_CIV",[
			
			["Дряхлый",["\CUP\WheeledVehicles\CUP_WheeledVehicles_Skoda\data\skodovka_modra_co.paa","\CUP\WheeledVehicles\CUP_WheeledVehicles_Skoda\data\skodovka_int_co.paa"],1000,"true"],
			["Зелёный",["\CUP\WheeledVehicles\CUP_WheeledVehicles_Skoda\data\skodovka_zelena_co.paa","\CUP\WheeledVehicles\CUP_WheeledVehicles_Skoda\data\skodovka_int_co.paa"],4000,"true"],
			["Красный",["\CUP\WheeledVehicles\CUP_WheeledVehicles_Skoda\data\skodovka_cervena_co.paa","\CUP\WheeledVehicles\CUP_WheeledVehicles_Skoda\data\skodovka_int_co.paa"],4000,"true"],
			["Белый",["\CUP\WheeledVehicles\CUP_WheeledVehicles_Skoda\data\skodovka_bila_co.paa","\CUP\WheeledVehicles\CUP_WheeledVehicles_Skoda\data\skodovka_int_co.paa"],4000,"true"]
			
		]
	],
	["C_Hatchback_01_F",[
			
			["Бежевый",["\A3\Soft_F_Gamma\Hatchback_01\data\Hatchback_01_ext_BASE01_CO.paa"],4000,"true"],
			["Бежевый с рисунком",["\A3\Soft_F_Gamma\Hatchback_01\data\Hatchback_01_ext_BASE05_CO.paa"],4000,"true"],
			["Чёрный",["\A3\Soft_F_Gamma\Hatchback_01\data\Hatchback_01_ext_BASE08_CO.paa"],4000,"true"],
			["Синий",["\A3\Soft_F_Gamma\Hatchback_01\data\Hatchback_01_ext_BASE03_CO.paa"],4000,"true"],
			["Синий с рисунком",["\A3\Soft_F_Gamma\Hatchback_01\data\Hatchback_01_ext_BASE04_CO.paa"],4000,"true"],
			["Тёмный",["\A3\Soft_F_Gamma\Hatchback_01\data\Hatchback_01_ext_BASE09_CO.paa"],4000,"true"],
			["Зелёный",["\A3\Soft_F_Gamma\Hatchback_01\data\Hatchback_01_ext_BASE02_CO.paa"],4000,"true"],
			["Серый",["\A3\Soft_F_Gamma\Hatchback_01\data\Hatchback_01_ext_BASE07_CO.paa"],4000,"true"],
			["Жёлтый",["\A3\Soft_F_Gamma\Hatchback_01\data\Hatchback_01_ext_BASE06_CO.paa"],4000,"true"]
			
		]
	],
	["CUP_C_Volha_Limo_TKCIV",[
			
			["Серый",["\cup\wheeledvehicles\cup_wheeledvehicles_volha\data\Volha_Gray_ECIV_CO.paa"],4000,"true"],
			["Синий",["\cup\wheeledvehicles\cup_wheeledvehicles_volha\data\Volha_ECIV_CO.paa"],4000,"true"],
			["Чёрный",["\cup\wheeledvehicles\cup_wheeledvehicles_volha\data\Volha_black_ECIV_CO.paa"],4000,"true"]
			
		]
	],
	["C_Truck_02_covered_F",[
			
			["Синий",["\a3\soft_f_beta\Truck_02\data\truck_02_kab_blue_co.paa","\a3\soft_f_beta\Truck_02\data\truck_02_kuz_co.paa","\a3\soft_f_beta\truck_02\data\truck_02_int_co.paa"],10000,"true"],
			["Синий и оливковый",["\a3\soft_f_beta\Truck_02\data\truck_02_kab_blue_co.paa","\a3\soft_f_beta\Truck_02\data\truck_02_kuz_olive_co.paa","\a3\soft_f_beta\truck_02\data\truck_02_int_co.paa"],10000,"true"],
			["Оранжевый и синий",["\a3\soft_f_beta\Truck_02\data\truck_02_kab_co.paa","\a3\soft_f_beta\Truck_02\data\truck_02_kuz_co.paa","\a3\soft_f_beta\truck_02\data\truck_02_int_co.paa"],10000,"true"],
			["Оранжевый и оливковый",["\a3\soft_f_beta\Truck_02\data\truck_02_kab_co.paa","\a3\soft_f_beta\Truck_02\data\truck_02_kuz_olive_co.paa","\a3\soft_f_beta\truck_02\data\truck_02_int_co.paa"],10000,"true"]
			
		]
	],
	["C_Truck_02_transport_F",[
			
			["Синий",["\a3\soft_f_beta\Truck_02\data\truck_02_kab_blue_CO.paa","\a3\soft_f_beta\Truck_02\data\truck_02_kuz_co.paa","\a3\soft_f_beta\truck_02\data\truck_02_int_co.paa"],10000,"true"],
			["Оранжевый",["\a3\soft_f_beta\Truck_02\data\truck_02_kab_co.paa","\a3\soft_f_beta\Truck_02\data\truck_02_kuz_co.paa","\a3\soft_f_beta\truck_02\data\truck_02_int_co.paa"],10000,"true"]
			
		]
	],
	["CUP_O_Ural_RU",[
			
			["Синий",["CUP\WheeledVehicles\CUP_WheeledVehicles_Ural\data\ural_kabina_civil_co.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_Ural\data\ural_plachta_civil_co.paa"],10000,"true"],
			["Жёлтый",["CUP\WheeledVehicles\CUP_WheeledVehicles_Ural\data\ural_kabina_civ1_co.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_Ural\data\ural_plachta_civ1_co.paa"],10000,"true"],
			["КРАВЧЕНКО",["CUP\WheeledVehicles\CUP_WheeledVehicles_Ural\data\ural_kabina_civ2_co.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_Ural\data\Ural_plachta_civil_co.paa"],10000,"true"],
			["Зелёный",["CUP\WheeledVehicles\CUP_WheeledVehicles_Ural\data\ural_kabina_khk_co.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_Ural\data\ural_plachta_co.paa"],10000,"true"]
			
		]
	],
	["CUP_C_SUV_TK",[
			
			["Чёрный",["\CUP\WheeledVehicles\CUP_WheeledVehicles_SUV\data\suv_body_co.paa"],6000,"true"],
			["Синий и белый",["\CUP\WheeledVehicles\CUP_WheeledVehicles_SUV\data\suv_body_bluewhite_co.paa"],6000,"true"]
			
		]
	],
	["CUP_C_Octavia_CIV",[
			
			["Чёрный",["\cup\wheeledvehicles\cup_wheeledvehicles_octavia\data\car_body_black_co.paa"],4000,"true"],
			["Синий",["\cup\wheeledvehicles\cup_wheeledvehicles_octavia\data\car_body_blue_co.paa"],4000,"true"],
			["Зелёный",["\cup\wheeledvehicles\cup_wheeledvehicles_octavia\data\car_body_green_co.paa"],4000,"true"],
			["Оранжевый",["\cup\wheeledvehicles\cup_wheeledvehicles_octavia\data\car_body_orange_co.paa"],4000,"true"],
			["Пурпурный",["\cup\wheeledvehicles\cup_wheeledvehicles_octavia\data\car_body_purple_co.paa"],4000,"true"],
			["Красный",["\cup\wheeledvehicles\cup_wheeledvehicles_octavia\data\car_body_red_co.paa"],4000,"true"],
			["Белый",["\cup\wheeledvehicles\cup_wheeledvehicles_octavia\data\car_body_co.paa"],4000,"true"],
			["Жёлтый",["\cup\wheeledvehicles\cup_wheeledvehicles_octavia\data\car_body_yellow_co.paa"],4000,"true"]
			
		]
	],
	["C_Quadbike_01_F",[
			
			["Чёрный",["\A3\Soft_F_Beta\Quadbike_01\Data\Quadbike_01_CIV_BLACK_CO.paa","\A3\Soft_F_Beta\Quadbike_01\Data\Quadbike_01_wheel_CIVBLACK_CO.paa"],3000,"true"],
			["Синий",["\A3\Soft_F_Beta\Quadbike_01\Data\Quadbike_01_CIV_BLUE_CO.paa","\A3\Soft_F_Beta\Quadbike_01\Data\Quadbike_01_wheel_CIVBLUE_CO.paa"],3000,"true"],
			["Зелёный",["\A3\Soft_F\Quadbike_01\Data\Quadbike_01_co.paa","\A3\Soft_F\Quadbike_01\Data\Quadbike_01_wheel_co.paa"],3000,"true"],
			["Красный",["\A3\Soft_F_Beta\Quadbike_01\Data\Quadbike_01_CIV_RED_CO.paa","\A3\Soft_F_Beta\Quadbike_01\Data\Quadbike_01_wheel_CIVRED_CO.paa"],3000,"true"],
			["Белый",["\A3\Soft_F_Beta\Quadbike_01\Data\Quadbike_01_CIV_WHITE_CO.paa","\A3\Soft_F_Beta\Quadbike_01\Data\Quadbike_01_wheel_CIVWHITE_CO.paa"],3000,"true"]
			
		]
	],
	["CUP_C_V3S_Covered_TKC",[
			
			["Зелёный",["CUP\WheeledVehicles\CUP_WheeledVehicles_v3s\Data\v3s_kabpar_egue_co","CUP\WheeledVehicles\CUP_WheeledVehicles_v3s\Data\v3s_intkor_egue_co","CUP\WheeledVehicles\CUP_WheeledVehicles_v3s\Data\v3s_koloint02_egue_co","CUP\WheeledVehicles\CUP_WheeledVehicles_v3s\Data\v3s_reammo_egue_co"],10000,"true"],
			["Жёлтый",["CUP\WheeledVehicles\CUP_WheeledVehicles_v3s\Data\v3s_kabpar_eciv_co","CUP\WheeledVehicles\CUP_WheeledVehicles_v3s\Data\v3s_intkor_eciv_co","CUP\WheeledVehicles\CUP_WheeledVehicles_v3s\Data\v3s_koloint02_eciv_co","CUP\WheeledVehicles\CUP_WheeledVehicles_v3s\Data\v3s_reammo_egue_co"],10000,"true"]
			
		]
	],
	["CUP_V3S_Open_NAPA",[
			
			["Зелёный",["CUP\WheeledVehicles\CUP_WheeledVehicles_v3s\Data\v3s_kabpar_co","CUP\WheeledVehicles\CUP_WheeledVehicles_v3s\Data\v3s_intkor_co","CUP\WheeledVehicles\CUP_WheeledVehicles_v3s\Data\v3s_koloint02_co"],10000,"true"],
			["Жёлтый",["CUP\WheeledVehicles\CUP_WheeledVehicles_v3s\Data\v3s_kabpar_eciv_co","CUP\WheeledVehicles\CUP_WheeledVehicles_v3s\Data\v3s_intkor_eciv_co","CUP\WheeledVehicles\CUP_WheeledVehicles_v3s\Data\v3s_koloint02_eciv_co"],10000,"true"]
			
		]
	],
	["CUP_B_LR_Transport_GB_D",[
			
			["Красный",["cup\wheeledvehicles\cup_wheeledvehicles_lr\data\textures\civ_r_lr_base_co.paa","cup\wheeledvehicles\cup_wheeledvehicles_lr\data\textures\civ_r_lr_special_co.paa"],5000,"true"],
			["Пустынный",["cup\wheeledvehicles\cup_wheeledvehicles_lr\data\textures\gb_d_lr_base_co.paa","cup\wheeledvehicles\cup_wheeledvehicles_lr\data\textures\gb_d_lr_special_co.paa"],5000,"true"]
			
		]
	],
	["CUP_C_Lada_White_CIV",[
			
			["Красный",["\cup\wheeledvehicles\cup_wheeledvehicles_lada\data\lada_red_co.paa","\cup\wheeledvehicles\cup_wheeledvehicles_lada\data\lada_glass_ca.paa"],3000,"true"],
			["Зелёный",["\cup\wheeledvehicles\cup_wheeledvehicles_lada\data\lada_eciv1_co.paa","\cup\wheeledvehicles\cup_wheeledvehicles_lada\data\lada_glass_ca.paa"],3000,"true"],
			["Лада Джихада",["\cup\wheeledvehicles\cup_wheeledvehicles_lada\data\lada_eciv2_co.paa","\cup\wheeledvehicles\cup_wheeledvehicles_lada\data\lada_glass_ca.paa"],3000,"true"],
			["Белый",["\cup\wheeledvehicles\cup_wheeledvehicles_lada\data\lada_white_co.paa","\cup\wheeledvehicles\cup_wheeledvehicles_lada\data\lada_glass_ca.paa"],3000,"true"]
			
		]
	],
	["CUP_C_Ikarus_Chernarus",[
			
			["Вариант 1",["CUP\WheeledVehicles\CUP_WheeledVehicles_Ikarus\Data\bus_exterior_co.paa"],10000,"true"],
			["Вариант 2",["CUP\WheeledVehicles\CUP_WheeledVehicles_Ikarus\Data\bus_exterior_acr_co.paa"],10000,"true"]
			
		]
	],
	["CUP_B_HMMWV_Unarmed_NATO_T",[
			
			["Пустынный",["\CUP\WheeledVehicles\CUP_WheeledVehicles_HMMWV\data\hmmwv_body_us_co.paa"],5000,"true"],
			["Зелёный",["\CUP\WheeledVehicles\CUP_WheeledVehicles_HMMWV\data\textures\nato_t_hmmwv_body_co.paa"],5000,"true"]
			
		]
	],
	
	["C_Van_01_box_F",[
			
			["Чёрный",["\A3\soft_f_gamma\van_01\Data\Van_01_ext_black_CO.paa","\A3\soft_f_gamma\van_01\Data\van_01_adds_CO.paa"],8000,"true"],
			["Красный",["\A3\soft_f_gamma\van_01\Data\Van_01_ext_red_CO.paa","\A3\soft_f_gamma\van_01\Data\van_01_adds_CO.paa"],8000,"true"],
			["Белый",["\A3\soft_f_gamma\van_01\Data\van_01_ext_CO.paa","\A3\soft_f_gamma\van_01\Data\van_01_adds_CO.paa"],8000,"true"]
			
		]
	],
	["C_Van_01_transport_F",[
			
			["Чёрный",["\A3\soft_f_gamma\van_01\Data\Van_01_ext_black_CO.paa","\A3\soft_f_gamma\van_01\Data\van_01_adds_CO.paa","\a3\soft_f_gamma\van_01\data\van_01_int_base_co.paa"],8000,"true"],
			["Коричневый",["\A3\Soft_F_Exp\Van_01\Data\Van_01_ext_brn_co.paa","\A3\soft_f_gamma\van_01\Data\van_01_adds_CO.paa","\A3\Soft_F_Exp\Van_01\Data\Van_01_int_base_2_CO.paa"],8000,"true"],
			["Красный",["\A3\soft_f_gamma\van_01\Data\Van_01_ext_red_CO.paa","\A3\soft_f_gamma\van_01\Data\van_01_adds_CO.paa","\a3\soft_f_gamma\van_01\data\van_01_int_base_co.paa"],8000,"true"],
			["Олива",["\A3\Soft_F_Exp\Van_01\Data\Van_01_ext_oli_co.paa","\A3\soft_f_gamma\van_01\Data\van_01_adds_CO.paa","\A3\Soft_F_Exp\Van_01\Data\Van_01_int_base_3_CO.paa"],8000,"true"],
			["Белый",["\A3\soft_f_gamma\van_01\Data\van_01_ext_CO.paa","\A3\soft_f_gamma\van_01\Data\van_01_adds_CO.paa","\a3\soft_f_gamma\van_01\data\van_01_int_base_co.paa"],8000,"true"]
			
		]
	],
	["C_Van_01_fuel_F",[
			
			["Чёрный",["\A3\soft_f_gamma\van_01\Data\Van_01_ext_black_CO.paa","\A3\soft_f_gamma\Van_01\Data\Van_01_tank_CO.paa"],8000,"true"],
			["Чёрный (красная цистерна)",["\A3\soft_f_gamma\van_01\Data\Van_01_ext_black_CO.paa","\A3\soft_f_gamma\Van_01\Data\Van_01_tank_red_CO.paa"],8000,"true"],
			["Красный",["\A3\soft_f_gamma\van_01\Data\Van_01_ext_red_CO.paa","\A3\soft_f_gamma\Van_01\Data\Van_01_tank_CO.paa"],8000,"true"],
			["Красный (красная цистерна)",["\A3\soft_f_gamma\van_01\Data\Van_01_ext_red_CO.paa","\A3\soft_f_gamma\Van_01\Data\Van_01_tank_red_CO.paa"],8000,"true"],
			["Белый",["\A3\soft_f_gamma\van_01\Data\van_01_ext_CO.paa","\A3\soft_f_gamma\Van_01\Data\Van_01_tank_CO.paa"],8000,"true"],
			["Белый (красная цистерна)",["\A3\soft_f_gamma\van_01\Data\van_01_ext_CO.paa","\A3\soft_f_gamma\Van_01\Data\Van_01_tank_red_CO.paa"],8000,"true"]
			
		]
	],
	["CUP_C_Datsun",[
			
			["Серо-голубой",["CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_trup2_civ_CO.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_addons4_co.paa"],4000,"true"],
			["Голубой и красный",["CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_trup1_civ_CO.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_addons4_co.paa"],4000,"true"],
			["Песок",["CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_trup4_CO.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_addons4_co.paa"],4000,"true"],
			["Зелёный/бежевый пустынный с точками",["CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_trup3_eins_CO.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_addons4_co.paa"],4000,"true"],
			["Зелёный/бежевый лесной",["CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_trup1_CO.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_addons4_co.paa"],4000,"true"],
			["Зелёный/чёрный/бежевый пустынный с полосками",["CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_trup1_eins_CO.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_addons4_co.paa"],4000,"true"],
			["Зелёный/чёрный/бежевый пустынный с точками",["CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_trup2_eins_CO.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_addons4_co.paa"],4000,"true"],
			["Зелёный/коричневый/бежевый лесной",["CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_trup2_CO.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_addons4_co.paa"],4000,"true"],
			["ЧДКЗ лесной",["CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_trup3_CO.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_addons4_co.paa"],4000,"true"],
			["Жёлтый",["CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_trup4_civ_CO.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_addons4_co.paa"],4000,"true"]
			
		]
	],
	["CUP_C_Datsun",[
			
			["Серо-голубой",["CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_trup2_civ_CO.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_addons4_co.paa"],4000,"true"],
			["Голубой и красный",["CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_trup1_civ_CO.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_addons4_co.paa"],4000,"true"],
			["Песок",["CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_trup4_CO.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_addons4_co.paa"],4000,"true"],
			["Зелёный/бежевый пустынный с точками",["CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_trup3_eins_CO.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_addons4_co.paa"],4000,"true"],
			["Зелёный/бежевый лесной",["CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_trup1_CO.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_addons4_co.paa"],4000,"true"],
			["Зелёный/чёрный/бежевый пустынный с полосками",["CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_trup1_eins_CO.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_addons4_co.paa"],4000,"true"],
			["Зелёный/чёрный/бежевый пустынный с точками",["CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_trup2_eins_CO.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_addons4_co.paa"],4000,"true"],
			["Зелёный/коричневый/бежевый лесной",["CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_trup2_CO.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_addons4_co.paa"],4000,"true"],
			["ЧДКЗ лесной",["CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_trup3_CO.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_addons4_co.paa"],4000,"true"],
			["Жёлтый",["CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_trup4_civ_CO.paa","CUP\WheeledVehicles\CUP_WheeledVehicles_Datsun\Data\datsun_addons4_co.paa"],4000,"true"]
			
		]
	],
	["C_Offroad_01_F",[
			
			["Красный",["\A3\soft_F\Offroad_01\Data\offroad_01_ext_co.paa"],4000,"true"],
			["Жёлтый",["\A3\soft_F\Offroad_01\Data\offroad_01_ext_BASE01_CO.paa"],4000,"true"]
			
		]
	],
	["B_G_Offroad_01_armed_F",[
			
			["Красный",["\A3\soft_F\Offroad_01\Data\offroad_01_ext_co.paa"],4000,"true"],
			["Жёлтый",["\A3\soft_F\Offroad_01\Data\offroad_01_ext_BASE01_CO.paa"],4000,"true"]
			
		]
	],
	["CUP_C_Golf4_black_Civ",[
			
			["Чёрный",["\CUP\WheeledVehicles\CUP_WheeledVehicles_VWGolf\Data\vwgolf_body_black_CO.paa"],4000,"true"],
			["Синий",["\CUP\WheeledVehicles\CUP_WheeledVehicles_VWGolf\Data\vwgolf_body_blue_CO.paa"],4000,"true"],
			["Зелёный",["\CUP\WheeledVehicles\CUP_WheeledVehicles_VWGolf\Data\vwgolf_body_green_CO.paa"],4000,"true"],
			["Красный",["\CUP\WheeledVehicles\CUP_WheeledVehicles_VWGolf\Data\vwgolf_body_co.paa"],4000,"true"]
			
		]
	],
	["C_Truck_02_box_F",[
			
			["Синий и зелёный",["\a3\soft_f_beta\Truck_02\data\truck_02_kab_blue_co.paa","\a3\soft_f_beta\Truck_02\data\truck_02_repair_green_co.paa","\a3\soft_f_beta\truck_02\data\truck_02_int_co.paa"],10000,"true"],
			["Синий и оранжевый",["\a3\soft_f_beta\Truck_02\data\truck_02_kab_blue_co.paa","\a3\soft_f_beta\Truck_02\data\truck_02_repair_co.paa","\a3\soft_f_beta\truck_02\data\truck_02_int_co.paa"],10000,"true"],
			["Оранжевый и зелёный",["\a3\soft_f_beta\Truck_02\data\truck_02_kab_co.paa","\a3\soft_f_beta\Truck_02\data\truck_02_repair_green_co.paa","\a3\soft_f_beta\truck_02\data\truck_02_int_co.paa"],10000,"true"],
			["Оранжевый",["\a3\soft_f_beta\Truck_02\data\truck_02_kab_co.paa","\a3\soft_f_beta\Truck_02\data\truck_02_repair_co.paa","\a3\soft_f_beta\truck_02\data\truck_02_int_co.paa"],10000,"true"]
			
		]
	]
];
publicvariable "vehicle_colors";
vehicle_colors_classes = [];
{
	vehicle_colors_classes pushBack (_x select 0);
} foreach vehicle_colors;
publicvariable "vehicle_colors_classes";
pros_array = [
	["mechguy","прирождённый механик","Вы гораздо быстрее обучаетесь инженерному делу и взлому."],
	["expdriver","опытный водитель","Вы помните расположение всех камер и получаете уведомление при приближении к ним."],
	["hunter","прирождённый охотник","Вы получаете RPP за освежевание животного и получаете предупреждение при приближении секача."],
	["arestant","порядочный арестант","Вы получаете RPP отбывая наказание в тюрьме."],
	["shakhter","шахтёр","Вы меньше устаёте когда заняты добычей ресурсов."],
	["zavod","работяга","Вы меньше устаёте когда заняты работой на заводе."],
	["stronk","машина","Вы быстрее становитесь настоящей машиной."]
];
publicvariable "pros_array";
pros_array_classes = [];
{
	pros_array_classes pushBack (_x select 0);
} foreach pros_array;
publicvariable "pros_array_classes";
flaws_array = [
	//classname,name,desc
	["vegeterian","вегетерианец","Вы будете получать штраф к RPP при поедании мяса, если RPP у вас больше нуля, и некоторое время будете себя плохо чувствовать."],
	["pacifist","пацифист","После первого убийства некоторое время у вас будут подкашиваться ноги и трястись руки."],
	["waterafraid","боязнь воды","Вы боитесь приближаться к водоёмам."],
	["verun","ревностный верующий","Минимум раз в час вам нужно молиться в вашем храме, иначе вы начнёте терять RPP, если их больше нуля."]
];
_chernorussian_names = [
	"Иван","Дмитрий","Ян","Петр","Иржи","Йозеф","Павел","Ярослав","Мартин","Томаш","Франтишек","Зденек","Михаил","Карл","Милан","Лукаш","Якуб","Давид","Андрей","Марек",
	"Отакар","Собеслав","Филипп","Эдуард","Каджинек","Зденек","Ярослав","Карел","Кристоф","Павол","Леос","Радим","Патрик","Радко","Радомил","Любош","Радослав","Сик","Иржи",
	"Даниил","Войтех","Филипп","Адам","Матей","Доминик","Штепан","Матиас","Шимон","Ратибор","Матус","Марек","Милош","Ладвик","Ладислав","Никита","Вацлав"
];
_chernorussian_lastnames = [
	"Адамец","Адамек","Аксамит","Новак","Свобода","Новотны","Дворжак","Черны","Высочин","Поспишил","Голуб","Соукуп","Затолукал","Домин","Дивин","Данко","Добры","Барачник","Барак","Баран",
	"Баранек","Баркуш","Бартак","Бартек","Беднарик","Белинский","Бенак","Бенда","Бендик","Бенеш","Белан","Бернард","Биба","Блатник","Блажек","Бобак","Бобал","Бобек","Бочек","Бобик",
	"Бомба","Бонуш","Борак","Босак","Божик","Бродски","Броз","Брожек","Бубел","Бучек","Бухта","Буран","Бужек","Чех","Червены","Хапек","Харват","Хладек","Хмелик","Хован",
	"Четвертник","Дамиан","Данек","Давид","Дорн","Дорнак","Достал","Дубрава","Драбек","Дробны","Дрозд","Дуб","Дубин","Дубски","Дух","Дуда","Дудак","Дудек","Дудик","Дворачек",
	"Дворак","Дворский","Дымек","Ебен","Фабиан","Фаркас","Филип","Филипек","Форт","Габа","Габриш","Газда","Хаба","Хайбел","Хайек","Халек","Хан","Ханак","Ханек","Хавран",
	"Хавлик","Хлавац","Хлавин","Хрон","Хожа","Хомола","Хомжа","Хорник","Хорский","Хосподар","Храбе","Храбик","Хрубый","Хуба","Хубачек","Хусак","Хусар","Ягода","Якеш","Янак",
	"Яначек","Ян","Янек","Янеш","Янек","Янко","Еж","Индрих","Йонак","Йонаш","Юн","Храбик","Юрчик","Юриш","Каба","Кабат","Кабел","Кафка","Калал","Калина","Калиш","Камен","Кан",
	"Капуста","Карел","Кареш","Карлик","Кармазин","Каспар","Каспарек","Каспер","Кленк","Килька","Кох","Кохан","Колар","Коларик","Колба","Колиш","Кольский","Коминек","Коминский","Кондрат","Корба","Корн","Коруш",
	"Костельник","Коташ","Котек","Кот","Ковач","Коваль","Ковар","Кожа","Крам","Крамар","Красный","Краткий","Кремень","Крен","Крижек","Куба","Кубик","Кухар","Кулик","Лачек","Ланик","Лек","Лашек",
	"Лис","Лука","Лукаш","Лах","Мачек","Мах","Маховец","Мачик","Мадера","Маковский","Малак","Малик","Малинский","Марак","Маречек","Мареш","Мартин","Мартынак","Мартынец","Мартынек","Машек","Матейчек","Матоха",
	"Матушек","Мех","Мельчер","Мелин","Мелиш","Мичек","Михал","Михалец","Михалек","Микуш","Милаш","Милош","Мражек","Мразик","Навратил","Немчек","Немечек","Новачек","Новосад","Новы","Олейник","Ондерко","Ондрачек",
	"Орел","Орлик","Оршак","Отрадовец","Пачек","Пах","Пачовский","Палек","Панек","Папеш","Патак","Павек","Павличек","Пех","Пехачек","Пекар","Пекарек","Пешек","Петак","Петковшек","Петр","Петрак","Петранек",
	"Петраш","Петрашек","Петрик","Петрушка","Плачек","Плухарь","Побуда","Покорны","Полак","Поланский","Поточник","Потучек","Прашек","Пражак","Прихода","Привратский","Прокоп","Пушкарь","Пустеёвский","Рабаш","Рачек","Радек",
	"Резак","Режек","Резник","Резничек","Родак","Рокош","Рокушек","Рольник","Романек","Романик","Романский","Ровнак","Рожек","Русек","Ружек","Рыхлик","Рышавый","Сафранек","Самек","Себек","Себранек",
	"Шестак","Шрамек","Шевчик","Семрад","Семерад","Симак","Симанек","Симчик","Симар","Симечек","Симек","Широкий","Сиштек","Скляр","Скленар","Шкода","Скоп","Скриванек","Скубаль","Слабый","Сладкий",
	"Сланский","Славик","Слежак","Слобода","Словачек","Словак","Словенский","Сметак","Смышек","Смоляк","Смола","Смолик","Смуда","Соботка","Соболик","Сокол","Срамек","Староста","Странский","Стром","Ступка",
	"Сухомел","Сулак","Сулик","Светлик","Шипек","Табор","Татар","Теплый","Тихачек","Томанек","Томаш","Троян","Тучек","Тупый","Углик","Уличный","Урбанек","Урбаник","Урбановский","Вачек","Ваха",
	"Вачик","Вацлавик","Валашек","Ванечек","Ванек","Ваничек","Варга","Вашек","Вашичек","Ваврек","Веселый","Видмар","Витек","Влад","Власак","Влычек","Войтех","Волек","Волин","Волк","Вонашек",
	"Вондрачек","Вондрак","Вондрашек","Вопат","Ворек","Воришек","Ворлычек","Вотава","Вотруба","Врана","Верба","Выскочил","Едличка","Зачек","Захар","Заградка","Заградник","Заяц","Зайчек","Закрайшек","Заступил",
	"Заватский","Заводный","Зденек","Зеленак","Земан","Земанек","Зенишек","Зидек","Зикмунд","Жишка","Житник","Змолек","Зубек","Боров"
];
_russian_names = [
	"Иван","Дмитрий","Андрей","Адам","Алексей","Анатолий","Альберт","Артемий","Богдан","Борис","Борислав","Вадим","Валентин","Валерий","Василий","Виктор","Виталий","Влад","Владимир","Владислав","Всеволод",
	"Вячеслав","Гавриил","Георгий","Герасим","Герман","Григорий","Давид","Даниил","Денис","Дмитрий","Евгений","Ефим","Захар","Илья","Кирилл","Константин","Кузьма","Лев","Леонид","Максим",
	"Марк","Матвей","Михаил","Назар","Никита","Николай","Олег","Павел","Пётр","Роман","Руслан","Савва","Савелий","Святослав","Семён","Сергей","Степан","Тарас","Тимофей","Фёдор",
	"Фома","Юрий","Ярослав","Мстислав"
];
_russian_lastnames = [
	"Иванов","Смирнов","Кузнецов","Попов","Васильев","Петров","Соколов","Михайлов","Новиков","Фёдоров","Морозов","Волков","Алексеев","Лебедев","Семёнов","Егоров","Павлов","Козлов","Степанов",
	"Николаев","Орлов","Андреев","Макаров","Никитин","Захаров","Зайцев","Соловьёв","Борисов","Яковлев","Григорьев","Романов","Воробьёв","Сергеев","Кузьмин","Фролов","Александров","Дмитриев","Королёв",
	"Гусев","Киселёв","Ильин","Максимов","Поляков","Сорокин","Виноградов","Ковалёв","Белов","Медведев","Антонов","Тарасов","Жуков","Баранов","Филиппов","Комаров","Давыдов","Беляев","Герасимов",
	"Богданов","Осипов","Сидоров","Матвеев","Титов","Марков","Миронов","Крылов","Куликов","Карпов","Власов","Мельников","Денисов","Гаврилов","Тихонов","Казаков","Афанасьев","Данилов","Савельев",
	"Тимофеев","Фомин","Чернов","Абрамов","Мартынов","Ефимов","Федотов","Щербаков","Назаров","Калинин","Исаев","Чернышёв","Быков","Маслов","Родионов","Коновалов","Лазарев","Воронин","Климов",
	"Филатов","Пономарёв","Голубев","Кудрявцев","Прохоров"
];
_zagortatar_names = [
	"Самир","Налим","Ислам","Ахмар","Джанбатыр","Заманбек","Мурад","Рубаз","Саид","Джанбек","Рахмат","Сахи","Кадиш","Абиль","Каим","Калбай","Сияр","Агзам","Алмаз","Арсен","Анвар","Бакир","Бахтияр",
	"Булат","Вахид","Дамир","Даян","Денис","Джамиль","Замир","Захар","Ибрагим","Ильдар","Ильназ","Ильяс","Исмаил","Кадим","Карим","Камиль","Марат","Махмуд","Мухаммед","Надир","Назар","Нариман","Радик",
	"Рамиль","Рашид","Рафик","Ренат","Руслан","Салават","Сулейман","Тимур","Усман","Фарид","Хасан","Хаттаб","Чингиз","Шамиль","Эльдар","Юнус","Ямал"
];
_zagortatar_lastnames = [
	"Керимов","Радуев","Уразаев","Абашев","Абдулов","Авдулов","Адашев","Азанчеев","Акчурин","Алабин","Алашеев","Алмазов","Алпаров","Амиров","Аракчеев","Багримов","Базаров","Байбаков","Байкулов","Бакаев","Бакиев",
	"Барсуков","Баскаков","Басманов","Бастанов","Батурин","Бахтеяров","Башмаков","Бегичев","Бекетов","Бекляшев","Беклешев","Беркутов","Булгаков","Бухарин","Годунов","Горчаков","Дашков","Давыдов","Девлегаров",
	"Дедюлин","Дулов","Дунилов","Дурасов","Едигеев","Елгозин","Елчин","Елычев","Жданов","Жемайлов","Загоскин","Зекеев","Зенбулатов","Злобин","Змеев","Зюзин","Иевлев","Издемиров","Измайлов","Исенев","Исупов",
	"Каблуков","Кадышев","Кайсаров","Камаев","Канчеев","Карамзин","Каратеев","Караулов","Келдыш","Кельдерманов","Киреев","Конаков","Кочубей","Кудинов","Курбатов","Лачинов","Лихарёв","Любавский","Макшеев","Мамонов",
	"Мансуров","Можаров","Нагаев","Нарбеков","Нарышкин","Обиняков","Окулов","Ордынцев","Пильемов","Радищев","Ратаев","Саблуков","Сабуров","Сагеев","Тагаев","Талаев","Тараканов","Тарханов","Тенеев","Урманов",
	"Урусов","Усейнов","Ханкилдеев","Ханыков","Цуриков","Чаадаев","Чемесов","Черемисов","Чириков","Чубаров","Шадрин","Шалимов","Шамов","Шарапов","Янбулатов","Якушин","Ямантов"
];
nat_array = [
	//[classname,text,religions,names,lastnames,faces]
	["chernorussian", "чернорус", ["orthodox"],_chernorussian_names,_chernorussian_lastnames,["WhiteHead_01","WhiteHead_02","GreekHead_A3_02","WhiteHead_18","GreekHead_A3_07","WhiteHead_03","WhiteHead_04","GreekHead_A3_03","WhiteHead_06","WhiteHead_07","GreekHead_A3_05","GreekHead_A3_11","GreekHead_A3_06","WhiteHead_08","WhiteHead_09","GreekHead_A3_08","WhiteHead_16","WhiteHead_11","WhiteHead_10","WhiteHead_23","WhiteHead_19","WhiteHead_17","WhiteHead_21","WhiteHead_12","WhiteHead_13","GreekHead_A3_09","WhiteHead_14","WhiteHead_15","WhiteHead_20"]],
	["russian", "русский", ["orthodox"],_russian_names,_russian_lastnames,["WhiteHead_01","WhiteHead_02","GreekHead_A3_02","WhiteHead_18","GreekHead_A3_07","WhiteHead_03","WhiteHead_04","GreekHead_A3_03","WhiteHead_06","WhiteHead_07","GreekHead_A3_05","GreekHead_A3_11","GreekHead_A3_06","WhiteHead_08","WhiteHead_09","GreekHead_A3_08","WhiteHead_16","WhiteHead_11","WhiteHead_10","WhiteHead_23","WhiteHead_19","WhiteHead_17","WhiteHead_21","WhiteHead_12","WhiteHead_13","GreekHead_A3_09","WhiteHead_14","WhiteHead_15","WhiteHead_20"]],
	["zagortatar", "загорский татарин", ["orthodox","sunni","sunni","sunni","sunni"],_zagortatar_names,_zagortatar_lastnames,["GreekHead_A3_13","GreekHead_A3_01","WhiteHead_05","GreekHead_A3_03","Ioannou","Mavros","GreekHead_A3_09","Sturrock","GreekHead_A3_14"]]
];
publicvariable "nat_array";
nat_array_classes = [];
{
	nat_array_classes pushBack (_x select 0);
} foreach nat_array;
publicvariable "nat_array_classes";
rel_array = [
	//[classname,text]
	["orthodox", "православие"],
	["catholic", "католицизм"],
	["protestant", "протестантизм"],
	["sunni", "суннизм"],
	["islam", "ислам"],
	["atheism", "атеизм"]
];
publicvariable "rel_array";
rel_array_classes = [];
{
	rel_array_classes pushBack (_x select 0);
} foreach rel_array;
publicvariable "rel_array_classes";
speedcameras_array_nottown = [speedcamera_1,speedcamera_2,speedcamera_3];
{
	
	_x spawn {
		
		private ["_camera"];
		
		_camera = _this;
		
		while {true} do {
			
			waitUntil {(count ((nearestObjects [_camera, ["LandVehicle"], 20])-(_camera getVariable ["photoedcars",[]]))) > 0};
			
			{
				if ((speed _x) > (nottown_speedlimit+20)) then {
					
					private ["_code","_args"];
				
					_code = {
						
						private ["_driver","_speed"];
						
						_driver = _this select 0;
						_speed = _this select 1;
						
						if ((str _driver) in cop_array) exitWith {};
						
						systemChat format ["%1 превысил скорость на %2 км/ч", [_driver,false] call fnc_getRealName, ceil _speed];
						
						if !(_driver==player) exitWith {};
						
						demerits = demerits - 1;
						
						if (demerits<0) then {
							licenses = licenses - ["car","truck"];
							demerits = 0;
							["Превышение скорости","Вы потеряли водительскую лицензию!",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
						};
						
						["Превышение скорости",format ["Вы превысили скорость! У вас осталось %1 очков!",demerits],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
						
						
					};
					
					_args = [driver _x,(speed _x)-nottown_speedlimit];
					
					[_args,_code] remoteExec ["spawn"];
					
					_camera setVariable ["photoedcars",(_camera getVariable ["photoedcars",[]])+[_x],true];
					
					[_camera,_x] spawn {
						
						private ["_camera","_car"];
						
						_camera = _this select 0;
						_car = _this select 1;
						
						sleep 10;
						
						_camera setVariable ["photoedcars",(_camera getVariable ["photoedcars",[]])-[_car],true];
												
					};
				
				};
				
			} forEach ((nearestObjects [_camera, ["LandVehicle"], 20])-(_camera getVariable ["photoedcars",[]]));
			
		};
		
	};
	
} forEach speedcameras_array_nottown;
speedcameras_array_town = [speedcamera_4,speedcamera_5];
{
	
	_x spawn {
		
		private ["_camera"];
		
		_camera = _this;
		
		while {true} do {
			
			waitUntil {(count ((nearestObjects [_camera, ["LandVehicle"], 20])-(_camera getVariable ["photoedcars",[]]))) > 0};
			
			{
				if ((speed _x) > (town_speedlimit+20)) then {
					
					private ["_code","_args"];
				
					_code = {
						
						private ["_driver","_speed"];
						
						_driver = _this select 0;
						_speed = _this select 1;
						
						if ((str _driver) in cop_array) exitWith {};
						
						systemChat format ["%1 превысил скорость на %2 км/ч", [_driver,false] call fnc_getRealName, ceil _speed];
						
						if !(_driver==player) exitWith {};
						
						demerits = demerits - 1;
						
						if (demerits<0) then {
							licenses = licenses - ["car","truck"];
							demerits = 0;
							["Превышение скорости","Вы потеряли водительскую лицензию!",[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
						};
						
						["Превышение скорости",format ["Вы превысили скорость! У вас осталось %1 очков!",demerits],[1,1,1,1],[0,0.5,0,0.8]] spawn fnc_notifyMePls;
						
						
					};
					
					_args = [driver _x,(speed _x)-town_speedlimit];
					
					[_args,_code] remoteExec ["spawn"];
					
					_camera setVariable ["photoedcars",(_camera getVariable ["photoedcars",[]])+[_x],true];
					
					[_camera,_x] spawn {
						
						private ["_camera","_car"];
						
						_camera = _this select 0;
						_car = _this select 1;
						
						sleep 10;
						
						_camera setVariable ["photoedcars",(_camera getVariable ["photoedcars",[]])-[_car],true];
												
					};
				
				};
				
			} forEach ((nearestObjects [_camera, ["LandVehicle"], 20])-(_camera getVariable ["photoedcars",[]]));
			
		};
		
	};
	
} forEach speedcameras_array_town;
gangareas_array = ["gangarea_1","gangarea_2","gangarea_3"];
publicVariable "gangareas_array";
gangareas_owners = ["none","none","none"];
publicVariable "gangareas_owners";
{
	
	//(call compile _x) setFlagAnimationPhase 0;	
	[(call compile _x), 0, true] call BIS_fnc_animateFlag;
	
	(call compile _x) setVariable ["flagowner","none",true];
	
} forEach gangareas_array;
[] spawn {
	
	waitUntil {!isNil "fnc_getShopItems"};
	waitUntil {!isNil "fnc_getShopStock"};
	waitUntil {!isNil "fnc_getShopMaxStock"};
	waitUntil {!isNil "fnc_addShopStock"};
	waitUntil {!isNil "kokoko123"};
	waitUntil {kokoko123};
	
	diag_log "1488 pidorasiki";
	
	while {true} do {
		
		{
	diag_log "1488 pidorasiki check";
			private ["_shop","_items","_classnames","_stock","_maxstock","_flag"];
			
			_shop = format ["%1_narco",_x];
			_flag = call compile _x;
			
			if ((_flag getVariable ["flagowner","none"])!="none") then {
		
				_items = _shop call fnc_getShopItems;
				_classnames = _items select 1;
	diag_log "1488 pidorasiki check2";
	diag_log format ["%1 da",_classnames];
				
				{
				
					_stock = [_x, _shop] call fnc_getShopStock;
					_maxstock = [_x, _shop] call fnc_getShopMaxStock;
					
					if (_stock<_maxstock) then {
											
						[_x, 1, _shop] call fnc_addShopStock;
						
					};
				
				} forEach _classnames;
			
			};
		
		} forEach gangareas_array;
		
		sleep 120;
		
	};
	
}; //[gangname, ownerid, buchones array, members array, openornot]
global_gangs_array = []; 
publicVariable "global_gangs_array";
global_gangs_array_names = [];
publicVariable "global_gangs_array_names";
gangs_online = [];
publicVariable "gangs_online";
gangs_online_players = [];
publicVariable "gangs_online_players";
tf_radio_server_name = "Zagoria Life Revolution [Armaworld]";
publicVariable "tf_radio_server_name";
tf_radio_channel_name = "TFAR";
publicVariable "tf_radio_channel_name";
tf_radio_channel_password = "1488228322";
publicVariable "tf_radio_channel_password";
offroad_veh_data = [
	["QIN_Offroad_POLICIE",55],
	["B_G_Offroad_01_armed_F",55],
	["C_Offroad_01_F",55],
	["BAF_Offroad_W_HMG",58],
	["LandRover_TK_CIV_EP1",58],
	["Quiet_c65amg_noir_f",52],
	["Jonzie_Raptor",60],
	["quiet_sub2015_noir_f",57],
	["C_Van_01_box_F",40],
	["C_Van_01_transport_F",40],
	["C_Van_01_fuel_F",40],
	["C_Truck_02_box_F",45],
	["C_Truck_02_transport_F",45],
	["C_Truck_02_covered_F",45],
	["C_Truck_02_covered_F",45],
	["RDS_Zetor6945_Base",50],
	["RDS_tt650_Civ_01",48]
];
publicVariable "offroad_veh_data";
offroad_veh_data_classes = [];
{
	offroad_veh_data_classes pushBack (_x select 0);
} forEach offroad_veh_data;
publicVariable "offroad_veh_data_classes";
