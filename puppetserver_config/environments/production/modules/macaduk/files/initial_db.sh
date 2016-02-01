#!/bin/bash

docker exec sal python /home/docker/sal/manage.py loaddata /initial_db/initial_data.json
