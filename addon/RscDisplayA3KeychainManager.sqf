#include "_defines.inc"
/* ----------------------------------------------------------------------------
Project:
	https://github.com/ConnorAU/A3Keychain

Author:
	ConnorAU - https://github.com/ConnorAU

Function:
	CAU_A3Keychain_fnc_RscDisplayA3KeychainManager

Description:
	Handles all tasks related to the password manager UI

Parameters:
	_mode   : STRING - Subfunction name
	_params : ANY    - Subfunction arguments

Return:
	Nothing
---------------------------------------------------------------------------- */

disableSerialization;
params [["_mode","",[""]],["_params",[]]];

switch _mode do {
	case "onLoad":{
		_params params ["_display"];

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
			_revealButton ctrlAddEventHandler ["ButtonClick",{
				with uiNamespace do {["revealButton",_this] call FUNC(RscDisplayA3KeychainManager)};
			}];
		};

		_removeButton ctrlAddEventHandler ["ButtonClick",{
			with uiNamespace do {["removeButton",_this] call FUNC(RscDisplayA3KeychainManager)};
		}];
		_returnButton ctrlAddEventHandler ["ButtonClick",{(ctrlParent(_this#0)) closeDisplay 2}];

		// Load saved passwords
		["loadSavedPasswords",[_display]] call FUNC(RscDisplayA3KeychainManager);
	};
	case "onUnload":{
		saveProfileNamespace;
	};
	case "loadSavedPasswords":{
		_params params ["_display"];
		private _list = _display displayCtrl 3;

		lnbClear _list;
		_list lnbAddRow ["Server Name","Address","Password"];

		private _savedData =  allVariables profileNamespace select {toLower _x find "a3keychain_savedpassword" == 0} apply {
			private _saveData = profileNamespace getVariable [_x,[]];
			[_saveData#2,_x,_saveData#1]
		};
		_savedData sort true;

		private _showPassword = _display getVariable ["A3Keychain_showPasswords",false];
		{
			_x params ["_name","_address","_password"];
			_list lnbAddRow [
				[_name,"Unknown Server Name"] select (_name == ""),
				_address select [25],
				["********",_password] select _showPassword
			];
			_list lnbSetData [[_forEachIndex + 1,0],_address];
		} foreach _savedData;
	};
	case "revealButton":{
		_params params ["_ctrl"];
		private _display = ctrlParent _ctrl;

		_ctrl ctrlEnable false;
		_ctrl ctrlSetTooltip "";
		_display setVariable ["A3Keychain_showPasswords",true];

		["loadSavedPasswords",[_display]] call FUNC(RscDisplayA3KeychainManager);
	};
	case "removeButton":{
		_params params ["_ctrl"];
		private _display = ctrlParent _ctrl;
		private _list = _display displayCtrl 3;

		private _selectedIndex = lnbCurSelRow _list;
		private _selectedPassword = _list lnbData [_selectedIndex,0];
		if (_selectedPassword != "") then {
			profileNamespace setVariable [_selectedPassword,nil];
			_list lnbDeleteRow _selectedIndex
		};
	};
};

nil
