PREPARE[PROJECT]="mst_itb"
PREPARE[db_name]="db"
PREPARE[db_driver]="mysqli"
PREPARE[db_host]="db"
PREPARE[db_password]="db"
PREPARE[db_port]="3306"
PREPARE[db_user]="db"
PREPARE[sitename]="mst_itb"
PREPARE[trustedHostsPattern]="\.*"
PREPARE[URL]="michaelstein-itb.de"
PREPARE[HT_USER]="dev"
PREPARE[HT_PASS]="elopment"

PREPARE[PORJECT_PATH]=$(pwd)/testbench
PREPARE[encryptionKey]=$(hexdump -vn32 -e'4/8 "%08X" 1 "\n"' /dev/urandom)