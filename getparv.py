from urllib3.exceptions import InsecureRequestWarning
from urllib3 import disable_warnings

disable_warnings(InsecureRequestWarning)

import requests
import json
from req_util import *

genuses_res = requests.get((base_url + all_genuses_url), verify=False)
genuses = json.loads(genuses_res.text)
families_res = requests.get((base_url + all_families_url), verify=False)
families = json.loads(families_res.text)

#get lowest resolution structure for each genus in parvoviridae
family_members = {}
for i in range(len(families)):
    fam = families[i]["family"]
    members_res = requests.get(family_url(fam), verify=False)
    family_members[fam] = json.loads(members_res.text)

parv_members = family_members['Parvoviridae']

pdb_ids = [v['entry_id'] for v in parv_members]
