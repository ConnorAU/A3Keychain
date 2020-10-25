#include "_defines.inc"
/* ----------------------------------------------------------------------------
Project:
	https://github.com/ConnorAU/A3Keychain

Author:
	ConnorAU - https://github.com/ConnorAU

Function:
	CAU_A3Keychain_fnc_RscDisplayPassword

Description:
	Autofills saved password and captures new password

Parameters:
	_mode   : STRING - Subfunction name
	_params : ANY    - Subfunction arguments

Return:
	Nothing
---------------------------------------------------------------------------- */

disableSerialization;
params [["_mode","",[""]],["_params",[]]];

_params params ["_ctrlEvent"];
private _display = ctrlParent _ctrlEvent;

private _sessionDisplay = uinamespace getVariable ["RscDisplayMultiplayer",findDisplay 8];
private _sessionList = _sessionDisplay displayCtrl 102;
private _selectedServer = _sessionList lbData (lbCurSel _sessionList);

switch _mode do {
	case "onLoad": {

		// Add saving event
		private _okayButton = _display displayCtrl 1;
		_okayButton ctrlAddEventHandler ["ButtonClick",{
			with uiNamespace do {["onButtonClick",_this] call FUNC(RscDisplayPassword)};
		}];

		// Apply existing password
		private _savedData = profileNamespace getVariable ["A3Keychain_savedPassword|"+_selectedServer,[]];
		_savedData params ["",["_password","",[""]]];

		private _valuePassword = _display displayCtrl 101;
		_valuePassword ctrlSetText _password;
		_valuePassword ctrlSetTextSelection [count _password,0];

	};
	case "onButtonClick": {

		// Save password
		private _valuePassword = _display displayCtrl 101;
		private _password = ctrlText _valuePassword;

		private _valueServerName = _sessionDisplay displayCtrl 129;
		private _serverName = ctrlText _valueServerName;

		if (_password == "") then {
			profileNamespace setVariable ["A3Keychain_savedPassword|"+_selectedServer,nil];
		} else {
			profileNamespace setVariable ["A3Keychain_savedPassword|"+_selectedServer,["v1.1",_password,_serverName]];
		};
		saveProfileNamespace;

	};
};

nil
