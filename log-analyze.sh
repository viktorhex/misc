#!/bin/bash

most_frequent_ip_addresses(){
  grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' $1 \
    | get_freq_and_sort \
    | get_top_5_formatted
}

get_freq_and_sort(){
  awk '{for (i = 1; i<= NF; i++) word[$i]++} END {for (w in word) print word[w], w}' \
    | sort -rn
}

get_top_5_formatted(){
  awk '{printf "%-25s %s requests\n", $2, $1}' \
    | awk 'NR <= 5'
}

most_frequent_paths(){
  grep -oP '"\w+ \K[^?"]+?(?=\s+HTTP)' $1 \
    | get_freq_and_sort \
    | get_top_5_formatted
}

#!/bin/bash

if [[ "$1" == "--input="* ]]; then

    INPUT="${1#--input=}"

    if [ -f "$INPUT" ]; then

        # Main execution
        echo "========== Log Analysis =========="
        echo -e "\nMost frequent IP adresses:"
        most_frequent_ip_addresses $INPUT

        echo -e "\nMost frequent paths:"
        most_frequent_paths $INPUT

    else
        echo "Error: The directory '$INPUT' does not exist."
        exit 1
    fi
else
    echo "Usage: $0 --input=file"
    exit 1
fi
