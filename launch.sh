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
  #   CALLER="0x34E3e542eDB4f7f4A0b41912961a7b46c972a2B4"
  #   FACTORY="0x48E516B34A1274f49457b9C6182097796D0498Cb"
  #   INIT_CODE_HASH="0x94d114296a5af85c1fd2dc039cdaa32f1ed4b0fe0868f02d888bfc91feb645d9"
  tmux new -s $session_name -d "cargo run --release $FACTORY $CALLER $INIT_CODE_HASH $i 4 15"

  echo "Tmux session '$session_name', crunching"
done
