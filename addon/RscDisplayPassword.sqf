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

		// Apply existing password
		private _okayButton = _display displayCtrl 1;
		_okayButton ctrlAddEventHandler ["ButtonClick",{["onButtonClick",_this] call A3Keychain_fnc_RscDisplayPassword}];

		private _valuePassword = _display displayCtrl 101;
		_valuePassword ctrlSetText (profileNamespace getVariable ["A3Keychain_savedPassword."+_selectedServer,""]);

	};
	case "onButtonClick": {
		
		// Save password
		private _valuePassword = (ctrlparent _display) displayCtrl 101;
		profileNamespace setVariable ["A3Keychain_savedPassword."+_selectedServer,ctrlText _valuePassword];
		saveProfileNamespace;

	};
};