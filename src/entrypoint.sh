#!/bin/bash -e

# Make sure shared memory requirements are met.
shm_size=$(df -P /dev/shm | grep -v Filesystem | awk '{print $2}')

if [ "$shm_size" -lt 1048576 ]; then
    cat <<EOF
The container for AllegroGraph must be started with a shared memory size larger than 1 GB (e.g. by using option --shm-size 1g)!
EOF
    exit 1
fi

function terminate {
    echo Shutting down AllegroGraph
    ${BWPGER_AGRAPH_BINDIR}/agraph-control --config ${BWPGER_AGRAPH_CONFIGFILE} stop
    exit 0
}

trap "echo Caught signal; terminate" SIGINT SIGTERM SIGQUIT

# Start AllegroGraph daemon
${BWPGER_AGRAPH_BINDIR}/agraph-control --config ${BWPGER_AGRAPH_CONFIGFILE} start

# Monitor the logfile.
# This pattern (& to put the process in the background and
# then blocking using 'wait') appears to be the most reliable
# way of getting bash to respond to signals.
tail -f ${BWPGER_AGRAPH_LOGIFLE} &
wait $!
