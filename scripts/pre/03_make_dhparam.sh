#!/bin/bash
set -e

source "${EJABBERD_HOME}/scripts/lib/base_config.sh"
source "${EJABBERD_HOME}/scripts/lib/config.sh"
source "${EJABBERD_HOME}/scripts/lib/base_functions.sh"
source "${EJABBERD_HOME}/scripts/lib/functions.sh"

make_dhparam() {
	local dhfile=$1
	local bits=$2

	echo "Writing dh file to '${dhfile}'..."
	openssl dhparam -out ${dhfile} ${bits}
}

if [ -e ${CONFIGFILE} ]; then
    echo "Skipping dh param generation because ${CONFIGFILE} exists..."
    exit 0
fi

if is_true ${EJABBERD_DHPARAM} ; then
	file_exist ${SSLDHPARAM} \
		|| make_dhparam ${SSLDHPARAM} 4096
fi

exit 0
