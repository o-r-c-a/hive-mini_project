import os
import shutil
import zipfile
from dotenv import load_dotenv
import kagglehub
# Load variables from .env file
load_dotenv()

def main():
    target_folder = "data/nyc_taxi/csv/"
    target_file = "taxi_tripdata.csv"
    destination_path = os.path.join(target_folder, target_file)

    os.makedirs(target_folder, exist_ok=True)

    print("Downloading file...")
    # 1. Download the file - kaggle might send a zip
    cached_path = kagglehub.dataset_download(
        "anandaramg/taxi-trip-data-nyc",
        path="taxi_tripdata.csv"
    )
    print(f"Cached at: {cached_path}")

    # 2. Check if the file is actually a ZIP archive
    if zipfile.is_zipfile(cached_path):
        print("Detected ZIP format. Extracting...")
        with zipfile.ZipFile(cached_path, 'r') as zip_ref:
            zip_ref.extractall(target_folder)

        # If the extracted file name matches our target, we are good.
        print("Extraction complete.")
    else:
        # It's a regular file, just move it
        print("File is uncompressed. Moving...")
        shutil.copy(cached_path, destination_path)
    print(f"File ready at: {destination_path}")

if __name__ == "__main__":
    main()