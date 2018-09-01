/*──────────────────────────────────────────────────────┐
│   Author: Connor                                      │
│   Steam:  https://steamcommunity.com/id/_connor       │
│   Github: https://github.com/ConnorAU                 │
│                                                       │
│   Please do not modify or remove this comment block   │
└──────────────────────────────────────────────────────*/

class CfgPatches {
    class A3Keychain {
        author="Connor";
        requiredAddons[]={"A3_Ui_F"};
      
        units[]={};
        weapons[]={};
    };
};
class CfgFunctions {
    class A3Keychain {
        class script {
            class validate {
                file="A3Keychain\validate.sqf";
                preinit=1;
            };

            class RscDisplayA3KeychainManager {
                file="A3Keychain\RscDisplayA3KeychainManager.sqf";
            };
            class RscDisplayClient {
                file="A3Keychain\RscDisplayClient.sqf";
            };
            class RscDisplayPassword {
                file="A3Keychain\RscDisplayPassword.sqf";
            };
        };
    };
};

// Override onLoad events
class RscDisplayClient {
    onLoad="['onLoad',_this] call A3Keychain_fnc_RscDisplayClient";
};
class RscDisplayPassword {
    onLoad="['onLoad',_this] call A3Keychain_fnc_RscDisplayPassword";
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
					onbuttonclick="(findDisplay 0) createDisplay 'RscDisplayA3KeychainManager';";
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
class RscDisplayA3KeychainManager {
    idd=-1;
    onLoad="['onLoad',_this] call A3Keychain_fnc_RscDisplayA3KeychainManager";
    onUnload="['onUnload',_this] call A3Keychain_fnc_RscDisplayA3KeychainManager";

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
            text="Workshop";
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
            text="Remove";
            tooltip="Remove the selected password";

            x="((safezoneX+(0.5*safezoneW))-(0.5*(220*(pixelW*pixelGrid*0.50)))) + (2*(pixelW*pixelGrid*0.50)) + (((4.5*(((((safezoneW/safezoneH)min 1.2)/1.2)/25)*1)))*2)";
        };
        class returnButton: revealButton {
            idc=6;
            default=1;
            text="Return";
            tooltip="Return to the main menu";

            x="((safezoneX+(0.5*safezoneW))-(0.5*(220*(pixelW*pixelGrid*0.50)))) + (220*(pixelW*pixelGrid*0.50)) - ((4.5*(((((safezoneW/safezoneH)min 1.2)/1.2)/25)*1)))";
        };
    };
};
