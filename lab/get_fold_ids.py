#write fold_ids.txt with all ids in all families in folds, needs families.xlsx, t2.txt, req_util.py

from req_util import *
import json
from urllib3.exceptions import InsecureRequestWarning
from urllib3 import disable_warnings
disable_warnings(InsecureRequestWarning)

families_res = requests.get((base_url + all_families_url), verify=False)
families = json.loads(families_res.text)

tnums_res = requests.get((base_url + all_tnums_url), verify=False)
tnums = json.loads(tnums_res.text)

tnum_members = {}
for i in range(len(tnums)):
    tnum = tnums[i]["tnumber"]
    members_res = requests.get(tnum_url(tnum), verify=False)
    tnum_members[tnum] = json.loads(members_res.text)
    
genus_id_dict = {c['entry_id']:c['genus'] for v in tnum_members.values() for c in v}
tnum_id_dict = {c['entry_id']:k for k, v in tnum_members.items() for c in v}
pdb_ids = [item['entry_id'] for sublist in tnum_members.values() for item in sublist]

file_url = 'families.xlsx'
fam_xl = pd.ExcelFile(file_url)

from itertools import groupby

def flatten(l):
    return list(set([item for sublist in l for item in sublist]))

#get families for each fold
file_url = 't2.txt'
with open(file_url, 'r') as f:
    lines = f.readlines()
    fold_famlist = [list(group) for k, group in groupby(lines, lambda x: x != "\n") if k]
    fold_fams = {f[0].replace('\n', '').replace('/',' or '): flatten([l.split(' ', 1)[1].replace('\n', '').split(', ') for l in f[1:]]) for f in fold_famlist}

dfs = []
for k, v in fold_fams.items():
    df_dict = {}
    for f in v:
        try:
            sheet = fam_xl.parse(f)
            pdb_ids = sheet['id']
            df_dict[f] = list(pdb_ids)
        except Exception as e:
            print(e)
    try:
        df = pd.DataFrame.from_dict(df_dict, orient='index')
        df = df.transpose()
        dfs.append(df)
    except Exception as e:
            print(e)
        

fold_ids = []
for df in dfs:
    for c in df.columns:
        try:
            for v in df[c]: fold_ids.append(v)
        except:
            print(df)
fold_ids = list(set(fold_ids))
fold_ids.remove(None)

with open('fold_ids.txt', 'w') as f:
    for i in fold_ids:
        f.write(i + '\n')
