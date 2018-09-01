/*──────────────────────────────────────────────────────┐
│   Author: Connor                                      │
│   Steam:  https://steamcommunity.com/id/_connor       │
│   Github: https://github.com/ConnorAU                 │
│                                                       │
│   Please do not modify or remove this comment block   │
└──────────────────────────────────────────────────────*/

// Don't need to run this more than once per session
if (uiNamespace getVariable ["A3Keychain_variablesValidated",false]) exitwith {};

// The purpose of this is to update old saved data if the saving format is changed
private _savedData = (allVariables profileNamespace) select {["A3Keychain_savedPassword",_x] call BIS_fnc_inString};

private ["_saveData","_serverAddress"];
{
	_saveData = profileNamespace getVariable [_x,[]];
	profileNamespace setVariable [_x,nil];
	_serverAddress = _x select [25]; // prefix + delimiter

	// Fixing v1.0 storage, didn't expect people to like this so didn't plan for the future :(
	if (_saveData isEqualType "") then {
		_saveData = ["v1.0",_saveData];
	};

	_saveData params [["_version","",[""]],["_password","",[""]],["_serverName","",[""]]];

	if (_password != "") then {
		profileNamespace setVariable ["A3Keychain_savedPassword|"+_serverAddress,["v1.1",_password,_serverName]];
	};
} foreach _savedData;

saveProfileNamespace;
uiNamespace setVariable ["A3Keychain_variablesValidated",true];