
waitUntil {!isNil "blood_array"};
psiloeffect = ppEffectCreate ["colorCorrections", 1501];
lsdeffect = ppEffectCreate ["colorCorrections", 1502];
lsdcamera = false;
opiumeffect = ppEffectCreate ["colorCorrections", 1503];
cannabiseffect = ppEffectCreate ["colorCorrections", 1504];
mdmaeffect = ppEffectCreate ["colorCorrections", 1505];
ampheffect = ppEffectCreate ["colorCorrections", 1506];
while {true} do {
		
	if !isdead then {
		
		_blood_stuff = (blood_array select 0);
		_blood_amounts = (blood_array select 1);
		
		if ("amph" in _blood_stuff) then {
						
			private ["_level","_rate"];
			
			_level = _blood_amounts select (_blood_stuff find "amph");
			
			_rate = _level/300;
						
			if (_rate>1) then {_rate=1};
		
			ampheffect ppEffectEnable true;
			ampheffect ppEffectAdjust [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [0.7*_rate, 0.7*_rate, 0, 1-0.5*_rate],  [1, 1, 1, 0]];
			ampheffect ppEffectCommit 1;
			
			if (_rate>0.1) then {
				player enableFatigue false;
			} else {
				player enableFatigue true;
			};
			
			//addCamShake [2*_rate, 3, 0];
			
		} else {
			
			if (ppEffectEnabled ampheffect) then {
			
				ampheffect ppEffectAdjust [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [1, 1, 1, 1],  [0.299, 0.587, 0.114, 0]];
				ampheffect ppEffectCommit 1;
				[] spawn {
					sleep 1;
					player enableFatigue true;
					ampheffect ppEffectEnable false;
				};
			
			};
			
		};
		
		if ("mdma" in _blood_stuff) then {
						
			private ["_level","_rate"];
			
			_level = _blood_amounts select (_blood_stuff find "mdma");
			
			_rate = _level/300;
						
			if (_rate>1) then {_rate=1};
		
			mdmaeffect ppEffectEnable true;
			mdmaeffect ppEffectAdjust [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [_rate, 0, _rate, 1-_rate],  [_rate, _rate, _rate, 0]];
			mdmaeffect ppEffectCommit 1;
			
			if (_rate>0.4) then {
				player enableFatigue false;
			} else {
				player enableFatigue true;
			};
			
			//addCamShake [2*_rate, 3, 0];
			
		} else {
			
			if (ppEffectEnabled mdmaeffect) then {
			
				mdmaeffect ppEffectAdjust [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [1, 1, 1, 1],  [0.299, 0.587, 0.114, 0]];
				mdmaeffect ppEffectCommit 1;
				[] spawn {
					sleep 1;
					player enableFatigue true;
					mdmaeffect ppEffectEnable false;
				};
			
			};
			
		};
		
		if ("cannabis" in _blood_stuff) then {
						
			private ["_level","_rate"];
			
			_level = _blood_amounts select (_blood_stuff find "cannabis");
			
			_rate = _level/300;
						
			if (_rate>1) then {_rate=1};
		
			cannabiseffect ppEffectEnable true;
			cannabiseffect ppEffectAdjust [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [1, 1, 1, 1+8*_rate],  [0, _rate, 0, 0]];
			cannabiseffect ppEffectCommit 1;
			
			addCamShake [2*_rate, 3, 0];
			
		} else {
			
			if (ppEffectEnabled cannabiseffect) then {
			
				cannabiseffect ppEffectAdjust [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [1, 1, 1, 1],  [0.299, 0.587, 0.114, 0]];
				cannabiseffect ppEffectCommit 1;
				[] spawn {
					sleep 1;
					cannabiseffect ppEffectEnable false;
				};
			
			};
			
		};
		
		if ("opium" in _blood_stuff) then {
						
			private ["_level","_rate"];
			
			_level = _blood_amounts select (_blood_stuff find "opium");
			
			_rate = _level/300;
			
			if (_rate>1.5) then {
				
				if ((random 1)>0.5) then {
					
					player setDamage 1;
					
				};
				
			};
			
			if (_rate>1) then {_rate=1};
		
			opiumeffect ppEffectEnable true;
			opiumeffect ppEffectAdjust [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [1, 1, 1, 1-_rate],  [0.299, 0.587, 0.114, 0]];
			opiumeffect ppEffectCommit 1;
			
			if (_rate>0.35) then {
				
				if ((lifeState player) != "INCAPACITATED") then {
					10 spawn {
						player setUnconscious true;
						sleep _this;
						player setUnconscious false;
						player playMove "amovppnemstpsraswrfldnon";
					};
				};
				
			};
			
			addCamShake [20*_rate, 3, 0];
			
		} else {
			
			if (ppEffectEnabled opiumeffect) then {
			
				opiumeffect ppEffectAdjust [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [1, 1, 1, 1],  [0.299, 0.587, 0.114, 0]];
				opiumeffect ppEffectCommit 1;
				[] spawn {
					sleep 1;
					opiumeffect ppEffectEnable false;
				};
			
			};
			
		};
		
		if ("lsd" in _blood_stuff) then {
						
			private ["_level","_rate"];
			
			_level = _blood_amounts select (_blood_stuff find "lsd");
			
			_rate = _level/300;
			
			if (_rate>1) then {_rate=1};
		
			lsdeffect ppEffectEnable true;
			lsdeffect ppEffectAdjust [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [random 3, random 3, random 3, 5*_rate],  [0, random 1, random 1, 0]];
			lsdeffect ppEffectCommit 1;
			
			if (_rate>0.25) then {
				
				if (((vehicle player)==player) and ((speed player) > 10)) then {
					
					if ((lifeState player) != "INCAPACITATED") then {
						((5+(random 3))*_rate) spawn {
							player setUnconscious true;
							sleep _this;
							player setUnconscious false;
							player playMove "amovppnemstpsraswrfldnon";
						};
					};		
					
				};
				
			};
			
			
			if (_rate>0.5) then {
				
				if ((random 1) > 0.9) then {
					
					if !lsdcamera then {
						
						lsdcamera = true;
					
						[] spawn {
							
							private ["_camera"];
							
							_camera = "camera" camCreate [(getPos player) select 0, (getPos player) select 1, ((getPos player) select 2)+2];
							_camera cameraeffect ["internal", "back"];
							showcinemaBorder false;
							_camera camCommand "inertia on";
							_camera camSetPos [(getPos player) select 0, (getPos player) select 1, ((getPos player) select 2)+10];
							_camera camSetFov 8.5;
							_camera camCommit 5;
							
							_camera camSetTarget [random 20000, random 20000, random 3];
							_camera camCommit 1;
							
							sleep 5;
							
							camDestroy _camera;
							_camera cameraEffect ["terminate", "back"];
							
							sleep 3;
							
							lsdcamera = false;
							
						};
					
					};
					
				};
				
			};
			
			//addCamShake [100*_rate, 3, 0];
			
		} else {
			
			if (ppEffectEnabled lsdeffect) then {
			
				lsdeffect ppEffectAdjust [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [1, 1, 1, 1],  [0.299, 0.587, 0.114, 0]];
				lsdeffect ppEffectCommit 1;
				[] spawn {
					sleep 1;
					lsdeffect ppEffectEnable false;
				};
			
			};
			
		};
		
		if ("psilo" in _blood_stuff) then {
						
			private ["_level","_rate"];
			
			_level = _blood_amounts select (_blood_stuff find "psilo");
			
			_rate = _level/300;
			
			if (_rate>1) then {_rate=1};
		
			psiloeffect ppEffectEnable true;
			psiloeffect ppEffectAdjust [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [random 2, random 2, random 2, 5*_rate],  [1, 0, 0, 0]];
			psiloeffect ppEffectCommit 1;
			
			//addCamShake [100*_rate, 3, 0];
			
		} else {
			
			if (ppEffectEnabled psiloeffect) then {
			
				psiloeffect ppEffectAdjust [1, 1, 0, [0.0, 0.0, 0.0, 0.0], [1, 1, 1, 1],  [0.299, 0.587, 0.114, 0]];
				psiloeffect ppEffectCommit 1;
				[] spawn {
					sleep 1;
					psiloeffect ppEffectEnable false;
				};
				
			};
			
		};
		//"psiloeffect" ppEffectAdjust [1, 1, 0, [1, 0.0, 0.0, 0.0], [1, 0.6, 0.6, 0.7],  [1, 0.587, 0.114, 0.0]];
		//"psiloeffect" ppEffectCommit 0;
		
		if ("alcohol" in _blood_stuff) then {
			
			private ["_level","_rate"];
			
			_level = _blood_amounts select (_blood_stuff find "alcohol");
			
			_rate = _level/500; //500мл чистого спирта - смертельная доза типа. условно _level/100 = икс промилле
			
			if (_rate > 1) then {
				
				if (random 1 > 0.95) then {player setDamage 1;};
				
			};
			
			if (_rate > 0.6) then {
				
				if (((random 1)+0.75) < _rate) then {
					
					if ((lifeState player) != "INCAPACITATED") then {
						((5+(random 3))*_rate) spawn {
							player setUnconscious true;
							sleep _this;
							player setUnconscious false;
							player playMove "amovppnemstpsraswrfldnon";
						};
					};					
				};
				
				if (((vehicle player)==player) and ((speed player) > 10)) then {
					
					if ((lifeState player) != "INCAPACITATED") then {
						((5+(random 3))*_rate) spawn {
							player setUnconscious true;
							sleep _this;
							player setUnconscious false;
							player playMove "amovppnemstpsraswrfldnon";
						};
					};		
					
				};
				
			};
			
			addCamShake [100*_rate, 3, 0];
			
		};
		
		//удаляем из крови
		
		private ["_deleteArray"];
			
		_deleteArray = [];
			
		{
				
			if (_x>=1) then {
					
				(blood_array select 1) set [_forEachIndex, _x-1];
					
			} else {
					
				_deleteArray pushBack _forEachIndex;
					
			};
				
		} forEach (blood_array select 1);
			
		{
			(blood_array select 0) deleteAt _x;
			(blood_array select 1) deleteAt _x;		
				
		} forEach _deleteArray;
		
		player setVariable ["blood_array",blood_array,true];
		
	};
		
	sleep 1;
};
