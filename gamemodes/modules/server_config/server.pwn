/* ** Required Includes** */
#include <YSI_Coding\y_hooks>

/* ** Mandatory Defines ** */
#define SERVER_NAME "Project-DM - Under Development (0.3.7)"
#define GAMEMODE_TEXT "Deathmatch"


hook OnGameModeInit()
{
    SetGameModeText(GAMEMODE_TEXT);
    return 1;
}