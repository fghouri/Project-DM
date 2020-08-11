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
        print("[MYSQL] Couldn't connect to database, Server has been locked due to false configurations.");
        szPW += RandomEx(1251, 5397);
        SetServerRule("password", sprintf("%d", szPW));
        printf("[FAIL-SAFE] --> Server password has been set to %i", szPW); 
    }
    else
    {
        print("[MYSQL] Connection established successfully.");
    }
    return 1;
}