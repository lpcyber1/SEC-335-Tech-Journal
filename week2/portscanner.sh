#! /bin/bash

# Expanded on the script provided with ChatGPT

# Check if the correct number of arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <hosts_file> <ports_file> <output_csv>"
    exit 1
fi

# Input files
hosts_file="$1"
ports_file="$2"

# Output file
output_csv="$3"

# Function to check if a port is open
check_port() {
    host="$1"
    port="$2"
    (exec 3<>/dev/tcp/"$host"/"$port") &>/dev/null && echo "open" || echo "closed"
}

# Create CSV file header
echo "Host,Port,State" > "$output_csv"

# Loop through each host and port
while IFS= read -r host; do
    while IFS= read -r port; do
        # Check if port is open
        state=$(check_port "$host" "$port")

        # Write result to CSV
        echo "$host,$port,$state" >> "$output_csv"
    done < "$ports_file"
done < "$hosts_file"

echo "Scan completed. Results saved to '$output_csv'."
