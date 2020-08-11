#include <YSI_Coding\y_hooks>

new Float:spawn_pos[3] = {1958.3783, 1343.1572, 15.3746};


hook OnGameModeInit()
{
    AddPlayerClass(230, spawn_pos[0], spawn_pos[1], spawn_pos[2], 10.0, 24, 1000, 25, 1000, 34, 1000);
    AddPlayerClass(38, spawn_pos[0], spawn_pos[1], spawn_pos[2], 10.0, 24, 1000, 25, 1000, 34, 1000);
    AddPlayerClass(53, spawn_pos[0], spawn_pos[1], spawn_pos[2], 10.0, 24, 1000, 25, 1000, 34, 1000);
    AddPlayerClass(136, spawn_pos[0], spawn_pos[1], spawn_pos[2], 10.0, 24, 1000, 25, 1000, 34, 1000);
    AddPlayerClass(137, spawn_pos[0], spawn_pos[1], spawn_pos[2], 10.0, 24, 1000, 25, 1000, 34, 1000);
    return 1;
}
