#!/bin/bash

# Fetch DomU Xen domain identifier
DOMU_ID="";

while [ "$DOMU_ID" == "" ]; do
    DOMU_ID=$(xl list | awk '{ if ($1 == "DomU") print $2 }');

    if [ "$DOMU_ID" = "" ]; then
        sleep 1
    else
        echo "Parsed DOMU_ID is '${DOMU_ID}'";
    fi
done

XS_PATH="/local/domain/$DOMU_ID"

# Fetch first availability of the parameter
until xenstore-read $XS_PATH; do
    sleep 1
done

echo "Domain 'DomU' has become available.";

while true; do
    # Wait for the change in the parameters tree
    xenstore-watch -n2 $XS_PATH > /dev/null;

    if ! xenstore-read $XS_PATH; then
        echo "Domain 'DomU' with id '${DOMU_ID}' has become unavailable. \
Failing to notify dependent services. Will be restarted soon ...";
        exit 1;
    fi
done