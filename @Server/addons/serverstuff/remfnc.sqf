
fnc_getRes_remote_code_1 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT position From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_1";
fnc_getRes_remote_code_2 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT equipment From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_2";
fnc_getRes_remote_code_3 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT items From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_3";
fnc_getRes_remote_code_4 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT weapons_cargo From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_4";
fnc_getRes_remote_code_5 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT weapons From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_5";
fnc_getRes_remote_code_6 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT magazines From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_6";
fnc_getRes_remote_code_7 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT position From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_7";
fnc_getRes_remote_code_8 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT direction From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_8";
fnc_getRes_remote_code_9 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT food From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_9";
fnc_getRes_remote_code_10 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT water From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_10";
fnc_getRes_remote_code_11 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT bank From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_11";
fnc_getRes_remote_code_12 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT inventory From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_12";
fnc_getRes_remote_code_12_2 = {
		
		("extDB3" callExtension format ["5:%1",_this select 0])
		
	};
publicVariable "fnc_getRes_remote_code_12_2";
fnc_getRes_remote_code_13 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT licenses From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_13";
fnc_getRes_remote_code_14 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT vehicle_keys From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_14";
fnc_getRes_remote_code_15 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT player_values From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_15";
fnc_getRes_remote_code_16 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT factories From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_16";
fnc_getRes_remote_code_17 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT holster From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_17";
fnc_getRes_remote_code_18 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT deatharray From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_18";
fnc_getRes_remote_code_19 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT workplaces From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_19";
fnc_getRes_remote_code_20 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT cooldown_array From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_20";
fnc_getRes_remote_code_21 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT roleplay_pts From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_21";
fnc_getRes_remote_code_22 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT playername,reasons,bounty From wanted_list WHERE playerid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_22";
fnc_getRes_remote_code_23 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT position_cop From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_23";
fnc_getRes_remote_code_24 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT equipment_cop From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_24";
fnc_getRes_remote_code_25 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT items_cop From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_25";
fnc_getRes_remote_code_26 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT weapons_cargo_cop From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_26";
fnc_getRes_remote_code_27 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT weapons_cop From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_27";
fnc_getRes_remote_code_28 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT magazines_cop From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_28";
fnc_getRes_remote_code_29 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT position_cop From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_29";
fnc_getRes_remote_code_30 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT direction_cop From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_30";
fnc_getRes_remote_code_31 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT food_cop From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_31";
fnc_getRes_remote_code_32 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT water_cop From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_32";
fnc_getRes_remote_code_33 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT bank From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_33";
fnc_getRes_remote_code_34 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT inventory_cop From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_34";
fnc_getRes_remote_code_35 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT licenses_cop From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_35";
fnc_getRes_remote_code_36 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT vehicle_keys_cop From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_36";
fnc_getRes_remote_code_37 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT player_values_cop From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_37";
fnc_getRes_remote_code_38 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT holster_cop From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_38";
fnc_getRes_remote_code_39 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT deatharray_cop From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_39";
fnc_getRes_remote_code_40 = {
		
		("extDB3" callExtension format ["0:SQL:SELECT roleplay_pts From player_data WHERE playeruid = '%1'",str (_this select 0)])
		
	};
publicVariable "fnc_getRes_remote_code_40";
fnc_getRes_remote_code_41 = {
		
		("extDB3" callExtension format ["0:SQL:UPDATE shops_goods SET amount = %3 WHERE itemclass = '%1' AND shopclass = '%2'", str (_this select 0), str (_this select 1), _this select 2])
		
	};
publicVariable "fnc_getRes_remote_code_41";
fnc_getRes_remote_code_42 = {
		
		("extDB3" callExtension format ["0:SQL:UPDATE shops_goods SET amount = %3 WHERE itemclass = '%1' AND shopclass = '%2'", str (_this select 0), str (_this select 1), _this select 2])
		
	};
publicVariable "fnc_getRes_remote_code_42";
fnc_getRes_remote_code_43 = {
			
		private ["_callshit"];
		
		_callshit = ["0:SQL:INSERT INTO wanted_list (playerid, playername, reasons, bounty) VALUES ('", str (_this select 0), "','", str (_this select 1), "','", _this select 2, "',", _this select 3, ")"] joinString "";
						
		("extDB3" callExtension _callshit)
			
	};
publicVariable "fnc_getRes_remote_code_43";
fnc_getRes_remote_code_44 = {
			
		private ["_callshit"];
		
		_callshit = format ["0:SQL:DELETE FROM wanted_list WHERE playerid = '%1'",str (_this select 0)];
			
		("extDB3" callExtension _callshit)
			
	};
publicVariable "fnc_getRes_remote_code_44";
fnc_getRes_remote_code_45 = {
		
		//copyToClipboard str (format ["0:SQL:SELECT classname,regplate,damage,fuel,upgrade_data,items,itemscargo,magazinescargo From vehicles WHERE owner = '%1' AND garage = '%2'", str (_this select 0), str (_this select 1)]);
		
		("extDB3" callExtension format ["0:SQL:SELECT classname,regplate,damage,fuel,upgrade_data,items,itemscargo,magazinescargo,owner From vehicles WHERE owner = '%1' AND garage = '%2'", str (_this select 0), str (_this select 1)])
		
	};
publicVariable "fnc_getRes_remote_code_45";
fnc_getRes_remote_code_46 = {
				
				("extDB3" callExtension format ["0:SQL:DELETE FROM vehicles WHERE regplate = %1", _this select 0])
				
			};
publicVariable "fnc_getRes_remote_code_46";
