with open('ids.txt', 'r') as f:
    pdb_ids = [l.replace('\n', '') for l in f]

#run PA analysis and export to excel file

import sys
import matlab.engine
import subprocess
eng = matlab.engine.start_matlab()

for pdbid in pdb_ids:
    try:
        file_url = 'vpa_input/' + pdbid + '.pdb'
        res = subprocess.check_output(['pdb_info.pl', file_url])
        app_line = res.decode().split('\n')[-2]
    
        script = "clear all;\n" \
                 "clc;\n" \
                 "close all\n" \
                 "" + app_line + ";\n"\
                 "pdbid = '" + pdbid + "'\n"

        with open("loadcapsid.m","w") as f:
            f.write(script)

        eng.loadcapsid(nargout=0)
        eng.franken_pas(nargout=0)

        subprocess.call(['./group_pas.sh', pdbid])
    except Exception as e:
        print(e)

eng.quit()

