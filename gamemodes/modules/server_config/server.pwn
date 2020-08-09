/* ** Required Includes** */
#include <YSI_Coding\y_hooks>

/* ** Mandatory Defines ** */
#define SERVER_NAME         "Project-DM - Under Development (0.3.7)"
#define GAMEMODE_TEXT       "Deathmatch"
#define SERVER_LANGUAGE     "English"
#define MAP_NAME            "SF/LV/LS"
#define WEB_URL             "None"


hook OnGameModeInit()
{
    SetServerRule("hostname", SERVER_NAME);
    SetGameModeText(GAMEMODE_TEXT);
    SetServerRule("language", SERVER_LANGUAGE);
    SetServerRule("mapname", MAP_NAME);
    SetServerRule("weburl", WEB_URL);
    return 1;
}