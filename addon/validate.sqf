/* ----------------------------------------------------------------------------
Project:
	https://github.com/ConnorAU/A3Keychain

Author:
	ConnorAU - https://github.com/ConnorAU

Description:
	Validates saved password data

Parameters:
	None

Return:
	Nothing
---------------------------------------------------------------------------- */

// Don't need to run this more than once per session
if (uiNamespace getVariable ["A3Keychain_variablesValidated",false]) exitwith {};

// The purpose of this is to update old saved data if the saving format is changed
private _savedData = allVariables profileNamespace select {toLower _x find "a3keychain_savedpassword" == 0};

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

nil
