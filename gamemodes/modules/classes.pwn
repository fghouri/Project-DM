#include <YSI_Coding\y_hooks>

new Float:spawn_pos[3] = {1959.9930, 1342.9177, 15.3746};


hook OnGameModeInit()
{
    AddPlayerClass(230, spawn_pos[0], spawn_pos[1], spawn_pos[2], 267.6761, 24, 1000, 25, 1000, 34, 1000);
    AddPlayerClass(38, spawn_pos[0], spawn_pos[1], spawn_pos[2], 267.6761, 24, 1000, 25, 1000, 34, 1000);
    AddPlayerClass(53, spawn_pos[0], spawn_pos[1], spawn_pos[2], 267.6761, 24, 1000, 25, 1000, 34, 1000);
    AddPlayerClass(136, spawn_pos[0], spawn_pos[1], spawn_pos[2], 267.6761, 24, 1000, 25, 1000, 34, 1000);
    AddPlayerClass(137, spawn_pos[0], spawn_pos[1], spawn_pos[2], 267.6761, 24, 1000, 25, 1000, 34, 1000);
    return 1;
}

hook OnPlayerRequestClass(playerid, classid)
{
    if(classid) {
    SetPlayerPos(playerid, spawn_pos[0], spawn_pos[1], spawn_pos[2]);
	SetPlayerFacingAngle(playerid, 90.4145);
	SetPlayerCameraPos(playerid,1962.5000,1343.0919,15.4823);
	SetPlayerCameraLookAt(playerid, spawn_pos[0], spawn_pos[1], spawn_pos[2]);
    }
    return 1;
}