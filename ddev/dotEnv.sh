# Site name
TYPO3__DB__Connections__Default__dbname="PREPARE_dbname"
TYPO3__DB__Connections__Default__driver="PREPARE_driver"
TYPO3__DB__Connections__Default__host="PREPARE_host"
TYPO3__DB__Connections__Default__password="PREPARE_password"
TYPO3__DB__Connections__Default__port="PREPARE_port"
TYPO3__DB__Connections__Default__user="PREPARE_user"

TYPO3__SYS__sitename="PREPARE_sitename"

# processor - Possible Values: ImageMagick, GraphicsMagick
#TYPO3__GFX__processor="GraphicsMagick"
#TYPO3__GFX__processor_path="/usr/bin/"
#TYPO3__GFX__processor_colorspace="RGB"

# Secrets
#TYPO3__HTTP__verify="false"
TYPO3__SYS__encryptionKey="PREPARE_sitename"
TYPO3__BE__installToolPassword="PREPARE_installToolPassword" # joh316

# optional values
TYPO3__BE__adminOnly="0"

# Debug
TYPO3__FE__debug=1
TYPO3__BE__debug=1
TYPO3__SYS__devIPmask="*"
TYPO3__SYS__trustedHostsPattern="PREPARE_sitename"
TYPO3__SYS__displayErrors=1


# Mail

TYPO3__MAIL__defaultMailFromAddress=""
TYPO3__MAIL__defaultMailFromName=""
TYPO3__MAIL__transport="smtp"
TYPO3__MAIL__transport_smtp_password=''
TYPO3__MAIL__transport_smtp_server="localhost:1025"
TYPO3__MAIL__transport_smtp_username=""

###### frontend build
TYPO3_CLEARCACHECMD="ddev typo3cms cache:flush --group=pages"
TYPO3_CLEARALLCACHECMD="ddev typo3cms cache:flush"
BRWOSERSYNC_HOST="PREPARE_project"
BRWOSERSYNC_PORT="8082"
BRWOSERSYNC_PROXY="https://velo23.ddev.site/"

PHP="php"
BIN_COMPOSER="ddev composer"
BIN_T3CONSOLE="ddev typo3cms"
BIN_DB_IMPORT="ddev typo3cms database:import"

# Context
TYPO3_CONTEXT="Development/Ddev"
