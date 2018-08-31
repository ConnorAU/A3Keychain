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
	case "onLoad": {
		["onLoad",_params,"RscDisplayLoading",'GUI'] call (uinamespace getvariable 'BIS_fnc_initDisplay');

		// For some reason when exiting an MP lobby the displays don't retain their event handlers.
		// This will close the server browser when you're loading into the mp lobby so when you leave
		// it will take you back to the main menu where you can properly load the browser again.
		private _browserDisplay = uiNamespace getVariable ["RscDisplayMultiplayer",findDisplay 8];
		if (!isNull _browserDisplay) then {
			_browserDisplay closeDisplay 2;
		};
	};
};