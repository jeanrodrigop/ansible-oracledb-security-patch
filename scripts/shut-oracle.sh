#!/bin/bash

# Variables
ORACLE_ENV=XE 

# Show errors
exibir_erro_sair() {
    echo "Erro: $1"
    exit 1
}

# Access host as oracle
sudo su - oracle -c '

# Run "oraenv" command
. oraenv <<< $ORACLE_ENV

# Access with SQLPlus
sqlplus / as sysdba << EOF

-- Shutdown db
shutdown immediate;
exit;
EOF

'

# Check sqlplus output status
sqlplus_status=$?

# Check error on db access
if [ $sqlplus_status -ne 0 ]; then
    check_error "Error shutting down db."
fi

echo "Successfully stopped Oracle DB."



