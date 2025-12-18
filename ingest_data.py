import os
import requests

URLS = [
    "https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-01.parquet",
    "https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-02.parquet"
]

# MONTHS = [("2024", "01"), ("2024", "02")]
# BASE_URL = "https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_{}-{}.parquet"

# Path mapped to Hives /opt/hive/data/warehouse/nyc_taxi
DEST_FOLDER = "data/nyc_taxi/parquet/"

def main():
    os.makedirs(DEST_FOLDER, exist_ok=True)

    for url in URLS:
        filename = url.split("/")[-1]
        save_path = os.path.join(DEST_FOLDER, filename)

        if os.path.exists(save_path):
            print(f"Already exists: {filename}")
            continue

        print(f"Downloading {filename}...")
        try:
            r = requests.get(url, stream=True)
            with open(save_path, 'wb') as f:
                for chunk in r.iter_content(chunk_size=8192):
                    f.write(chunk)
            print(f"Downloaded: {filename}")
        except Exception as e:
            print(f"Error downloading {filename}: {e}")

if __name__ == "__main__":
    main()