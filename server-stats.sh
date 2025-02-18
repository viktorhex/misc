#!/bin/bash

get_cpu_usage(){
  mpstat 1 1 | awk '/Average:/ {print 100 - $12"%"}'
}

get_memory_usage() {
  free -h --mega | awk 'NR==2{printf "Total Memory: %s, Used Memory: %s, Free Memory: %s\n", $2, $3, $4}'
}

get_disk_usage() {
  df -h --total | awk 'END{printf "Total Disk Space: %s, Used Disk Space: %s, Free Disk Space: %s\n", $2, $3, $4}'
}

get_top_cpu_processes() {
    echo "PID COMMAND %CPU"
    ps aux --sort=-%cpu | head -n 6 | tail -n 5 | awk '{print $2, $11, $3"%"}'
}

get_top_mem_processes() {
    echo "PID COMMAND %MEM"
    ps aux --sort=-%mem | head -n 6 | tail -n 5 | awk '{print $2, $11, $4"%"}'
}

# Main execution
echo "========== System Usage Report =========="
echo -e "\nTotal CPU Usage:"
get_cpu_usage

echo -e "\nTotal Memory Usage (Free vs Used):"
get_memory_usage

echo -e "\nTotal Disk Usage (Free vs Used):"
get_disk_usage

echo -e "\nTop 5 Processes by CPU Usage:"
get_top_cpu_processes

echo -e "\nTop 5 Processes by Memory Usage:"
get_top_mem_processes
