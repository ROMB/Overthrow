private _type = _this select 0;
private _found = "";
private _possible = [];
{
	private _d = warehouse getvariable [_x,[_x,0]];
	if(typename _d == "ARRAY") then {
		private _cls = _d select 0;
		private _num = _d select 1;
		if(!isNil "_num") then {
			if(typename _num == "SCALAR") then {
				if(_num > 0) then {
					private _weapon = [_cls] call BIS_fnc_itemType;
					private _weaponType = _weapon select 1;
					if(_weaponType == "AssaultRifle" and (_cls find "_GL_") > -1) then {_weaponType = "GrenadeLauncher"};
					if(_weaponType == _type) then {_possible pushback _cls};
				};
			};
		}else{
			warehouse setvariable [_x,nil,true];
		};
	};
}foreach(allvariables warehouse);

if(count _possible > 0) then {
	_sorted = [_possible,[],{(cost getvariable [_x,[200]]) select 0},"DESCEND"] call BIS_fnc_SortBy;
	_found = _sorted select 0;
};

_found
