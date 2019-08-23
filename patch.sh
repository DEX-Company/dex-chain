#!/bin/sh

RETRY_COUNT=0
COMMAND_STATUS=1

printf '\n\e[33m◯ Waiting for contracts to be generated...\e[0m\n'

if [ "${LOCAL_CONTRACTS}" = "true" ]; then
	until [ $COMMAND_STATUS -eq 0 ] || [ $RETRY_COUNT -eq 120 ]; do
	    if [ -f "/usr/local/keeper-contracts/ready" ]; then
	        COMMAND_STATUS=0
		break
	    fi
	    sleep 5
	    (( RETRY_COUNT=RETRY_COUNT+1 ))
	done
fi
./node_modules/.bin/truffle migrate --reset --compile-all --artifacts
touch "/usr/local/keeper-contracts/ready-purchase"