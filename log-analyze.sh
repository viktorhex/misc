#!/bin/bash

most_frequent_ip_addresses(){
  grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' $1 \
    | awk '{for (i = 1; i<= NF; i++) word[$i]++} END {for (w in word) print word[w], w}' \
    | sort -rn \
    | awk '{printf "%-20s %s requests\n", $2, $1}' \
    | awk 'NR <= 5'
}

#!/bin/bash

if [[ "$1" == "--input="* ]]; then

    INPUT="${1#--input=}"

    if [ -f "$INPUT" ]; then

        # Main execution
        echo "========== Log Analysis =========="
        echo -e "Most frequent IP adresses:"
        most_frequent_ip_addresses $INPUT

    else
        echo "Error: The directory '$INPUT' does not exist."
        exit 1
    fi
else
    echo "Usage: $0 --input=file"
    exit 1
fi
