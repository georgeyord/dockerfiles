#!/bin/bash
set -e

if [ -z "$MYSQL_PORT_3306_TCP_ADDR" ]; then
	echo >&2 'error: missing MYSQL_PORT_3306_TCP environment variable'
	echo >&2 '  Did you forget to --link some_mysql_container:mysql ?'
	exit 1
fi

# if we're linked to MySQL, and we're using the root user, and our linked
# container has a default "root" password set up and passed through... :)
: ${ETHERPAD_DB_USER:=root}
if [ "$ETHERPAD_DB_USER" = 'root' ]; then
	: ${ETHERPAD_DB_PASSWORD:=$MYSQL_ENV_MYSQL_ROOT_PASSWORD}
fi
: ${ETHERPAD_DB_NAME:=etherpad}

ETHERPAD_DB_NAME=$( echo $ETHERPAD_DB_NAME | sed 's/\./_/g' )

if [ -z "$ETHERPAD_DB_PASSWORD" ]; then
	echo >&2 'error: missing required ETHERPAD_DB_PASSWORD environment variable'
	echo >&2 '  Did you forget to -e ETHERPAD_DB_PASSWORD=... ?'
	echo >&2
	echo >&2 '  (Also of interest might be ETHERPAD_DB_USER and ETHERPAD_DB_NAME.)'
	exit 1
fi

ETHERPAD_DB_HOST="${MYSQL_PORT_3306_TCP_ADDR}"

: ${ETHERPAD_TITLE:=Etherpad}
: ${ETHERPAD_SESSION_KEY:=$(
		node -p "require('crypto').randomBytes(32).toString('hex')")}

###########################################################
# Wait for mysql server to start (max 120 seconds)
DB_TIMEOUT=120
DB_TIMEOUT_STEP=5
echo "mysql -u${ETHERPAD_DB_USER} -p${ETHERPAD_DB_PASSWORD} -h${ETHERPAD_DB_HOST} --skip-column-names -e 'SELECT 1;'"
while ! mysql -u${ETHERPAD_DB_USER} -p${ETHERPAD_DB_PASSWORD} -h${ETHERPAD_DB_HOST} --skip-column-names -e 'SELECT 1;' >/dev/null 2>&1
do
    DB_TIMEOUT=$(expr $DB_TIMEOUT - $DB_TIMEOUT_STEP)
    if [ $DB_TIMEOUT -eq 0 ]; then
        echo "Timeout error occurred trying to start MySQL Daemon."
        exit 1
    fi
    sleep $DB_TIMEOUT_STEP
done
###########################################################

# Check if database already exists
RESULT=`mysql -u${ETHERPAD_DB_USER} -p${ETHERPAD_DB_PASSWORD} \
	-h${ETHERPAD_DB_HOST} --skip-column-names \
	-e "SHOW DATABASES LIKE '${ETHERPAD_DB_NAME}'"`

if [ "$RESULT" != $ETHERPAD_DB_NAME ]; then
	# mysql database does not exist, create it
	echo "Creating database ${ETHERPAD_DB_NAME}"

	mysql -u${ETHERPAD_DB_USER} -p${ETHERPAD_DB_PASSWORD} \
	      -h${ETHERPAD_DB_HOST} \
	      -e "create database ${ETHERPAD_DB_NAME}"
fi

cat << EOF > settings.json
{
  "title": "${ETHERPAD_TITLE}",
  "ip": "0.0.0.0",
  "port" : 9001,
  "sessionKey" : "${ETHERPAD_SESSION_KEY}",
  "dbType" : "mysql",
  "dbSettings" : {
                    "user"    : "${ETHERPAD_DB_USER}",
                    "host"    : "${ETHERPAD_DB_HOST}",
                    "password": "${ETHERPAD_DB_PASSWORD}",
                    "database": "${ETHERPAD_DB_NAME}"
                  },
EOF

if [ $ETHERPAD_ADMIN_PASSWORD ]; then
	: ${ETHERPAD_ADMIN_USER:=admin}

cat << EOF >> settings.json
  "users": {
    "${ETHERPAD_ADMIN_USER}": {
      "password": "${ETHERPAD_ADMIN_PASSWORD}",
      "is_admin": true
    }
  },
EOF

fi

if [ "$CODEPAD_ACTIVE" == 1 ]; then
	echo 'Codepad is active'
	cat << EOF >> settings.json
  "ep_codepad": {
    "project_path": "${CODEPAD_PROJECT_PATH}",
    "log_path": "${CODEPAD_LOG_PATH}",
    "play_url": "${CODEPAD_PLAY_URL}",
    "push_action": "${CODEPAD_PUSH_ACTION}"
  },
EOF
fi

cat << EOF >> settings.json
}
EOF

exec "$@"
