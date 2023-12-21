import requests
import yaml
import base64


def get_apikey():
    with open('credentials.yml') as file:
        credentials = yaml.safe_load(file)
        return credentials.get('valueset', {}).get('apikey')


def retrieve_xml_data(oid, version):
    api_key = get_apikey()
    if not api_key:
        print("API key is not found in the YAML file.")
        return

    url = f"https://vsac.nlm.nih.gov/vsac/svs/RetrieveValueSet?id={oid}&version={version}"
    auth = base64.b64encode(f":{api_key}".encode()).decode('utf-8')
    headers = {
        'Content-Type': 'application/xml',
        'Authorization': f'Basic {auth}'
    }

    response = requests.get(url, headers=headers)

    if response.status_code == 200:
        return response.text
    else:
        print(f"Failed to retrieve data. Status code: {response.status_code}")
        return None


# Example usage:
value_set_id = "2.16.840.1.113883.3.117.1.7.1.258"
value_set_version = "MU2 Update 2015-05-01"

xml_data = retrieve_xml_data(value_set_id, value_set_version)
if xml_data:
    print(xml_data)
