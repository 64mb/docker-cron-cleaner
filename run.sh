#!/bin/bash

echo "load crontab config from file [/cleaner/crontab]..."

CRONTAB="$(cat /cleaner/crontab)"

CRONTAB=$(echo "${CRONTAB}" | sed 's|{CRON}|'"${CRON}"'|')

echo "cron: ${CRON}"

echo "${CRONTAB}" | /usr/bin/crontab -

# set environment variables from main process to cron
printenv >>/etc/environment

echo "cron loop..."

terminate() {
    echo "caught SIGTERM signal, exit..."
    kill -TERM "$CHILD_PROCESS" 2>/dev/null
}
trap terminate SIGTERM

/usr/sbin/crond -f -l 2 &

CHILD_PROCESS=$!
wait "$CHILD_PROCESS"
