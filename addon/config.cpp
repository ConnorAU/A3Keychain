class CfgPatches {
    class CAU_A3Keychain {
        author="ConnorAU";
        requiredAddons[]={"A3_Ui_F"};

        units[]={};
        weapons[]={};
    };
};

// Add onLoad event
class RscText;
class RscDisplayPassword {
	class controls {
		class CAU_A3Keychain_Events_Dummy: RscText {
			// Added to a control to avoid conflicts with other addons
    		onLoad="with uiNamespace do {['onLoad',_this] call CAU_A3Keychain_fnc_RscDisplayPassword}";
			show=0;

			x=0;
			y=0;
			w=0;
			h=0;
		};
	};
};

// Add options button
class RscButtonMenuMain;
class RscDisplayMain {
	class Controls {
        class GroupSingleplayer;
		class GroupOptions: GroupSingleplayer {
			h="(6 * 	1.5) * 	(pixelH * pixelGrid * 2)";
			class Controls {
				class A3Keychain: RscButtonMenuMain {
					idc=155551;
					text="A3Keychain";
					tooltip="Manage saved passwords";

					x=0;
					y="(5 * 	1.5) * 	(pixelH * pixelGrid * 2) + 	(pixelH)";
					w="10 * 	(pixelW * pixelGrid * 2)";
					h="1.5 * 	(pixelH * pixelGrid * 2) - 	(pixelH)";

					onload="call compile preprocessFileLineNumbers 'cau\a3keychain\initFunctions.sqf'";
					onbuttonclick="ctrlParent(_this#0) createDisplay 'RscDisplayA3KeychainManager';";
				};
			};
		};
    };
};

// Options UI
class RscTitle;
class RscListNBox;
class RscButtonMenu;
class RscButtonMenuSteam;
class RscDisplayEmpty;
class RscDisplayA3KeychainManager: RscDisplayEmpty {
    idd=-1;
    onLoad="with uiNamespace do {['onLoad',_this] call CAU_A3Keychain_fnc_RscDisplayA3KeychainManager}";
    onUnload="with uiNamespace do {['onUnload',_this] call CAU_A3Keychain_fnc_RscDisplayA3KeychainManager}";

    class controlsBackground {
        class titleTextLeft: RscTitle {
            idc=1;

            x="(safezoneX+(0.5*safezoneW))-(0.5*(220*(pixelW*pixelGrid*0.50)))";
            y="(safezoneY+(0.5*safezoneH))-(0.5*(80*(pixelH*pixelGrid*0.50)))- (((((safezoneW/safezoneH)min 1.2)/1.2)/25)*1) - (1*(pixelH*pixelGrid*0.50))";
            w="220*(pixelW*pixelGrid*0.50)";
            h="((((safezoneW/safezoneH)min 1.2)/1.2)/25)*1";

            colorBackground[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
        };
        class titleTextRight: titleTextLeft {
            idc=2;
            style=1;
            colorBackground[]={0,0,0,0};
        };
        class backgroundMain: titleTextLeft {
            idc=-1;

            y="(safezoneY+(0.5*safezoneH))-(0.5*(80*(pixelH*pixelGrid*0.50)))";
            h="80*(pixelH*pixelGrid*0.50)";

            colorBackground[]={0,0,0,0.7};
        };
        class backgroundList: backgroundMain {
            x="(safezoneX+(0.5*safezoneW))-(0.5*(220*(pixelW*pixelGrid*0.50)))+ 1*(pixelW*pixelGrid*0.50)";
            y="(safezoneY+(0.5*safezoneH))-(0.5*(80*(pixelH*pixelGrid*0.50)))+ 1*(pixelH*pixelGrid*0.50)";
            w="220*(pixelW*pixelGrid*0.50)- 2*(pixelW*pixelGrid*0.50)";
            h="80*(pixelH*pixelGrid*0.50)- 2*(pixelH*pixelGrid*0.50)";

            colorBackground[]={0.2,0.2,0.2,0.7};
        };
    };
    class controls {
        class list: RscListNBox {
            idc=3;

            x="(safezoneX+(0.5*safezoneW))-(0.5*(220*(pixelW*pixelGrid*0.50)))+ 1*(pixelW*pixelGrid*0.50)";
            y="(safezoneY+(0.5*safezoneH))-(0.5*(80*(pixelH*pixelGrid*0.50)))+ 1*(pixelH*pixelGrid*0.50)";
            w="220*(pixelW*pixelGrid*0.50)- 2*(pixelW*pixelGrid*0.50)";
            h="80*(pixelH*pixelGrid*0.50)- 2*(pixelH*pixelGrid*0.50)";

            columns[]={0,0.5,0.7};
            disableOverflow=1;
        };
        class workshopButton: RscButtonMenuSteam {
            idc=-1;
            text="$STR_WORKSHOP_BUTTON_GAME";
            url="https://steamcommunity.com/sharedfiles/filedetails/?id=1498586879";

            x="(safezoneX+(0.5*safezoneW))-(0.5*(220*(pixelW*pixelGrid*0.50)))";
            y="((safezoneY+(0.5*safezoneH))-(0.5*(80*(pixelH*pixelGrid*0.50)))) + (80*(pixelH*pixelGrid*0.50)) + (1*(pixelH*pixelGrid*0.50))";
            w="(4.5*(((((safezoneW/safezoneH)min 1.2)/1.2)/25)*1))";
            h="((((safezoneW/safezoneH)min 1.2)/1.2)/25)*1";
        };
        class revealButton: RscButtonMenu {
            idc=4;
            text="Reveal";
            tooltip="Reveal passwords in the list";

            x="((safezoneX+(0.5*safezoneW))-(0.5*(220*(pixelW*pixelGrid*0.50)))) + (1*(pixelW*pixelGrid*0.50)) + ((4.5*(((((safezoneW/safezoneH)min 1.2)/1.2)/25)*1)))";
            y="((safezoneY+(0.5*safezoneH))-(0.5*(80*(pixelH*pixelGrid*0.50)))) + (80*(pixelH*pixelGrid*0.50)) + (1*(pixelH*pixelGrid*0.50))";
            w="(4.5*(((((safezoneW/safezoneH)min 1.2)/1.2)/25)*1))";
            h="((((safezoneW/safezoneH)min 1.2)/1.2)/25)*1";
        };
        class removeButton: revealButton {
            idc=5;
            text="$STR_DISP_DELETE";
            tooltip="Delete the selected password";

            x="((safezoneX+(0.5*safezoneW))-(0.5*(220*(pixelW*pixelGrid*0.50)))) + (2*(pixelW*pixelGrid*0.50)) + (((4.5*(((((safezoneW/safezoneH)min 1.2)/1.2)/25)*1)))*2)";
        };
        class returnButton: revealButton {
            idc=6;
            default=1;
            text="$STR_DISP_CLOSE";
            tooltip="Return to the main menu";

            x="((safezoneX+(0.5*safezoneW))-(0.5*(220*(pixelW*pixelGrid*0.50)))) + (220*(pixelW*pixelGrid*0.50)) - ((4.5*(((((safezoneW/safezoneH)min 1.2)/1.2)/25)*1)))";
        };
    };
};
