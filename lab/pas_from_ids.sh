#!/bin/bash
mat="../../../../Applications/MATLAB_R2018b.app/bin/matlab"
filename='ids.txt'
n=1
while read line; do

echo "$line"
file_url="vpa_input/$line.pdb"
res=$(./pdb_info.pl $file_url)
echo "res: $res"
app_line=$(echo "|${res//[$'\n']}|")
app_line=T$(echo ${app_line##*\T})
app_line=${app_line::${#app_line}-1}
echo "app_line: $app_line"
script="clear all;clc;close all;$app_line;pdbid = '$line'"
echo $script | tee loadcapsid.m
$mat -nodisplay -nosplash -nodesktop -r "run('loadcapsid.m');run('franken_pas.m');exit;"
./group_pas.sh $line

n=$((n+1))
done < $filename
