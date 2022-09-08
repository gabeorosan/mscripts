#!/bin/sh
#accepts argument for dest folder; assumes capsids are in Downloads/
mv ../Downloads/*.vdb.gz $1/
for f in $1/*; do
    if [[ $f == *"gz"* ]]; then
        echo $f
        gunzip $f
    fi
done
for f in $1/*.vdb; do
    mv -- "$f" "${f%.vdb}.pdb"
done

cd $1
for f in *.pdb; do
    	if [[ $f != *"full"* ]]; then
    		echo $f
        	makeicos.pl $f
	fi
done
for f in *.pdb; do
    if [[ $f != *"xyz"* ]] && [[ $f != *"full"* ]]; then
    	echo $f
        extract_coords.pl $f
    fi
done
mv *.pdb ../Documents/MATLAB/
