#!/bin/bash

# SCRIPT STILL HAS ISSUES

blabla # exit with error

# Set the working directory
WORKDIR="/home/$(whoami)/Workspaces/rwr_workspace/src/srl_il/"
cd "$WORKDIR" || exit 1  # Exit if the directory doesn't exist

# Set WANDB mode to online (or modify as needed)
export WANDB_MODE=online

# Log the start of the script
echo "Starting pipeline runs in $WORKDIR"
echo "WANDB_MODE is set to $WANDB_MODE"

# Function to validate arguments
validate_mode() {
  if [[ "$#" -ne 1 ]]; then
    echo "Error: Exactly one argument is required ('sequential' or 'parallel')."
    exit 1
  fi

  if [[ "$1" != "sequential" && "$1" != "parallel" ]]; then
    echo "Error: Invalid argument. Use 'sequential' or 'parallel'."
    exit 1
  fi
}

# Validate the provided argument
validate_mode "$@"

# Define the commands to run
COMMANDS=(
  "python3 scripts/run_pipeline.py --config-name=imitation_learning_orca_act_wrist8"
  "python3 scripts/run_pipeline.py --config-name=imitation_learning_orca_act_wrist16"
  # "python3 scripts/run_pipeline.py --config-name=imitation_learning_orca_act_wrist32"
)

# Run commands based on the mode
MODE="$1"
if [[ "$MODE" == "sequential" ]]; then
  echo "Running commands sequentially..."
  for CMD in "${COMMANDS[@]}"; do
    $CMD || exit 1
  done
elif [[ "$MODE" == "parallel" ]]; then
  echo "Running commands in parallel..."
  for CMD in "${COMMANDS[@]}"; do
    $CMD &
  done
  # Wait for all parallel processes to finish
  wait
fi

# Log the completion of the script
echo "All pipelines completed successfully!"








# #!/bin/bash

# # Set the working directory
# WORKDIR="/home/ubuntu/dev/srl_il/"
# cd "$WORKDIR" || exit 1  # Exit if the directory doesn't exist

# # Set WANDB mode to online (or modify as needed)
# export WANDB_MODE=online

# # Log the start of the script
# echo "Starting pipeline runs in $WORKDIR"
# echo "WANDB_MODE is set to $WANDB_MODE"

# # Run the commands either sequentially (end with "|| exit 1") or in parallel (end with "&")
# echo "Running: imitation_learning_orca_act_small"
# python3 scripts/run_pipeline.py --config-name=imitation_learning_orca_act_small || exit 1

# echo "Running: imitation_learning_orca_act_big"
# python3 scripts/run_pipeline.py --config-name=imitation_learning_orca_act_big || exit 1

# echo "Running: imitation_learning_orca_act_both"
# python3 scripts/run_pipeline.py --config-name=imitation_learning_orca_act_both || exit 1

# # Log the completion of the script
# echo "All pipelines completed successfully!"
