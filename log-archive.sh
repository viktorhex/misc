#!/bin/bash

if [[ "$1" == "--input="* ]]; then

    INPUT_DIR="${1#--input=}"

    if [ -d "$INPUT_DIR" ]; then

        TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

        ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"

        tar -cvzf "$ARCHIVE_NAME" -C "$INPUT_DIR" .

        echo "Archive created: $ARCHIVE_NAME at $(date)" >> archive_log.txt

        echo "Archive '$ARCHIVE_NAME' has been created and logged successfully."
    else
        echo "Error: The directory '$INPUT_DIR' does not exist."
        exit 1
    fi
else
    echo "Usage: $0 --input=directory"
    exit 1
fi
