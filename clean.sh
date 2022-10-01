#!/bin/bash

FOLDER=/recycle
DATE=$(date +'%Y-%m-%dT%H:%M:%S%z')

echo "[${DATE}] clean start"

echo "[${DATE}] clean keep: ${CLEAN_FILE_AFTER}"

# only bash date, not busybox date
# date -d "$(date -d '@0' +'%Y-%m-%d %H:%M:%S%z') +${CLEAN_FILE_AFTER}" +%s

CLEAN_SECONDS=${CLEAN_FILE_AFTER}

# sec, min, hour, day
if echo "${CLEAN_FILE_AFTER}" | grep -q "sec"; then
    CLEAN_SECONDS=$(($(echo "${CLEAN_FILE_AFTER}" | sed 's|sec||') * 1))
fi
if echo "${CLEAN_FILE_AFTER}" | grep -q "min"; then
    CLEAN_SECONDS=$(($(echo "${CLEAN_FILE_AFTER}" | sed 's|min||') * 60))
fi
if echo "${CLEAN_FILE_AFTER}" | grep -q "hour"; then
    CLEAN_SECONDS=$(($(echo "${CLEAN_FILE_AFTER}" | sed 's|hour||') * 60 * 60))
fi
if echo "${CLEAN_FILE_AFTER}" | grep -q "day"; then
    CLEAN_SECONDS=$(($(echo "${CLEAN_FILE_AFTER}" | sed 's|day||') * 60 * 60 * 24))
fi

# only bash find, not busybox find
# FILES=$(find ${FOLDER} -L -type f -not -newermt "-${CLEAN_SECONDS} seconds")

touch -d "@$(($(date +%s) - ${CLEAN_SECONDS}))" /recycler_ref
FILES=$(find ${FOLDER} ! -newer /recycler_ref -type f -follow)
rm -rf /recycler_ref

if [ ! -z "${FILES}" ]; then
    for F in ${FILES}; do
        if [ -z "${F}" ]; then
            continue
        fi

        DATE=$(date +'%Y-%m-%dT%H:%M:%S%z')
        echo "[${DATE}] clean ${F}"
        rm -rf "${F}"

        if [ ! -z "${CLEAN_THROTTLING}" ]; then
            echo "[${DATE}] clean sleep: ${CLEAN_THROTTLING} sec"
            sleep ${CLEAN_THROTTLING}
        fi
    done
fi

DATE=$(date +'%Y-%m-%dT%H:%M:%S%z')

echo "[${DATE}] clean complete"
