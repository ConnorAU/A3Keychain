#include "_defines.inc"
/* ----------------------------------------------------------------------------
Project:
	https://github.com/ConnorAU/A3Keychain

Author:
	ConnorAU - https://github.com/ConnorAU

Description:
	Initialises functions in uiNamespace so the addon still works
	when no world is loaded

Parameters:
	None

Return:
	Nothing
---------------------------------------------------------------------------- */

with uiNamespace do {

	FUNC(RscDisplayA3KeychainManager) = compileFinal preprocessFileLineNumbers "\cau\a3keychain\RscDisplayA3KeychainManager.sqf";
	FUNC(RscDisplayPassword) = compileFinal preprocessFileLineNumbers "\cau\a3keychain\RscDisplayPassword.sqf";
	//diag_log text "A3Keychain functions initialised";

	[] call compileFinal preprocessFileLineNumbers "\cau\a3keychain\validate.sqf";
	//diag_log text "A3Keychain saved data validated";

};

nil
