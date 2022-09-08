#!/bin/sh

#go from nothing to pas, pass get_ids file which writes to second argument (id text file name)

#call python script to query viper for ids of parvviruses (getparv.py, get_fold_ids.py) write to txt which should be the same as second argument for this shell script (parv.txt, fold_ids.txt)
python3 $1

#download coords for all ids in parv.txt
python3 dl_ids.py $2
#unzip, extract coords and make icos for all coords in Downloads (calls pdb.sh, passes in directory dl)
python3 extract.py
#run franken and find_aas_exec on all the ids in parv.txt
python3 pas_ids.py $2
