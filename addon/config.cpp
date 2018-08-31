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
            class RscDisplayClient {
                file="A3Keychain\RscDisplayClient.sqf";
            };
            class RscDisplayPassword {
                file="A3Keychain\RscDisplayPassword.sqf";
            };
        };
    };
};
class RscDisplayClient {
    onLoad="['onLoad',_this] call A3Keychain_fnc_RscDisplayClient";
};
class RscDisplayPassword {
    onLoad="['onLoad',_this] call A3Keychain_fnc_RscDisplayPassword";
};