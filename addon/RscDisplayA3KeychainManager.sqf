/*──────────────────────────────────────────────────────┐
│   Author: Connor                                      │
│   Steam:  https://steamcommunity.com/id/_connor       │
│   Github: https://github.com/ConnorAU                 │
│                                                       │
│   Please do not modify or remove this comment block   │
└──────────────────────────────────────────────────────*/

disableSerialization;
params [["_mode","",[""]],["_params",[]]];

switch _mode do {
	case "onLoad":{
		private _display = _params param [0,displayNull];

		// Set title bar text
		private _titleLeft = _display displayCtrl 1;
		private _titleRight = _display displayCtrl 2;

		_titleLeft ctrlSetText "A3Keychain Password Manager";
		if !isStreamFriendlyUIEnabled then {
			_titleRight ctrlSetText profileName;
		};

		// Set button events
		private _revealButton = _display displayCtrl 4;
		private _removeButton = _display displayCtrl 5;
		private _returnButton = _display displayCtrl 6;

		if isStreamFriendlyUIEnabled then {
			_revealButton ctrlEnable false;
			_revealButton ctrlSetTooltip "Cannot reveal passwords when stream friendly ui is enabled";
		} else {
			_revealButton ctrlAddEventHandler ["ButtonClick",{["revealButton",_this] call A3Keychain_fnc_RscDisplayA3KeychainManager}];
		};

		_removeButton ctrlAddEventHandler ["ButtonClick",{["removeButton",_this] call A3Keychain_fnc_RscDisplayA3KeychainManager}];
		_returnButton ctrlAddEventHandler ["ButtonClick",{(ctrlParent(_this select 0)) closeDisplay 2}];

		// Load saved passwords
		["loadSavedPasswords",[_display]] call A3Keychain_fnc_RscDisplayA3KeychainManager;
	};
	case "onUnload":{
		saveProfileNamespace;
	};
	case "loadSavedPasswords":{
		private _display = _params param [0,displayNull];
		private _list = _display displayCtrl 3;

		lnbClear _list;
		_list lnbAddRow ["Server Name","Address","Password"];

		private _savedData = (allVariables profileNamespace) select {["A3Keychain_savedPassword",_x] call BIS_fnc_inString} apply {
			private _saveData = profileNamespace getVariable [_x,[]];
			[_saveData select 2,_x,_saveData select 1]
		};
		_savedData sort true;

		private _showPassword = _display getVariable ["A3Keychain_showPasswords",false];
		{ 
			_x params ["_name","_address","_password"];
			_list lnbAddRow [
				[_name,"Unknown Server Name"] select (_name == ""),
				_address select [25],
				["????????",_password] select _showPassword
			];
			_list lnbSetData [[_forEachIndex + 1,0],_address];
		} foreach _savedData;
	};
	case "revealButton":{
		private _ctrl = _params param [0,controlNull];
		private _display = ctrlParent _ctrl;

		_ctrl ctrlEnable false;
		_ctrl ctrlSetTooltip "";
		_display setVariable ["A3Keychain_showPasswords",true];		

		["loadSavedPasswords",[_display]] call A3Keychain_fnc_RscDisplayA3KeychainManager;
	};
	case "removeButton":{
		private _ctrl = _params param [0,controlNull];
		private _display = ctrlParent _ctrl;
		private _list = _display displayCtrl 3;

		private _selectedPassword = _list lnbData [lnbCurSelRow _list,0];
		if (_selectedPassword != "") then {
			profileNamespace setVariable [_selectedPassword,nil];
			["loadSavedPasswords",[_display]] call A3Keychain_fnc_RscDisplayA3KeychainManager;
		};
	};
};