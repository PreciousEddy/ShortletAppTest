import requests
import os
from dotenv import load_dotenv

load_dotenv()

PORT_API_BASE_URL = "https://api.getport.io/v1"
PORT_API_KEY =  os.getenv("PORT_API_KEY")

headers = {
    "Authorization": f"Bearer {PORT_API_KEY}",
    "Content-Type": "application/json"
}


def fetch_services():
    response = requests.get(f"{PORT_API_BASE_URL}/blueprints/service/entities", headers=headers)
    response.raise_for_status()
    return response.json()


def fetch_frameworks():
    response = requests.get(f"{PORT_API_BASE_URL}/blueprints/framework/entities", headers=headers)
    response.raise_for_status()
    return response.json()


def update_service(service_id, eol_count):
    data = {
        "properties": {
            "number_of_eol_packages": eol_count
        }
    }
    response = requests.patch(f"{PORT_API_BASE_URL}/blueprints/service/entities/{service_id}", json=data, headers=headers)
    response.raise_for_status()
    return response.json()


def main():
    services = fetch_services()
    frameworks = fetch_frameworks()

    for service in services['entities']:
        service_id = service["identifier"]
        used_frameworks = service["relations"]["used_framework"]

        eol_count = 0
        for framework_id in used_frameworks:
            framework = next((f for f in frameworks['entities'] if f["identifier"] == framework_id), None)
            if framework and framework["properties"]["state"] == "EOL":
                eol_count += 1

        update_service(service_id, eol_count)
        print(f"Updated service {service_id} with {eol_count} EOL packages.")
        

if __name__ == "__main__":
    main()