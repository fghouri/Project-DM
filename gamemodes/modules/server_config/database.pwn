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
        new szPW = 5;
        print("[MYSQL] Couldn't connect to database, Locking server.");
        szPW += RandomEx(1251, 5397);
        printf("[FAIL-SAFE] --> Server password has been set to %i", szPW); 
    }
    else
    {
        print("[MYSQL] Connection established");
    }
    return 1;
}