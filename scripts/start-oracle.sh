#!/bin/bash

# Variables
ORACLE_ENV=XE 

# Show errors
check_error() {
    echo "Erro: $1"
    exit 1
}

# Access host as oracle
sudo su - oracle -c '

# Run "oraenv" command
. oraenv <<< $ORACLE_ENV

# Access with SQLPlus
sqlplus / as sysdba << EOF

-- Start db
startup;
exit;
EOF

'

# Check sqlplus output status
sqlplus_status=$?

# Check error on db access
if [ $sqlplus_status -ne 0 ]; then
    check_error "Error starting up db."
fi

echo "Successfully started Oracle DB."

