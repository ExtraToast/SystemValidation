#!/bin/bash

# Ensure nusmv is up (but don't attach)
docker compose up nusmv -d

# Execute the trivial case
docker compose exec nusmv bash /usr/src/error_case.sh