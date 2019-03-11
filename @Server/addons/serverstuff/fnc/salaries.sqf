
/*while {iscopCLR} do 
{
sleep 60;
player groupChat format[localize "STRS_geld_countdown", "2"];
sleep 60;
player groupChat format[localize "STRS_geld_countdown", "1"];
sleep 60;
_income = add_copmoney;
if ("patrol_training" call INV_HasLicense) then 
	{
	_income = _income + (1000 + random 600 - random 400);
	};
if ("response_training" call INV_HasLicense) then 
	{
	_income = _income + (1400 + random 800 - random 200);
	};
if ("swat_training" call INV_HasLicense) then 
	{
	_income = _income + (1800 + random 1000 - random 200);
	}; 
if (ischief) then 
	{
																					
	_income = _income + chiefExtraPay;                          																											
		
	};
kontostandCLR = kontostandCLR + (round _income);
player groupChat format[localize "STRS_geld_copmoneyadd", rolestring, ((round _income) call ISSE_str_IntToStr)];
sleep 1;					
if(ischief)then{player groupchat format["Как начальник милиции вы дополнительно получаете $%1.", (chiefExtraPay call ISSE_str_IntToStr)]};   
};*/
while {true} do 
{
sleep 30;
["Зарплата",format["Через %1 минуты вы получите зарплату.", "2"],[1,1,1,1],[0,0.68,0.47,0.8]] spawn fnc_notifyMePls;
sleep 30;
["Зарплата",format["Через %1 минуты вы получите зарплату.", "1"],[1,1,1,1],[0,0.68,0.47,0.8]] spawn fnc_notifyMePls;
sleep 30;
	       
if ((alive player) and !isdead) then 
	{
		
		private ["_income"];
		
		_income = civincome;
		
		if ((str player) in cop_array) then {
		
			_income = copincome;
		
		};
		
		_income = _income + (1000*(count my_workplaces));
		
		if ((getPlayerUID player)==current_governor) then {
			
			_income = _income + gov_money*0.01;
			_income = round _income;
			gov_money=gov_money*0.01;
			gov_money = round gov_money;
			publicVariable "gov_money";
			
		};
	/*_workplacepaycheck = 0;
	_uniPaycheck       = 0;	
	_unimsg            = ""; 	
	_atworkplacemsg    = localize "STRS_geld_nowere";									
	_hashideoutmsg     = "";
	_income            = add_civmoney;
	_mygang		   = "None";
	_activecount	   = 0;	
	
	for [{_i=0}, {_i < (count BuildingsOwnerArray)}, {_i=_i+1}] do 
		{
		_check = ( round( (random 2)*((BuyAbleBuildingsArray select _i) select 4) ) );
		_income = _income + _check;
		
		};*/
	if (workplaceadd > 0) then {
		_income = _income + workplaceadd;
		workplaceadd = 0;
	};
	
	deposit = deposit + _income;
	
	["Зарплата",format ["Вы получили доход в размере %1 CRK, следующая зарплата через 3 минуты.",_income],[1,1,1,1],[0,0.68,0.47,0.8]] spawn fnc_notifyMePls;
		
	/*	for "_c" from 0 to (count gangsarray - 1) do 
		{
		_gangarray = gangsarray select _c;
		_gangname  = _gangarray select 0;
		_members   = _gangarray select 1;
		
		if((name player) in _members)then
			{
			_mygang = _gangname;
			for "_i" from 0 to (count _members - 1) do 
				{
				_civ = [(_members select _i), civarray] call INV_findunit;
				if(!isnull _civ)then{_activecount = _activecount + 1};
				};
			};
		
		};
	if(_mygang != "None") then
		{
		if(gangarea1 getvariable "control" == _mygang)then{_income = _income + (gangincome/_activecount)};
		if(gangarea2 getvariable "control" == _mygang)then{_income = _income + (gangincome/_activecount)};
		if(gangarea3 getvariable "control" == _mygang)then{_income = _income + (gangincome/_activecount)};
		};			
	timeinworkplace = 0;
	_income = round _income;		
	kontostandCLR = kontostandCLR + _income;	
	player groupChat format[localize "STRS_geld_civmoneyadd", rolestring, (_income call ISSE_str_IntToStr)];		
	if (isMayor) then 
		{
																					
		MayorSteuern = MayorSteuern + INV_SteuernGezahlt;                     																																							
		MayorSteuern = round((MayorSteuern / 100) * MayorBekommtSteuern); 									
		kontostandCLR = kontostandCLR + MayorSteuern;                           																					
		kontostandCLR = kontostandCLR + MayorExtraPay;                          																											
		player groupchat format["Как Мэр вы дополнительно получаете зарплату $%1. Также вы получаете доход от налогов $%2.", (MayorExtraPay call ISSE_str_IntToStr), (MayorSteuern call ISSE_str_IntToStr)];		
		} 
		else 
		{
																																			
		if (INV_SteuernGezahlt > 0) then 
			{	
			(format["if (isMayor) then {MayorSteuern = MayorSteuern + %1;};", INV_SteuernGezahlt]) call broadcast;	
			};	
		};
				
	MayorSteuern   = 0;																		
	INV_SteuernGezahlt = 0;		*/
	} 
	else 
	{
	
		["Зарплата",format ["Вы пропускаете зарплату так как вы мертвы.",123],[1,1,1,1],[0,0.68,0.47,0.8]] spawn fnc_notifyMePls;
	};
}; 
