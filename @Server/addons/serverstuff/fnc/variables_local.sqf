
myuid = getPlayerUID player;
garages_array = [
	["garage_1","garage_1_spawn",["LandVehicle","Air"]],
	["garage_2","garage_2_spawn",["LandVehicle","Air"]],
	["garage_boat_1","garage_boat_1_spawn",["Ship"]]
];
garages_array_classes = [];
{
	garages_array_classes pushBack (_x select 0);
} foreach garages_array;
antidupa = false;
lastdupa = 0;
shootingskill_cd = false;
closedshit = true;
workplaces_array = [
	
	//[classname,object,income for workers,radius,income for owners,ownership cost]
	["workplace_1",workplace_1,10,50,5000,40000],
	["workplace_2",workplace_2,10,50,5000,40000],
	["workplace_3",workplace_3,10,50,5000,40000]
];
processing_array = [
	//[item,object,price,license]
	["iron_ingot",[metal_process],0,"engie_chem"],
	["copper_ingot",[metal_process],0,"engie_chem"],
	["steel_ingot",[metal_process],0,"engie_chem"],
	["sera",[metal_process],0,"engie_chem"],
	["glass",[metal_process],0,"engie_chem"],
	["plastic",[metal_process],0,"engie_chem"],
	["resin",[metal_process],0,"engie_chem"],
	["cpu",[metal_process],0,"engie_chem"],
	
	["lsd",[gangarea_1],500,"lsd"],
	["mdma",[gangarea_2],500,"mdma"],
	["mari",[gangarea_2],500,"mari"],
	["heroin",[gangarea_3],500,"heroin"],
	["amphetamine",[gangarea_3],500,"amphetamine"],
	
	//["samogon",[samogon],4000,"samogon"],
	["psilo",[samogon],0,"samogon"],
	["samogon",[samogon],0,"samogon"]
];
/*farm_areas = 
[
	["kilka_1",250,"kilka",2,70,"Ship"],
	["mackerel_1",250,"mackerel",2,70,"Ship"],
	["tuna_1",250,"tuna",2,70,"Ship"],
	["whale_1",500,"whale",1,10,"Ship"],
	
	["apples1",50,"apple",4,25,"Man"],
	["pear_1",50,"pear",4,25,"Man"],
	["wheat1",100,"wheat",2,60,"Man"],
	["hordeum_1",100,"hordeum",2,70,"Man"],
	["tobacco_1",50,"tobacco",2,70,"Man"],
	["cotton_1",50,"cotton",2,70,"Man"],
	["humulus_1",50,"humulus",2,70,"Man"],
	["sugar_beet_1",50,"sugar_beet",2,70,"Man"],
	["rawbeans_1",50,"rawbeans",2,70,"Man"],
	["grape_1",50,"grape",2,70,"Man"],
	
	["vanilla_1",50,"vanilla",2,70,"Man"],
	["konoplya_1",50,"konoplya",2,70,"Man"],
	["poppy_opium_1",50,"poppy_opium",2,70,"Man"]
	//["cocoa_beans1",50,"cocoa_beans",10,70,"Man"]
];*/
farm_areas = 
[
	["kilka_1",250,"kilka",20,70,"Ship"],
	["mackerel_1",250,"mackerel",20,70,"Ship"],
	["tuna_1",250,"tuna",20,70,"Ship"],
	["whale_1",500,"whale",3,10,"Ship"],
	
	["apples1",50,"apple",40,25,"Man"],
	["pear_1",50,"pear",40,25,"Man"],
	["wheat1",100,"wheat",20,60,"Man"],
	["hordeum_1",100,"hordeum",20,70,"Man"],
	["tobacco_1",50,"tobacco",20,70,"Man"],
	["cotton_1",50,"cotton",20,70,"Man"],
	["humulus_1",50,"humulus",20,70,"Man"],
	["sugar_beet_1",50,"sugar_beet",20,70,"Man"],
	["rawbeans_1",50,"rawbeans",20,70,"Man"],
	["grape_1",50,"grape",20,70,"Man"],
	
	["vanilla_1",50,"vanilla",20,70,"Man"],
	["konoplya_1",50,"konoplya",20,70,"Man"],
	["poppy_opium_1",50,"poppy_opium",20,70,"Man"]
	//["cocoa_beans1",50,"cocoa_beans",10,70,"Man"]
];
mine_areas =
[
	["salt_1",30,"salt", ["pickaxe","jackhammer"]],
	["sera1",30,"sera_ore", ["pickaxe","jackhammer"]],
	["crudeoil_1",30,"crudeoil", ["pickaxe","jackhammer"]],
	["crudeoil_2",30,"crudeoil", ["pickaxe","jackhammer"]],
	["wood_1",300,"wood", ["axe","lumberaxe","chainsaw"]],
	["wood_2",300,"wood", ["axe","lumberaxe","chainsaw"]],
	//["crudeoil2",30,"crudeoil", ["jackhammer"]],
	//["crudeoil3",30,"crudeoil", ["jackhammer"]],
	["sand_1",50,"sand", ["shovel"]],
	["sand_2",50,"sand", ["shovel"]],
	["copper_1",30,"copper_ore", ["pickaxe","jackhammer"]],
	["copper_2",30,"copper_ore", ["pickaxe","jackhammer"]],
	["iron_1",50,"iron_ore", ["pickaxe","jackhammer"]],
	//["aluminium1",50,"aluminium_ore", ["pickaxe","jackhammer"]],
	["silicon1",40,"silicon", ["pickaxe","jackhammer"]],
	["coal_1",50,"coal", ["pickaxe","jackhammer"]]
	//["wood1",200,"wood", ["axe","lumberaxe","chainsaw"]]
];
keys_on = true;
pickingup = false;
//инициализируем переменные игрока
hunger = 0;
thirst = 0;
licenses = [];
licenses_illegal = [];
deposit = 40000;
inventory_items = [];
inventory_amount = [];
player linkItem "ItemMap";
player setVariable ["invi",inventory_items,true];
player setVariable ["inva",inventory_amount,true];
vehicle_keys = [];
garage_array = [];
stress = 0;
my_workplaces = [];
maxweight = 60;
my_factories = [];
my_factories_wh = [];
my_factories_stock = [];
working = false;
mining = false;
collectingwater = false;
holsterGun = "";
holsterGunMagazine = "";
holsterGunRounds = 0;
player addEventHandler ["Killed", {_this call fnc_killed}];
player addEventHandler ["Fired", {_this call fnc_fired}];
player addEventHandler["InventoryClosed", {_this call fnc_inventoryClosedScript}];
player addEventHandler["InventoryOpened", {_this call fnc_inventoryOpenedScript}];
isdead = false;
respawntime = 10;
timetorespawn = 10;
maxrespawntime = 1200;
cursearch = dummy;
hitting = false;
stunned = false;
stuncountdown = 0;
stunmax = 120;
workplaceadd = 0;
civincome = 500;
copincome = 5000;
taxi_markers_array = ["taximarker_1","taximarker_2","taximarker_3","taximarker_4","taximarker_5","taximarker_6","taximarker_7"];
taxijob = false;
taxipassenger = dummy;
taximarker = "noner";
taxiguyactive = false;
taximissiontaken = false;
dp_array = [dp_1,dp_2,dp_3,dp_4];
courierjob = false;
couriertarget = dummy;
couriertimeleft = 0;
couriertimeleftmax = 0;
bankrobenable = true;
stolencash = 0;
allowuseatm = 0;
demerits = 10;
//RP
nationalities_array = ["chernorussian","russian"];
nationality = "chernorussian";
religion = "orthodox";
addiction = [];
addiction_level = [];
shootingskill = 0;
battleskill = 0;
lockpickskill = 0;
engskill = 0;
strengthskill = 0;
staminaskill = 0;
//role_id = 1399;
charname = "test";
charlastname = "test";
rp_face = "WhiteHead_10";
rp_firsttimewakeup = 1;
killed_players_pts = 0;
jailed = false;
jailtimeleft = 0;
allowjailescape = true;
player setVariable ["search", false, true];
gs_array = ["gasstation_1","gasstation_2","gasstation_3","gasstation_4","gasstation_5","gasstation_6","gasstation_7","gasstation_8","gasstation_9"];
neutralizing_flag = false;
cooldown_array = [[],[]];
cooldown_names_classes = ["gang_cd", "gun_cd", "alco_cd", "nikotin_cd", "narco_cd", "religion_cd","pray_cd","bp_nvg_cd"];
cooldown_names = ["Создание банды через", "Использование оружия через", "Употребление алкоголя через", "Курение через", "Употребление наркотиков через", "Смена вероисповедания","Поход в храм","ПНВ/рюкзак"];
cooldown_descriptions = [
	"В течение действия этого кулдауна вы не сможете создавать банды.",
	"Вы не сможете применять оружие, ставить и подрывать взрывчатку в течение действия этого кулдауна.",
	"Употребив алкоголь во время действия этого кулдауна вы не получите RPP и не снимете усталость.",
	"Употребив никотин во время действия этого кулдауна вы сможете снять усталость, но не получите RPP.",
	"Вы не получите RPP при употреблении наркотиков во время действия этого кулдауна.",
	"Вы не можете сменить вероисповедание во время действия этого кулдауна",
	"Вы недавно уже ходили в храм и сможете сходить снова как только кулдаун спадёт.",
	"За последние 15 минут вы надевали ПНВ или рюкзак. Ваша прибыль RPP уменьшена в пять раз, а расход RPP увеличен в два раза."
];
blood_array = [[],[]];
blood_stuff_classes = ["alcohol","psilo","lsd","cannabis","mdma","amph"];
blood_stuff_names = ["алкоголь","псилоцибин","ЛСД","каннабиоиды","MDMA","амфетамин"];
roleplay_pts = 0;
stress_value = 0;
smokingcig = false;
restrained_punish = 0;
[] spawn {
	
	while {true} do {
		
		if !isdead then {
		
			private ["_deleteArray"];
			
			_deleteArray = [];
			
			{
				
				if (_x>=1) then {
					
					(cooldown_array select 1) set [_forEachIndex, _x-1];
					
				} else {
					
					_deleteArray pushBack _forEachIndex;
					
				};
				
			} forEach (cooldown_array select 1);
			
			{
				(cooldown_array select 0) deleteAt _x;
				(cooldown_array select 1) deleteAt _x;		
				
			} forEach _deleteArray;
		
		};
		
		sleep 60;
	};
	
};
somebodysaveme = 0;
