#!/bin/bash

apache2ctl start

exec "$@"
