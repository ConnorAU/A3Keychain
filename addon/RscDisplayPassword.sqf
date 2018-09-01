/*──────────────────────────────────────────────────────┐
│   Author: Connor                                      │
│   Steam:  https://steamcommunity.com/id/_connor       │
│   Github: https://github.com/ConnorAU                 │
│                                                       │
│   Please do not modify or remove this comment block   │
└──────────────────────────────────────────────────────*/

disableSerialization;
params [["_mode","",[""]],["_params",[]]];
_params params [["_display",displayNull]];

private _sessionDisplay = uinamespace getVariable ["RscDisplayMultiplayer",displayNull];
private _sessionList = _sessionDisplay displayCtrl 102;
private _selectedServer = _sessionList lbData (lbCurSel _sessionList);

switch _mode do {
	case "onLoad": {

		// Arma stuff
		["onLoad",_params,"RscDisplayPassword",'GUI'] call (uinamespace getvariable 'BIS_fnc_initDisplay');

		// Add saving event
		private _okayButton = _display displayCtrl 1;
		_okayButton ctrlAddEventHandler ["ButtonClick",{["onButtonClick",_this] call A3Keychain_fnc_RscDisplayPassword}];

		// Apply existing password
		private _savedData = profileNamespace getVariable ["A3Keychain_savedPassword|"+_selectedServer,[]];
		private _password = _savedData param [1,"",[""]];

		private _valuePassword = _display displayCtrl 101;
		_valuePassword ctrlSetText _password;

	};
	case "onButtonClick": {
		
		// Save password
		_display = ctrlParent _display;
		private _valuePassword = _display displayCtrl 101;

		private _browserDisplay = uiNamespace getVariable ["RscDisplayMultiplayer",findDisplay 8];
		private _valueServerName = _browserDisplay displayCtrl 129;

		private _password = ctrlText _valuePassword;
		private _serverName = ctrlText _valueServerName;

		if (_password == "") then {
			profileNamespace setVariable ["A3Keychain_savedPassword|"+_selectedServer,nil];
		} else {
			profileNamespace setVariable ["A3Keychain_savedPassword|"+_selectedServer,["v1.1",_password,_serverName]];
		};
		saveProfileNamespace;

	};
};