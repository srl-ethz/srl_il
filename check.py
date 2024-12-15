import h5py
import os

def check_extrinsics_in_h5(file_path):
    """Check if the key 'oakd_front_view/extrinsics' exists in the HDF5 file."""
    try:
        # Open the .h5 file
        with h5py.File(file_path, 'r') as f:
            # Check if the key 'oakd_front_view/extrinsics' exists in the file
            if 'oakd_front_view/extrinsics' in f:
                print(f"Found 'oakd_front_view/extrinsics' in {file_path}")
                return True
            else:
                print(f"'oakd_front_view/extrinsics' NOT found in {file_path}")
                return False
    except Exception as e:
        print(f"Error reading {file_path}: {e}")
        return False

def check_directory_for_extrinsics(directory):
    """Check all .h5 files in the given directory for the 'oakd_front_view/extrinsics' key."""
    # Loop through all files in the directory
    for filename in os.listdir(directory):
        file_path = os.path.join(directory, filename)
        
        # Only process .h5 files
        if file_path.endswith('.h5') and os.path.isfile(file_path):
            check_extrinsics_in_h5(file_path)

if __name__ == "__main__":
    # Replace with your desired directory path
    directory = input("Enter the directory path to check: ")
    
    # Check if the directory exists
    if os.path.isdir(directory):
        check_directory_for_extrinsics(directory)
    else:
        print(f"Error: The directory {directory} does not exist.")
