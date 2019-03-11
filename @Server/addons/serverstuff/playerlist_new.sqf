
fnc_openPlayerList = {
	if (!(createDialog "playerlist")) exitWith {hint "Dialog Error!";};
	private ["_dialog","_rp_info","_rp_stats","_skills_info","_gov_info","_cd_lb","_lic_lb"];
		
	_dialog = findDisplay 50017;
	_rp_data = _dialog displayCtrl 1102;
	_rp_stats = _dialog displayCtrl 1100;
	_gov_info = _dialog displayCtrl 1101;
	_skills_info = _dialog displayCtrl 1103;
	
	_cd_lb = _dialog displayCtrl 1500;
	_lic_lb = _dialog displayCtrl 1501;
		
	_rp_data ctrlSetStructuredText parseText format ["Имя: <t color='#00ff00'>%4 %5</t><br/>Национальность: <t color='#00ff00'>%1</t><br/>Вероисповедание: <t color='#00ff00'>%2</t><br/>Ролевые очки: <t color='#00ff00'>%3</t> RPP",nationality call fnc_getNatName,religion call fnc_getRelName,[round roleplay_pts] call fnc_numberToText, charname, charlastname];
	_rp_stats ctrlSetStructuredText parseText format ["Наличные: <t color='#00ff00'>%1</t> CRK<br/>Счёт в банке: <t color='#00ff00'>%2</t> CRK<br/>Убито игроков в этой жизни: <t color='#00ff00'>%3</t><br/>",["money" call fnc_getItemAmount] call fnc_numberToText,[deposit] call fnc_numberToText,killed_players_pts];
	_skills_info ctrlSetStructuredText parseText format ["Стрельба: <t color='#00ff00'>%1</t>/<t color='#00ff00'>100</t><br/>Боевой опыт: <t color='#00ff00'>%2</t>/<t color='#00ff00'>100</t><br/>Взлом: <t color='#00ff00'>%3</t>/<t color='#00ff00'>100</t><br/>Инженерное дело: <t color='#00ff00'>%4</t>/<t color='#00ff00'>100</t><br/>Сила: <t color='#00ff00'>%5</t>/<t color='#00ff00'>100</t><br/>Выносливость: <t color='#00ff00'>%6</t>/<t color='#00ff00'>100</t><br/>",floor shootingskill,floor battleskill,floor lockpickskill,floor engskill,floor strengthskill,floor staminaskill];
	_gov_info ctrlSetStructuredText parseText format ["Губернатор: <t color='#00ff00'>%8</t><br/>Окружная казна: <t color='#00ff00'>%9</t> CRK<br/>Скорость в городе: <t color='#00ff00'>%1</t> км/ч<br/>Скорость за городом: <t color='#00ff00'>%2</t> км/ч<br/>Короткоствольное оружие: <t color='#00ff00'>%3</t><br/>Подоходный налог: <t color='#00ff00'>%4</t>%5<br/>НДС: <t color='#00ff00'>%6</t>%5<br/>Сумма наличности в банке: <t color='#00ff00'>%7</t> CRK<br/>",town_speedlimit,nottown_speedlimit,if handgun_legal then {"легально"} else {"нелегально"},inc_tax*100,"%",nds_tax*100,[robpoolsafe1 + robpoolsafe2 + robpoolsafe3] call fnc_numberToText, current_governor_name, [round gov_money] call fnc_numberToText];
	
	{
		lbAdd [1500, format ["%1: %2 мин", cooldown_names select (cooldown_names_classes find _x), (cooldown_array select 1) select _forEachIndex]];
		lbSetData [1500, (lbSize 1500) - 1, _x];
	} forEach (cooldown_array select 0);
	
	{lbAdd [1501, _x call fnc_getLicenseName];} foreach (licenses+licenses_illegal);
	
};
publicVariable "fnc_openPlayerList";
fnc_cooldownDescription = {
	private ["_index","_dialog","_descrText","_cdDescription"];
	
	_index = _this;
	
	_dialog = findDisplay 50017;
	_descrText = _dialog displayCtrl 1104;
	_cdDescription = cooldown_descriptions select (cooldown_names_classes find (lbData [1500, _index]));
	
	_descrText ctrlSetStructuredText parseText _cdDescription;
	
};
publicVariable "fnc_cooldownDescription";
