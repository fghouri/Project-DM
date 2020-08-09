#include <YSI_Coding\y_hooks>

new MySQL:db;

#define HOST        "localhost"
#define USER        "root"
#define PW          ""
#define DATABASE    "DM_SERVER"

hook OnGameModeInit()
{
    db = mysql_connect(HOST, USER, PW, DATABASE);

    if(mysql_errno(db) != 0)
    {
        print("[MYSQL] Couldnt connect to database");
    }
    else
    {
        print("[MYSQL] Connection established");
    }
}