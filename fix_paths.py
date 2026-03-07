import os
import shutil

back_dir = 'back'
files = os.listdir(back_dir)

for file in files:
    if '\\' in file:
        old_path = os.path.join(back_dir, file)
        # Convert backslashes to forward slashes
        new_rel_path = file.replace('\\', '/')
        new_full_path = os.path.join(back_dir, new_rel_path)
        
        # Create directories if they don't exist
        os.makedirs(os.path.dirname(new_full_path), exist_ok=True)
        
        # Move file
        shutil.move(old_path, new_full_path)
        print(f"Moved {old_path} to {new_full_path}")

