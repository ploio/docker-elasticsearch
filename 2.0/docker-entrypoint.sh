#!/bin/bash

set -e

# Add elasticsearch as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- elasticsearch "$@"
fi

# Drop root privileges if we are running elasticsearch
if [ "$1" = 'elasticsearch' ]; then
	# Change the ownership
	mkdir -p /var/lib/elasticsearch
	mkdir -p /var/log/elasticsearch
	chown -R elasticsearch:elasticsearch /var/lib/elasticsearch
	chown -R elasticsearch:elasticsearch /var/log/elasticsearch
	chown -R elasticsearch:elasticsearch /usr/share/elasticsearch
	exec gosu elasticsearch "$@"
fi

# As argument is not related to elasticsearch,
# then assume that user wants to run his own process,
# for example a `bash` shell to explore this image
exec "$@"
