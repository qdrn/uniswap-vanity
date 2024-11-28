#!/bin/bash

# Check if the number of sessions is passed as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <number_of_sessions>"
  exit 1
fi

# Validate that the argument is a positive integer
if ! [[ "$1" =~ ^[0-9]+$ ]]; then
  echo "Error: Argument must be a positive integer."
  exit 1
fi

# Number of sessions to create
num_sessions=$1

# Loop to create screen sessions
for ((i=0; i<num_sessions; i++)); do
  session_name="run$i"

  # Crunch
  nohup cargo run --release $FACTORY $CALLER $INIT_CODE_HASH $i 4 15 >> $session_name.log 2>&1 &

  echo "Session '$session_name', crunching"
done

apt install bc -y;

export N_CPUS_DIV_6=$(printf "%.0f" $(echo "$(nproc) / 6" | bc -l))
# Loop to create screen sessions
for ((i=0; i<N_CPUS_DIV_10; i++)); do
  session_name="run-cpu$i"

  # Crunch
  nohup cargo run --release $FACTORY $CALLER $INIT_CODE_HASH >> $session_name.log 2>&1 &

  echo "Session '$session_name', crunching"
done
