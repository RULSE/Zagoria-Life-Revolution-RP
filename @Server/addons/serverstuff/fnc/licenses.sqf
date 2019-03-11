
licenses_array = [
	["prom_hunt", "Лицензия на промысловую охоту", [license_guy_1,license_guy_2], 10000, 1],
	["prom_fish", "Лицензия на промысловую рыбную ловлю", [license_guy_1,license_guy_2], 20000, 1],
	["car", "Лицензия на вождение автомобиля", [license_guy_1,license_guy_2], 500, 1],
	["truck", "Лицензия на вождение грузовика", [license_guy_1,license_guy_2], 1500, 1],
	["moto", "Лицензия на вождение мотоцикла", [], 200, 1],
	["boat", "Лицензия на вождение лодок", [license_guy_1,license_guy_2], 2000, 1],
	["air", "Лицензия пилота", [license_guy_1,license_guy_2], 30000, 1],
	["engie_chem", "Навык инженера-химика", [license_guy_1,license_guy_2,metal_process], 5000, 1],
	
	["cocaine", "Навык переработки коки", [cocaine], 40000, 0],
	["lsd", "Навык производства ЛСД", [gangarea_1], 35000, 0],
	["mdma", "Навык производства МДМА", [gangarea_2], 35000, 0],
	["mari", "Навык обработки марихуаны", [gangarea_2], 15000, 0],
	["heroin", "Навык производства героина", [gangarea_3], 40000, 0],
	["amphetamine", "Навык производства амфетамина", [gangarea_3], 55000, 0],
	
	//["smuggler", "Договор с контрабандистами", [], 100, 0],
	["napa", "Членство в НаПа", [], 100, 0],
	["ig_lic", "Членство в ИГ", [], 100, 0],
	["smuggler", "Контракт на поставку", [weapon_smuggler], 500000, 0],
	["samogon", "Самогонщик-грибонюх", [], 5000, 0],
	["terrorist", "Террорист", [], 850000, 0],
	["oxotbilet", "Охотничий билет", [license_guy_1,license_guy_2], 5000, 1],
	["huntingweapons", "Лицензия на охотничье оружие", [license_guy_1,license_guy_2], 50000, 1]
];
licensesclass_array = [];
{
	licensesclass_array pushBack (_x select 0);
} foreach licenses_array;
