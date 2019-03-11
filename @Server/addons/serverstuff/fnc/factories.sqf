
if (true) exitWith {};
_metal_items = [
	"sera",
	"aluminium_ingot",
	"copper_ingot",
	"iron_ingot",
	"steel_ingot",
	"cpu",
	"plastic",
	"resin",
	"glass"
];
_item_items = [
	"waterfilter",
	"steel_can",
	"plastic_bottle",
	"av_gasm2"
];
_legal_guns = [
	"C_Offroad_01_F",
	"hgun_Pistol_Signal_F",
	"6Rnd_GreenSignal_F"
];
_food = [
	"beans",
	"cereal",
	"tacticalbacon",
	"sugar",
	"chocolatebar",
	"bread",
	"water",
	"waterbottle"
];
factories_array = [
	//["metal_factory", "Ресурсоперерабатывающий завод", metal_factory, 100000, _metal_items, dummy,dummy],
	//["gunfactory_legal", "Завод охотничьего оружия", gunfactory_legal, 600000, _legal_guns, gunfactory_legal_crate,dummy],
	["gunfactory_legal", "Завод имени Ленина", gunfactory_legal, 60000, _legal_guns, gunfactory_legal_crate,gunfactory_legal_spawn]
	//["food_factory1", "Пищевая фабрика", food_factory1, 100000, _food, dummy, dummy],
	//["items_factory1", "Завод предметов", items_factory1, 100000, _item_items, items_factory1_crate, dummy]
];
factoryclass_array = [];
{
	factoryclass_array pushBack (_x select 0);
} foreach factories_array;
