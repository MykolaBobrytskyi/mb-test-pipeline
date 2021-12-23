import os
import json
import requests
from flask import *
from kubernetes import client, config
from kubernetes.client import configuration
from prettytable import PrettyTable
from requests.auth import HTTPBasicAuth
from pprint import pprint

def secretsList(ns, kubeconfig):
    try:
        config.load_kube_config(config_file=kubeconfig)
    except:
        config.load_incluster_config()

    apps_v1 = client.CoreV1Api()

    table = PrettyTable()
    table.field_names = ["NameSpace", "Name", "Type"]
    api_response = apps_v1.list_namespaced_secret(ns)
    for item in api_response.items:
        table.add_row([item.metadata.namespace,
                       item.metadata.name,
                       item.type])
    return table

app = Flask(__name__, static_url_path='/show-secrets/static')
nameSpace = os.getenv('NAMESPACE')
kubeConfig = os.getenv('K8SCONFIG')
appDebug = os.getenv('ENABLE_FLASK_DEBUG', False)

@app.route("/")
def ok_print():
    return "OK"

@app.route("/show-secrets")
def show_deploys_tables():
    return render_template('./view.html',page_title="Secrets",resource_type="Secrets",tables=[secretsList(nameSpace, kubeConfig).get_html_string(attributes={"class":"secrets"})],
    titles = ['secrets'])

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=appDebug)
